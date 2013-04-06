Editor.Tool = (I={}) ->
  GameObject(I).extend
    pressed: (worldPoint) ->
    released: (worldPoint) ->
    updatePosition: (worldPoint) ->
      I.currentPosition = worldPoint
    draw: (canvas) ->
