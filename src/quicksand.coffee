Quicksand = (I={}) ->
  Object.reverseMerge I,
    sprite: "sand"

  self = GameObject(I)

  self.include "FlowTile"

  return self
