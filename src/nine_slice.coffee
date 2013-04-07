NineSlice = (I, self) ->
  self.sprite = (newSprite) ->
    if newSprite?
      I.sprite = newSprite
      I.patterns = undefined # Clear pattern cache
    else
      I.sprite

  self.unbind "draw"

  self.on "draw", (canvas) ->
    canvas.withTransform Matrix.translation(-I.width/2, -I.height/2), ->
      if image = I.sprite.image
        size = 8
        n = 3

        unless I.patterns
          I.patterns = []

          n.times (x) ->
            n.times (y) ->
              patternCanvas = document.createElement('canvas')
              patternCanvas.width = patternCanvas.height = size
              patternContext = patternCanvas.getContext("2d")
              patternContext.drawImage image,
                size * x, size * y,
                size, size,
                0, 0,
                size, size

              I.patterns[x + 3 * y] = patternContext.createPattern(patternCanvas, "repeat")

        {width, height} = I.sprite

        # top left
        canvas.drawRect
          x: 0
          y: 0
          width: size
          height: size
          color: I.patterns[0]

        # top center
        canvas.drawRect
          x: size
          y: 0
          width: I.width - 2 * size
          height: size
          color: I.patterns[1]

        # top right
        canvas.drawRect
          x: I.width - size
          y: 0
          width: size
          height: size
          color: I.patterns[2]

        # center left
        canvas.drawRect
          x: 0
          y: size
          width: size
          height: I.height - 2 * size
          color: I.patterns[3]

        # center center
        canvas.drawRect
          x: size
          y: size
          width: I.width - 2 * size
          height: I.height - 2 * size
          color: I.patterns[4]

        # center right
        canvas.drawRect
          x: I.width - size
          y: size
          width: size
          height: I.height - 2 * size
          color: I.patterns[5]

        # bottom left
        canvas.drawRect
          x: 0
          y: I.height - size
          width: size
          height: size
          color: I.patterns[6]

        # bottom center
        canvas.drawRect
          x: size
          y: I.height - size
          width: I.width - 2 * size
          height: size
          color: I.patterns[7]

        # bottom right
        canvas.drawRect
          x: I.width - size
          y: I.height - size
          width: size
          height: size
          color: I.patterns[8]

      else
        canvas.drawRect
          x: 0
          y: 0
          width: I.width
          height: I.height
          color: I.color

  return {}
