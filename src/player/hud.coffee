Player.HUD = (I, self) ->
  self.on "overlay", (canvas) ->
    screenPadding = 5
    hudWidth = 80
    hudHeight = 40
    hudMargin = 10

    canvas.withTransform Matrix.translation(I.controller * (hudWidth + hudMargin) + screenPadding, 0), (canvas) ->
      color = Color(I.color)
      color.a = 0.5

      canvas.drawRoundRect
        color: color
        x: 0
        y: -5
        width: hudWidth
        height: hudHeight

      textColor = "#FFF"

      canvas.drawText
        text: "PLAYER #{I.controller + 1}"
        x: 5
        y: 12
        color: textColor

      canvas.drawText
        text: "SCORE: #{I.score}"
        x: 5
        y: 28
        color: textColor

  return {}
