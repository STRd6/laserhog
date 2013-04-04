Player.Controller = (I, self) ->
  Object.reverseMerge I,
    controls:
      jump: "A"
      shield: "B"
      shoot: "X"

  actionDown: (name) ->
    if button = I.controls[name]
      engine.controller(I.controller).buttonDown button

  controllerPosition: ->
    engine.controller(I.controller).position()

