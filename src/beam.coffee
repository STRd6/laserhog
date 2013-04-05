Beam = (I={}) ->
  Object.reverseMerge I,
    origin: Point.ZERO
    direction: Point(1, 0)
    owner: null
    segments: []
    duration: 0.1
    width: 0
    height: 0

  self = Base(I)

  fireBeam = (sourcePoint, direction, sourceObject) ->
    if nearestHit = engine.rayCollides(sourcePoint, direction, sourceObject)
      endPoint = nearestHit
      hitObject = nearestHit.object

    if endPoint
      # TODO
      # laserParticleEffects(endPoint)
    else
      endPoint = direction.norm().scale(1500).add(sourcePoint)

    I.segments.push [sourcePoint, endPoint]

    if hitObject?.I
      if hitObject.I.shielding || hitObject.I.invulnerable
        fireBeam(endPoint, Point.fromAngle(Random.angle()), hitObject)
        hitObject.I.shieldStrength -= 5
      else if hitObject.I.destructable
        hitObject.destroy()

  self.on "create", ->
    fireBeam(I.origin, I.direction, I.owner)

  self.on "overlay", (canvas) ->
    I.segments.each ([start, end]) ->
      canvas.drawLine
        color: I.color
        start: start
        end: end
        width: 2

  return self
