Editor.Tool.Pointer = (I={}) ->
  selectedObject = undefined
  initialObjectPosition = undefined
  startPoint = undefined

  I.name = "Pointer"

  spritePalette = """
    block
    cloud
    scaffold
    rock
  """.split("\n").invoke("trim")

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

  # TODO: More generic update?
  self.on "updatePosition", (worldPoint) ->
    if selectedObject
      4.times (i) ->
        if justPressed[i+1]
          if sprite = spritePalette[i]
            selectedObject.I.sprite = sprite

      if keydown.shift
        attr = "height"
      else
        attr = "width"

      if justPressed["+"]
        selectedObject.I[attr] += 2 * I.snap
      if justPressed["-"]
        selectedObject.I[attr] -= 2 * I.snap

      if startPoint
        delta = worldPoint.subtract(startPoint).snap(I.snap)

        selectedObject.position(initialObjectPosition.add(delta))


  return self
