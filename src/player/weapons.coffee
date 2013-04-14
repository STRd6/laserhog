Player.Weapons = (I, self) ->
  Object.reverseMerge I,
    aimDirection: Point(1, 0)
    activeWeapon: "Railgun"

  weaponChoices = [
    "Grenade"
    "Railgun"
  ]

  weapons = weaponChoices.eachWithObject {}, (weaponName, choices) ->
    weapon = choices[weaponName] = Weapon[weaponName]()
    weapon.pickup self

  changeWeapon = (delta) ->
    index = weaponChoices.indexOf(I.activeWeapon) + delta

    I.activeWeapon = weaponChoices.wrap(index)

  self.on "update", (dt) ->
    # TODO: should all weapons cooldown even when not active?
    self.activeWeapon()?.trigger "update", dt

  self.on "update", ->
    # Weapon switching
    if self.actionPressed("nextWeapon")
      changeWeapon(+1)

    if self.actionPressed("previousWeapon")
      changeWeapon(-1)

    # Aiming
    p = self.controllerPosition().norm()

    unless p.equal(Point.ZERO)
      I.aimDirection = p

    if I.shooting
      self.activeWeapon()?.shoot(I.aimDirection, self)

  self.on "draw", (canvas) ->
    angle = I.aimDirection.angle()

    if angle.abs() > Math.TAU / 4
      scale = Matrix.scale(-1, 1)
      angle = Math.TAU / 2 - angle
    else
      scale = Matrix.IDENTITY

    canvas.withTransform scale, (canvas) ->
      canvas.withTransform Matrix.rotation(angle), (canvas) ->
        self.activeWeapon()?.trigger "draw", canvas

  activeWeapon: ->
    weapons[I.activeWeapon]
