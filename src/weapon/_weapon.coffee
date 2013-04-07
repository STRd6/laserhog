Weapon = (I={}) ->
  Object.reverseMerge I,
    cooldown: 0
    cooldownDelay: 0.5
    recoil: 0

  self = GameObject(I).extend
    shoot: (direction) ->
      # Cooldowns
      return if I.cooldown
      I.cooldown += I.cooldownDelay

      # Sound
      Sound.play(I.sound) if I.sound

      self.trigger "fire", direction

      # Recoil
      I.owner.addImpulse direction.scale(-I.recoil)

    pickup: (owner) ->
      I.owner = owner

  self.cooldown "cooldown"

  return self
