Player.Physics = (I, self) ->
  VELOCITY_MAX_X = 500

  PHYSICS =
    platform: (dt) ->
      if I.jumping
        I.velocity.y += I.gravity.scale(0.5).y * dt
      else if I.falling
        I.velocity.y += I.gravity.y * dt

      I.velocity.x = I.velocity.x.clamp(-VELOCITY_MAX_X, VELOCITY_MAX_X)

  self.physics = PHYSICS.platform

  return {}
