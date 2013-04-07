Explosion = (I={}) ->
  Object.reverseMerge I,
    owner: null
    fuse: 1
    radius: 10
    expansionSpeed: 600 #pixes/second
    duration: 0.25
    color: "#F0F"

  self = GameObject(I)

  self.on "update", (dt) ->
    I.radius += I.expansionSpeed * dt

  return self
