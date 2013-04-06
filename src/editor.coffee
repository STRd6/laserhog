Editor = (I, self) ->
  Object.reverseMerge I,
    editMode: false
    tool: "create"

  clickStart = undefined
  snap = 8

  rect = ->
    camera = engine.camera()

    p = camera.screenToWorld(mousePosition).snap(snap)
    {x, y} = Point.centroid(clickStart, p)
    extent = p.subtract(clickStart).abs()

    x: x.snap(snap)
    y: y.snap(snap)
    width: extent.x.snap(2 * snap)
    height: extent.y.snap(2 * snap)

  self.on "update", ->
    if justPressed.esc
      I.editMode = !I.editMode

    if I.editMode
      engine.I.backgroundColor = "#EEA"

      if mouseDown.left
        unless clickStart
          camera = engine.camera()

          clickStart = camera.screenToWorld(mousePosition).snap(snap)

      else
        if clickStart
          p = mousePosition

          engine.add "Block",
            rect()

          clickStart = undefined

    else
      engine.I.backgroundColor = "#FFF"

  self.on "draw", (canvas) ->
    canvas.withTransform engine.camera().transform(), (canvas) ->
      if clickStart
        r = rect()

        # TODO: Draw the same as game objects, from center
        canvas.drawRect
          x: r.x - r.width/2
          y: r.y - r.height/2
          width: r.width
          height: r.height
          color: "rgba(255, 0, 255, 0.5)"

  return {}
