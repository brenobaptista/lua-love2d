require('world')
require('player')

function love.load()
  arrowKeys = {
    ['up'] = { 0, -1 },
    ['down'] = { 0, 1 },
    ['left'] = { -1, 0 },
    ['right'] = { 1, 0 }
  }
end

function love.update(dt)
	player.updateDrawn(dt)
end

function love.draw()
  world.draw()
  player.draw()
end

local function handleArrowKeys(x, y)
  if player.canMove(x, y) then
    player.updateNextDrawn(x, y)
  end
end

function love.keypressed(key)
  for direction, coordinates in pairs(arrowKeys) do
    if key == direction then
      handleArrowKeys(coordinates[1], coordinates[2])
    end
  end
end
