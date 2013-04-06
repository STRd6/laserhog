Player.Events = (I, self) ->
  self.on 'destroy', ->
    Sound.play("explode#{rand(4)}")

    # Respawn
    engine.add Object.extend({}, I,
      x: [0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448, 480, 512, 544, 576, 608].rand()
      y: [0, -2 * I.height, -4 * I.height, -6 * I.height, -8 * I.height, -10 * I.height].rand()
      velocity: Point(0, 0)
      disabled: 0
      invulnerable: Player.INVULNERABILITY_DURATION
      shieldStrength: I.shieldStrengthMax
    )

    I.active = false

  self.on "beamHit", ({ricochet}) ->
    if I.shielding or I.invulnerable
      ricochet()

      # TODO: Balance numbers
      I.shieldStrength -= 5
    else
      self.destroy()

  return {}
