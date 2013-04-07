Editor.Tool.Create = (I={}) ->
  clickStart = undefined

  I.name = "Create"

  rect = (start, end) ->
    {x, y} = Point.centroid(start, end)
    extent = end.subtract(start).abs()

    x: x.snap(I.snap)
    y: y.snap(I.snap)
    width: extent.x.snap(2 * I.snap)
    height: extent.y.snap(2 * I.snap)

  self = Editor.Tool(I).extend
    pressed: (worldPoint) ->
      clickStart = worldPoint.snap(I.snap)

    released: (worldPoint) ->
      engine.add "Quicksand",
        rect(clickStart, worldPoint.snap(I.snap))

      clickStart = undefined

  self.on "draw", (canvas) ->
    if clickStart
      r = rect(clickStart, I.currentPosition)

      # TODO: Draw the same as game objects, from center
      canvas.drawRect
        x: r.x - r.width/2
        y: r.y - r.height/2
        width: r.width
        height: r.height
        color: "rgba(255, 0, 255, 0.5)"

  return self
