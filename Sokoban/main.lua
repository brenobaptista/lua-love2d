require('world')
require('player')

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
  for k, v in pairs(utils.arrowKeys) do
    if key == k then
      handleArrowKeys(v[1], v[2])
    end
  end
end
