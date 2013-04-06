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
    nearestHit = engine.rayCollides
      source: sourcePoint
      direction: direction
      sourceObject: sourceObject
      selector: ".solid"

    if nearestHit
      endPoint = nearestHit
      hitObject = nearestHit.object

    if endPoint
      # TODO
      # laserParticleEffects(endPoint)
    else
      endPoint = direction.norm().scale(1500).add(sourcePoint)

    I.segments.push [sourcePoint, endPoint]

    hitObject?.trigger "beamHit",
      ricochet: ->
        fireBeam(endPoint, Point.fromAngle(Random.angle()), hitObject)

  self.on "create", ->
    fireBeam(I.origin, I.direction, I.owner)

  self.unbind "draw"
  self.on "afterTransform", (canvas) ->
    I.segments.each ([start, end]) ->
      canvas.drawLine
        color: I.color
        start: start
        end: end
        width: 2

  return self
