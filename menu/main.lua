local buttons = require('buttons')

function love.load()
  buttons:load('Start Game', function() print('Starting game') end)
  buttons:load('Load Game', function() print('Loading game') end)
  buttons:load('Settings', function() print('Opening settings') end)
  buttons:load('Exit', function() love.event.quit() end)
end

function love.update()
  local mouseX, mouseY = love.mouse.getPosition()

  buttons.loop(function(button)
    buttons:update(button, mouseX, mouseY)
  end)

  buttons:setCursor()
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(40, 42, 54))

  buttons.loop(function(button)
    buttons:draw(button)
  end)
end

function love.mousepressed()
  buttons.handleClick()
end
