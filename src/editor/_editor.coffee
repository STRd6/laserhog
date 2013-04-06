Editor = (I, self) ->
  Object.reverseMerge I,
    editMode: false
    selectedObject: null

  currentTool = Editor.Tool.Create()

  self.on "update", ->
    if justPressed.esc
      I.editMode = !I.editMode

    if I.editMode
      engine.I.backgroundColor = "#EEA"

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
    currentTool.draw(canvas)

  return {}
