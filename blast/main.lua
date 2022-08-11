local blast = require('blast')

function love.load()
  blast.load()
end

function love.update(dt)
  blast.update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(40, 42, 54))
  blast.draw()
end

function love.mousepressed(x, y, button)
  if button == 1 then
    blast.setPosition(x, y)
    blast.emit()
  end
end
