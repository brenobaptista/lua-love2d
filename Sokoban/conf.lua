function love.conf(t)
  t.accelerometerjoystick = false

  t.window.title = "Sokoban"
  t.window.width = 512
  t.window.height = 576

  t.modules.data = false
  t.modules.joystick = false
  t.modules.mouse = false
  t.modules.physics = false
  t.modules.system = false
  t.modules.thread = false
  t.modules.touch = false
  t.modules.video = false
end