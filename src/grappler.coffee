Grappler = (I, self) ->
  Object.reverseMerge I,
    grappleStart: null
    grappleDirection: null
    grappleAttached: null
    grappleLength: 0
    grappleRate: 1800

  checkGrappleHits = ->
    nearestHit = engine.rayCollides
      source: self.position()
      direction: I.grappleDirection
      sourceObject: self
      selector: ".solid"

    if nearestHit
      if I.grappleStart.distance(nearestHit) < I.grappleLength
        I.grappleAttached = nearestHit

  grappleTargetDirection = ->
    I.aimDirection

  grapple = (elapsedTime) ->
    I.grappleStart ||= self.position()
    I.grappleDirection ||= grappleTargetDirection()
    I.grappleLength += I.grappleRate * elapsedTime

  ungrapple = ->
    I.grappleStart = null
    I.grappleDirection = null
    I.grappleAttached = null
    I.grappleLength = 0

  grappleDirection = ->
    if I.grappleAttached
      I.grappleAttached.subtract(self.position())
    else
      I.grappleDirection

  self.bind 'afterTransform', (canvas) ->
    if I.grappleAttached
      canvas.drawLine
        color: "red"
        start: self.position()
        end: I.grappleAttached

    else if I.grappleDirection
      canvas.drawLine
        color: "white"
        start: self.position()
        end: self.position().add(I.grappleDirection.norm(I.grappleLength))

  grapplePhysics: (elapsedTime) ->
    if I.grappling
      if I.grappleAttached
        # Apply grappling hook force
        direction = grappleDirection()

        # Elasticity
        length = Math.min(direction.length() / 4, 8)

        force = direction.norm(length * 2000)

        I.velocity.x += force.x * elapsedTime
        I.velocity.y += force.y * elapsedTime
      else
        grapple(elapsedTime)
        checkGrappleHits()
    else
      ungrapple()
