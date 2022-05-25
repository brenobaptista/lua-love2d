require("eyes")

function love.load()
  eyes.load(125, 150, 50, 15)
  eyes.load(275, 150, 50, 15)
end

function love.update()
  eyes.loop(function(v)
    eyes.update(v)
  end)
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(40, 42, 54))

  eyes.loop(function(v)
    eyes.draw(v)
  end)
end
