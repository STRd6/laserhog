Block = (I={}) ->
  Object.reverseMerge I,
    color: "tan"
    solid: true
    width: 32
    height: 32
    sprite: "rock"

  self = Base(I)

  self.include NineSlice

  return self
