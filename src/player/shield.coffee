Player.Shield = (I={}, self) ->
  MAX_SHIELD = 2 # seconds of shield

  Object.extend I,
    shielding: false
    shieldRecovery: 0.25
    shieldStrength: MAX_SHIELD
    shieldStrengthMax: MAX_SHIELD

  shieldGradient = (strength, context) ->
    radgrad = context.createRadialGradient(4, -4, 0, 0, 0, 16)

    a = 0.75 * strength / I.shieldStrengthMax
    edgeAlpha = 0.75 + 0.25 * strength / I.shieldStrengthMax

    radgrad.addColorStop(0, "rgba(255, 255, 255, #{a})")

    radgrad.addColorStop(0.25, "rgba(0, 255, 0, #{a})")
    radgrad.addColorStop(0.9, "rgba(0, 255, 0, #{a})")

    radgrad.addColorStop(1, "rgba(0, 200, 0, #{edgeAlpha})")

    radgrad

  self.on "update", (dt) ->
    if I.shielding
      I.shieldStrength -= 1 * dt
    else
      I.shieldStrength = I.shieldStrength.approach(I.shieldStrengthMax, I.shieldRecovery * dt)

  self.on "draw", (canvas) ->
    if I.shielding
      canvas.drawCircle
        x: 0
        y: 0
        radius: 16
        color: shieldGradient(I.shieldStrength, canvas.context())

  return {}
