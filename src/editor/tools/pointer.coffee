Editor.Tool.Pointer = (I={}) ->
  selectedObject = undefined
  initialObjectPosition = undefined
  startPoint = undefined

  I.name = "Pointer"

  self = Editor.Tool(I).extend
    pressed: (worldPoint) ->
      startPoint = worldPoint

      if selectedObject = engine.objectsUnderPoint(startPoint).first()
        initialObjectPosition = selectedObject.position()

    released: (worldPoint) ->
      startPoint = undefined

  self.on "draw", (canvas) ->
    if selectedObject
      r = selectedObject.centeredBounds()

      # TODO: Draw the same as game objects, from center
      canvas.drawRect
        x: r.x - r.xw
        y: r.y - r.yw
        width: r.xw * 2
        height: r.yw * 2
        stroke:
          width: 2
          color: "rgba(255, 0, 255, 0.75)"
        color: "rgba(255, 0, 255, 0.25)"

  self.on "updatePosition", (worldPoint) ->
    if startPoint
      delta = worldPoint.subtract(startPoint).snap(I.snap)

      if selectedObject
        selectedObject.position(initialObjectPosition.add(delta))

  return self
