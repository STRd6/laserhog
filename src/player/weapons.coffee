Player.Weapons = (I, self) ->
  Object.reverseMerge I,
    aimDirection: Point(1, 0)
    weapon: Weapon()

  self.on "update", (dt) ->
    I.weapon?.trigger "update", dt

  self.on "update", ->
    p = self.controllerPosition().norm()

    unless p.equal(Point.ZERO)
      I.aimDirection = p

    if I.shooting
      I.weapon.shoot(I.aimDirection, self)

  self.on "draw", (canvas) ->
    angle = I.aimDirection.angle()

    if angle.abs() > Math.TAU / 4
      scale = Matrix.scale(-1, 1)
      angle = Math.TAU / 2 - angle
    else
      scale = Matrix.IDENTITY

    canvas.withTransform scale, (canvas) ->
      canvas.withTransform Matrix.rotation(angle), (canvas) ->
        I.weapon?.trigger "draw", canvas

  return {}
