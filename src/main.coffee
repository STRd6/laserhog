canvas = $("canvas").pixieCanvas()

Engine.defaultModules.push "Gamepads"

window.engine = Engine
  backgroundColor: "#FFF"
  canvas: canvas
  zSort: true
  FPS: 60

p1 = engine.add "Player",
  x: App.width/2
  y: App.height/2

p1.include "Debuggable"

engine.add "Player",
  controller: 1
  x: App.width/4
  y: App.height/2

# temp ground
engine.add "Base",
  solid: true
  x: App.width/2
  width: App.width
  y: App.height - 10
  height: 20
  color: "green"

# TODO Update existing module
engine.collides = (bounds, sourceObject) ->
  engine.objects().inject false, (collided, object) ->
    collided || (object.solid?() && (object != sourceObject) && object.collides(bounds))

# engine.on "overlay", (canvas) ->
#   controller = engine.controller()
#   controller.drawDebug(canvas)

engine.on "update", ->
  if justPressed.enter
    engine.pause()

engine.start()
