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

      if justPressed.pageup
        changeTool(+1)
      if justPressed.pagedown
        changeTool(-1)

      camera = engine.camera()
      worldPosition = camera.screenToWorld(mousePosition)

      currentTool.updatePosition(worldPosition)

      if mousePressed.left
        currentTool.pressed(worldPosition)

      if mouseReleased.left
        currentTool.released(worldPosition)

    else
      engine.I.backgroundColor = "#58C4F5"

  self.on "draw", (canvas) ->
    if I.editMode
      canvas.drawText
        x: 20
        y: 120
        text: currentTool.I.name
        color: "#000"

      currentTool.draw(canvas)

  saveLevel: ->
    objects = engine.find(".level").map (object) ->
      object = Object.extend({}, object.I)

      # This hack is to prevent circular reference from sprite's image reference
      # TODO: Use I.spriteName instead of sprite, have sprite be a computed method
      delete object.sprite

      return object

    JSON.stringify(objects)

  loadLevel: (name) ->
    $.getJSON "levels/#{name}.json", (levelData) ->
      engine.find(".level").each (l) -> l.active = false

      levelData.each (datum) ->
        engine.add datum
