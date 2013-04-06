Editor = (I, self) ->
  Object.reverseMerge I,
    editMode: false

  tools = [
    Editor.Tool.Create()
    Editor.Tool.Pointer()
  ]

  selectedToolIndex = 0
  currentTool = tools[selectedToolIndex]

  changeTool = (delta) ->
    selectedToolIndex += delta

    currentTool = tools.wrap(selectedToolIndex)

  self.on "update", ->
    if justPressed.esc
      I.editMode = !I.editMode

    if I.editMode
      engine.I.backgroundColor = "#EEA"

      if justPressed.right
        changeTool(+1)
      if justPressed.left
        changeTool(-1)

      camera = engine.camera()
      worldPosition = camera.screenToWorld(mousePosition)

      currentTool.updatePosition(worldPosition)

      if mousePressed.left
        currentTool.pressed(worldPosition)

      if mouseReleased.left
        currentTool.released(worldPosition)

    else
      engine.I.backgroundColor = "#FFF"

  self.on "draw", (canvas) ->
    canvas.drawText
      x: 20
      y: 20
      text: currentTool.I.name
      color: "#000"

    currentTool.draw(canvas)

  return {}
