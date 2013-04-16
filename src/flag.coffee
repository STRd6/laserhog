Flag = (I={}) ->
  Object.reverseMerge I,
    sprite: "flag_red"

  self = GameObject(I).extend
    pickup: (carrier) ->
      I.heldBy = carrier

  self.on "update", ->
    if I.heldBy
      self.position I.heldBy.position()

  return self
