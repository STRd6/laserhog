Quicksand = (I={}) ->
  Object.reverseMerge I,
    sprite: "sand"
    solid: true

  self = GameObject(I)

  self.include "FlowTile"

  return self
