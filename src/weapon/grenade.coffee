Weapon.Grenade = (I={}) ->
  Object.reverseMerge I,
    sprite: "grenade"
    cooldown: 0
    cooldownDelay: 0.5
    recoil: 0

  self = Weapon(I)

  self.on "fire", (direction) ->
    center = I.owner.centeredBounds()

    engine.add "Grenade",
      velocity: direction.scale(900)
      owner: I.owner
      x: center.x
      y: center.y

  return self
