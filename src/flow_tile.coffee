FlowTile = (I, self) ->
  self.unbind "draw"

  self.on "draw", (canvas) ->
    # offsetX = (-I.age/7).floor().mod(I.width)

    offsetX = 0
    offsetY = (2 * I.age).floor().mod(I.sprite.height)

    canvas.withTransform Matrix.translation(-I.width/2 + offsetX, -I.height/2 + offsetY), ->
      I.sprite.fill canvas, -offsetX, -offsetY, I.width, I.height

  return {}
