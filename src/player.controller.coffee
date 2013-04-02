Player.Controller = (I, self) ->
  self.actionDown = engine.controller(I.controller).actionDown
  self.controllerPosition = ->
    engine.controller(I.controller).position()

  return {}
