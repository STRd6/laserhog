NineSlice = (I, self) ->

  self.unbind ".Drawable"

  self.on "draw", (canvas) ->
    canvas.withTransform Matrix.translation(-I.width/2, -I.height/2), ->
      sprite = self.sprite()

      if image = sprite.image
        {width, height} = sprite
        size = 8
        n = 3

        patterns = sprite.nineSlicePatterns

        unless patterns
          patterns = sprite.nineSlicePatterns = []

          [[0, size], [size, width-2*size], [width-size, size]].each ([x, width], i) ->
            [[0, size], [size, height-2*size], [height-size, size]].each ([y, height], j) ->
              patternCanvas = document.createElement('canvas')
              patternCanvas.width = width
              patternCanvas.height = height
              patternContext = patternCanvas.getContext("2d")
              patternContext.drawImage image,
                x, y,
                width, height,
                0, 0,
                width, height

              patterns[i + 3 * j] = patternContext.createPattern(patternCanvas, "repeat")

        # top left
        canvas.drawRect
          x: 0
          y: 0
          width: size
          height: size
          color: patterns[0]

        # top center
        canvas.drawRect
          x: size
          y: 0
          width: I.width - 2 * size
          height: size
          color: patterns[1]

        # top right
        canvas.drawRect
          x: I.width - size
          y: 0
          width: size
          height: size
          color: patterns[2]

        # center left
        canvas.drawRect
          x: 0
          y: size
          width: size
          height: I.height - 2 * size
          color: patterns[3]

        # center center
        canvas.drawRect
          x: size
          y: size
          width: I.width - 2 * size
          height: I.height - 2 * size
          color: patterns[4]

        # center right
        canvas.drawRect
          x: I.width - size
          y: size
          width: size
          height: I.height - 2 * size
          color: patterns[5]

        # bottom left
        canvas.drawRect
          x: 0
          y: I.height - size
          width: size
          height: size
          color: patterns[6]

        # bottom center
        canvas.drawRect
          x: size
          y: I.height - size
          width: I.width - 2 * size
          height: size
          color: patterns[7]

        # bottom right
        canvas.drawRect
          x: I.width - size
          y: I.height - size
          width: size
          height: size
          color: patterns[8]

      else
        canvas.drawRect
          x: 0
          y: 0
          width: I.width
          height: I.height
          color: I.color

  return {}
