FlowTile = (I, self) ->
  Object.reverseMerge I,
    flowVelocity: Point(0, 2)

  self.unbind "draw"

  self.on "draw", (canvas) ->
    # offsetX = (-I.age/7).floor().mod(I.width)

    offsetX = (I.flowVelocity.x * I.age).floor().mod(I.sprite.height)
    offsetY = (I.flowVelocity.y * I.age).floor().mod(I.sprite.height)

    canvas.withTransform Matrix.translation(-I.width/2 + offsetX, -I.height/2 + offsetY), ->
      I.sprite.fill canvas, -offsetX, -offsetY, I.width, I.height

  return {}
