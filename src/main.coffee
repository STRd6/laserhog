canvas = $("canvas").pixieCanvas()

window.ARENA =
  width: App.width * 2
  height: App.height * 1.5

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
engine.add
  solid: true
  x: ARENA.width/2
  width: ARENA.width
  y: ARENA.height - 10
  height: 20
  color: "green"

positions = [
  Point(ARENA.width / 8, ARENA.height - 100)
  Point(ARENA.width * 7 / 8, ARENA.height - 100)
]
["red", "blue"].each (color, i) ->
  engine.add "Flag"
    sprite: "flag_#{color}"
    x: positions[i].x
    y: positions[i].y

# engine.on "overlay", (canvas) ->
#   controller = engine.controller()
#   controller.drawDebug(canvas)

engine.include Editor

engine.on "update", ->
  if justPressed.enter
    engine.pause()

  camera = engine.camera()

  camera.I.maxSpeed = 500
  camera.I.cameraBounds.width = ARENA.width
  camera.I.cameraBounds.height = ARENA.height

  if target = engine.first("CameraTarget")
    camera.follow(target)

Music.volume 0#.5
Music.play("TheApogee")

engine.start()
