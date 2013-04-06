Editor.Tool.Create = (I={}) ->
  clickStart = undefined
  snap = 8

  rect = (start, end) ->
    {x, y} = Point.centroid(start, end)
    extent = end.subtract(start).abs()

    x: x.snap(snap)
    y: y.snap(snap)
    width: extent.x.snap(2 * snap)
    height: extent.y.snap(2 * snap)

  self = Editor.Tool(I).extend
    pressed: (worldPoint) ->
      clickStart = worldPoint.snap(snap)

    released: (worldPoint) ->
      engine.add "Block",
        rect(clickStart, worldPoint.snap(snap))

      clickStart = undefined

    draw: (canvas) ->
      canvas.withTransform engine.camera().transform(), (canvas) ->
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
