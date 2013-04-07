Weapon.Railgun = (I={}) ->
  Object.reverseMerge I,
    sprite: "railgun"
    cooldownDelay: 0.5
    sound: "zapgun1"
    recoil: 240

  self = Weapon(I)

  self.on "fire", (direction) ->
    center = I.owner.centeredBounds()

    engine.add "Beam",
      origin: center
      direction: direction
      owner: I.owner
      color: I.owner.I.color

  return self
