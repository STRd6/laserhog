Editor = (I, self) ->
  Object.reverseMerge I,
    editMode: false

  clickStart = undefined
  snap = 8

  rect = ->
    p = mousePosition.snap(snap)
    {x, y} = Point.centroid(clickStart, p)
    extent = p.subtract(clickStart).abs()

    x: x.snap(snap)
    y: y.snap(snap)
    width: extent.x
    height: extent.y

  self.on "update", ->
    if justPressed.esc
      I.editMode = !I.editMode

    if I.editMode
      engine.I.backgroundColor = "#847"

      if mouseDown.left
        unless clickStart
          clickStart = mousePosition.snap(snap)

      else
        if clickStart
          p = mousePosition

          engine.add "Block",
            rect()

          clickStart = undefined

    else
      engine.I.backgroundColor = "#FFF"

  self.on "draw", (canvas) ->
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
