local eye = require('eye')

function love.load()
  eye.load(125, 150, 50, 15)
  eye.load(275, 150, 50, 15)
end

function love.update()
  eye.updateAll()
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(40, 42, 54))
  eye.drawAll()
end
