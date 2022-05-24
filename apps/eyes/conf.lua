function love.conf(t)
  t.version = '11.4'
  t.window.title = 'Eyes'
  t.window.width = 400
  t.window.height = 300

  t.accelerometerjoystick = false
  t.modules.data = false
  t.modules.joystick = false
  t.modules.physics = false
  t.modules.system = false
  t.modules.thread = false
  t.modules.touch = false
  t.modules.video = false
end
