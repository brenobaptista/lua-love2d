local blast = require("blast")

local mouse = { x = 0, y = 0 }

function love.load()
  blast.load()
end

function love.update(dt)
  blast.update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(40, 42, 54))
  blast.draw(mouse.x, mouse.y)
end

function love.mousepressed(x, y, button)
  if button == 1 then
    mouse = { x = x, y = y }
    blast.emit()
  end
end
