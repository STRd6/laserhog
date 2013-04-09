Player = (I={}) ->
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
    destructable: true
    disabled: 0
    falling: true
    gravity: Point(0, 3600)
    height: 24
    invulnerable: Player.INVULNERABILITY_DURATION
    jumping: false
    lastDirection: 1
    mobile: true
    opaque: true
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

  self = Base(I)

  self.cooldown "disabled"
  self.cooldown "invulnerable"

  self.on "update", (elapsedTime) ->
    if I.disabled
      I.velocity = I.velocity.add(Point.fromAngle(Random.angle()).scale(rand(4)))

    if engine.collides(self.bounds(0, 1), self)
      I.falling = false
    else
      I.falling = true

    self.processInput(elapsedTime)
    self.grapplePhysics(elapsedTime)
    self.physics(elapsedTime)
    self.sweepMove(elapsedTime)

    if I.y >= ARENA.height + 500
      self.destroy()

  self.include "Grappler"
  self.include "SweepMovable"
  self.include "Player.Controller"
  self.include "Player.HUD"
  self.include "Player.Events"
  self.include "Player.Input"
  self.include "Player.Physics"
  self.include "Player.Shield"
  self.include "Player.Weapons"

  self

Player.INVULNERABILITY_DURATION = 1
