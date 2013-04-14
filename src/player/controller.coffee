Player.Controller = (I, self) ->
  Object.reverseMerge I,
    controls:
      jump: "A"
      shield: "RT"
      shoot: "X"
      grapple: "B"
      nextWeapon: "RB"
      previousWeapon: "LB"

  actionDown: (name) ->
    if button = I.controls[name]
      engine.controller(I.controller).buttonDown button

  actionPressed: (name) ->
    if button = I.controls[name]
      engine.controller(I.controller).buttonPressed button

  controllerPosition: ->
    engine.controller(I.controller).position()
