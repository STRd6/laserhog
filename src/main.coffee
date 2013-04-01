canvas = $("canvas").pixieCanvas()

Engine.defaultModules.push "Gamepads"

window.engine = Engine
  canvas: canvas
  showFPS: true
  zSort: true
  FPS: 60

engine.add "Player",
  x: App.width/2
  y: App.height/2

engine.start()
