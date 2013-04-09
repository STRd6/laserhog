SweepMovable = (I, self) ->
  Object.reverseMerge I,
    positionRemainder: Point(0, 0)

  self.unbind ".Movable"

  sweepMove: (elapsedTime) ->
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
