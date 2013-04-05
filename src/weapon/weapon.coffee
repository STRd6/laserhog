Weapon = (I={}) ->
  Object.reverseMerge I,
    sprite: "railgun"
    cooldown: 0
    cooldownDelay: 0.5
    sound: "zapgun1"
    recoil: 240

  self = GameObject(I).extend
    shoot: (direction, owner) ->
      return if I.cooldown

      I.cooldown += I.cooldownDelay

      Sound.play(I.sound)

      center = owner.centeredBounds()
      engine.add "Beam",
        origin: center
        direction: direction
        owner: owner
        color: owner.I.color

      # Add Recoil
      owner.addImpulse direction.scale(-I.recoil)

  self.cooldown "cooldown"

  return self
