Grenade = (I={}) ->
  Object.reverseMerge I,
    acceleration: Point(0, 1800)
    owner: null
    fuse: 1
    width: 6
    height: 6
    sprite: "grenade"

  self = GameObject(I)

  computeNormal = (other) ->
    {x, y, xw, yw} = other.centeredBounds()

    # Not really correct for rectangles
    delta = other.position().subtract(self.position())

    # Correcting because these are non-circles
    delta.x = delta.x / xw
    delta.y = delta.y / yw

    # Squarifying it
    if delta.x.abs() > delta.y.abs()
      delta.y = 0
    else
      delta.x = 0

    delta.norm()

  self.on "update", (dt) ->
    if I.fuse <= 0
      self.destroy()

    Collision.collide ".solid", self, (wall) ->
      return if wall is I.owner

      normal = computeNormal(wall)
      projection = I.velocity.dot(normal)

      return if projection <= 0

      recoil = normal.scale(-1.5 * projection)
      I.velocity = I.velocity.add(recoil)

  self.on "destroy", ->
    engine.add "Explosion",
      x: I.x
      y: I.y

  self.cooldown "fuse"

  return self
