Player.Input = (I, self) ->
  processInput: (dt) ->
    # Reset State
    # TODO Cooldowns?
    I.shielding = false
    I.shooting = false

    acc = 750 #(pixels / s^2)
    dec = 3000 #(pixels / s^2)
    friction = 2000 #(pixels / s^2)

    jumpImpulse = -600

    p = self.controllerPosition()

    # Can only jump or shield from ground
    unless I.jumping or I.falling
      if self.actionDown "jump"
        I.jumping = true
        I.velocity.y = jumpImpulse
      else if self.actionDown "shield"
        if I.shieldStrength > 0
          I.shielding = true
          I.shieldStrength -= 1
        else
          I.disabled = 3

    unless I.shielding or I.disabled
      I.shieldStrength = I.shieldStrength.approach(I.shieldStrengthMax, 0.25)

      # Move around based on controller
      if sign = p.x.sign()
        if I.velocity.x.sign() != sign
          I.velocity.x += dec * sign * dt
        else
          I.velocity.x += acc * sign * dt

        I.lastDirection = sign

      unless self.actionDown "jump"
        I.jumping = false

      I.shooting = self.actionDown "shoot"

    if I.shielding or !(p.x)
      # TODO get friction from ground
      I.velocity.x = I.velocity.x.approach(0, friction * dt) # Friction
