FlowTile = (I, self) ->
  Object.reverseMerge I,
    flowVelocity: Point(0, 2)

  self.unbind ".Drawable"

  self.on "draw", (canvas) ->
    sprite = self.sprite()

    offsetX = (I.flowVelocity.x * I.age).floor().mod(sprite.height)
    offsetY = (I.flowVelocity.y * I.age).floor().mod(sprite.height)

    canvas.withTransform Matrix.translation(-I.width/2 + offsetX, -I.height/2 + offsetY), ->
      sprite.fill canvas, -offsetX, -offsetY, I.width, I.height

  return {}
