Player.Input = (I, self) ->
  processInput: (dt) ->
    # Reset State
    # TODO Cooldowns?
    I.shielding = false
    I.shooting = false

    acc = 300 #(pixels / s^2)
    dec = 3000 #(pixels / s^2)
    friction = 1000 #(pixels / s^2)

    jumpImpulse = -600

    p = self.controllerPosition()

    # Can only jump or shield from ground
    unless I.jumping or I.falling
      # TODO Name actions rather than buttons
      if self.actionDown "A"
        I.jumping = true
        I.velocity.y = jumpImpulse
      else if self.actionDown "B"
        if I.shieldStrength > 0
          I.shielding = true
          I.shieldStrength -= 1
        else
          I.disabled = 3

    unless I.shielding or I.disabled
      I.shieldStrength = I.shieldStrength.approach(I.shieldStrengthMax, 0.25)

      if sign = p.x.sign()
        if I.velocity.x.sign() != sign
          debugger
          I.velocity.x += dec * sign * dt
        else
          # Move around based on controller
          I.velocity.x += acc * sign * dt

        I.lastDirection = sign

      unless self.actionDown("A")
        I.jumping = false

      I.shooting = self.actionDown("C")

    if I.shielding or !(p.x)
      I.velocity.x = I.velocity.x.approach(0, friction * dt) # Friction
