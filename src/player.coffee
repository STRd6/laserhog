Player = (I={}) ->
  MAX_SHIELD = 64
  INVULNERABILITY_DURATION = 1
  PLAYER_COLORS = [
    "#00F"
    "#F00"
    "#0F0"
    "#FF0"
    "orange"
    "#F0F"
    "#0FF"
  ]

  Object.reverseMerge I,
    acceleration: Point(0, 0)
    controller: 0
    cooldown: 0
    destructable: true
    disabled: 0
    falling: true
    gravity: Point(0, 3600)
    height: 24
    invulnerable: INVULNERABILITY_DURATION
    jumping: false
    lastDirection: 1
    mobile: true
    opaque: true
    positionRemainder: Point(0, 0)
    recoil: 240
    score: 0
    shielding: false
    shieldStrength: MAX_SHIELD
    shieldStrengthMax: MAX_SHIELD
    shooting: false
    speed: 6
    solid: true
    velocity: Point(0, 0)
    width: 16

  # Cast acceleration and velocity to points
  I.acceleration = Point(I.acceleration.x, I.acceleration.y)
  I.velocity = Point(I.velocity.x, I.velocity.y)

  # I.sprite = Sprite.fromPixieId(12525)
  I.sprite = null

  I.color = PLAYER_COLORS[I.controller]

  beams = []

  fireBeam = (sourcePoint, direction, sourceObject) ->
    if nearestHit = engine.rayCollides(sourcePoint, direction, sourceObject)
      endPoint = nearestHit
      hitObject = nearestHit.object

    if endPoint
      # TODO
      # laserParticleEffects(endPoint)
    else
      endPoint = direction.norm().scale(1000).add(sourcePoint)

    beams.push [sourcePoint, endPoint]

    if hitObject?.I
      if hitObject.I.shielding || hitObject.I.invulnerable
        fireBeam(endPoint, Point.fromAngle(Random.angle()), hitObject)
        hitObject.I.shieldStrength -= 5
      else if hitObject.I.destructable
        if hitObject == self
          I.score -= 1
        else if hitObject.I.class == I.class
          I.score += 1

        hitObject.destroy()

  shieldGradient = (strength, context) ->
    radgrad = context.createRadialGradient(4, -4, 0, 0, 0, 16)

    a = 0.75 * strength / I.shieldStrengthMax
    edgeAlpha = 0.75 + 0.25 * strength / I.shieldStrengthMax

    radgrad.addColorStop(0, "rgba(255, 255, 255, #{a})")

    radgrad.addColorStop(0.25, "rgba(0, 255, 0, #{a})")
    radgrad.addColorStop(0.9, "rgba(0, 255, 0, #{a})")

    radgrad.addColorStop(1, "rgba(0, 200, 0, #{edgeAlpha})")

    radgrad

  self = GameObject(I).extend
    solid: ->
      true

    illuminate: (canvas) ->
      center = self.centeredBounds()

      if I.invulnerable
        center.radius = Math.sin(I.age * Math.TAU / 36) * 16 + 24
      else if I.disabled
        center.radius = rand(16) + 16
      else
        center.radius = 32

      if I.shielding || I.disabled || I.invulnerable
        canvas.fillCircle(center.x, center.y, center.radius, Light.radialGradient(center, canvas.context()))

      beams.each (beam) ->
        canvas.strokeColor("#000")
        canvas.drawLine(beam[0].x, beam[0].y, beam[1].x, beam[1].y, 2.25)

  self.unbind ".Movable"

  self.on "draw", (canvas) ->
    if I.shielding
      canvas.drawCircle
        x: 0
        y: 0
        radius: 16
        color: shieldGradient(I.shieldStrength, canvas.context())

  self.on "overlay", (canvas) ->
    beams.each (beam) ->
      canvas.drawLine
        color: I.color
        start: beam[0]
        end: beam[1]
        width: 2

  self.cooldown "cooldown"
  self.cooldown "disabled"
  self.cooldown "invulnerable"

  self.on "update", (elapsedTime) ->
    beams = []

    if I.disabled
      I.velocity = I.velocity.add(Point.fromAngle(Random.angle()).scale(rand(4)))

    if engine.collides(self.bounds(0, 1), self)
      I.falling = false
    else
      I.falling = true

    self.physics(elapsedTime)
    self.processInput(elapsedTime)

    # Store distance remainders
    xDist = I.velocity.x * elapsedTime + I.positionRemainder.x
    truncatedDistance = xDist.truncate()
    I.positionRemainder.x = xDist - truncatedDistance

    #TODO Reduct the # of calls to collides
    truncatedDistance.abs().times ->
      if !engine.collides(self.bounds(truncatedDistance.sign(), 0), self)
        I.x += I.velocity.x.sign()
      else
        I.velocity.x = 0

    #TODO Reduct the # of calls to collides
    yMoves = (I.velocity.y * elapsedTime).abs()
    yMoves.times ->
      if !engine.collides(self.bounds(0, I.velocity.y.sign()), self)
        I.y += I.velocity.y.sign()
      else
        I.velocity.y = 0
        I.jumping = false

    if I.shooting
      shootX = 0
      shootY = 0

      p = self.controllerPosition().norm()

      if p.x is 0 and p.y is 0
        shootDirection = Point(I.lastDirection, 0)
      else
        shootDirection = p

    if shootDirection && (I.cooldown == 0)
      I.cooldown += 0.5

      Sound.play("laser")
      I.velocity = I.velocity.add(shootDirection.norm().scale(-I.recoil))

      center = self.centeredBounds()
      fireBeam(center, shootDirection, self)

    # TODO Disabled particles

    I.x = I.x.clamp(I.width/2, App.width - I.width/2)

    if I.y >= App.height + 100
      self.destroy()

  self.on 'destroy', ->
    Sound.play("hit")

    # Respawn
    engine.add Object.extend({}, I,
      x: [0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448, 480, 512, 544, 576, 608].rand()
      y: [0, -2 * I.height, -4 * I.height, -6 * I.height, -8 * I.height, -10 * I.height].rand()
      velocity: Point(0, 0)
      disabled: 0
      invulnerable: INVULNERABILITY_DURATION
      shieldStrength: I.shieldStrengthMax
    )

    I.active = false

  self.include "Player.Controller"
  self.include "Player.HUD"
  self.include "Player.Input"
  self.include "Player.Physics"

  self
