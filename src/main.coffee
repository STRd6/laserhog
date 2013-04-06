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

engine.add "CameraTarget"

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

# engine.on "overlay", (canvas) ->
#   controller = engine.controller()
#   controller.drawDebug(canvas)

engine.include Editor

ARENA_WIDTH = App.width * 2

engine.on "update", ->
  if justPressed.enter
    engine.pause()

  camera = engine.camera()

  camera.I.maxSpeed = 500
  camera.I.cameraBounds.width = ARENA_WIDTH
  # camera.I.cameraBounds.height = ARENA_HEIGHT + 40

  if target = engine.first("CameraTarget")
    camera.follow(target)

Music.volume 0#.5
Music.play("TheApogee")

engine.start()
