local button = require('button')

function love.load()
  button.load('Start Game', function() print('Starting game') end)
  button.load('Load Game', function() print('Loading game') end)
  button.load('Settings', function() print('Opening settings') end)
  button.load('Exit', function() love.event.quit() end)
end

function love.update()
  button.updateAll()
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(40, 42, 54))
  button.drawAll()
end

function love.mousepressed(_, _, btn)
  if btn == 1 then
    button.handleClick()
  end
end
