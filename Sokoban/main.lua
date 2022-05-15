require("world")
require("player")

function love.update(dt)
	player.updateDrawn(dt)
end

function love.draw()
  world.draw()
  player.draw()
end

function canMove(x, y)
  local nextDrawnTile = world.getTile((player.nextDrawn.x / world.tileSize) + x, (player.nextDrawn.y / world.tileSize) + y)

  if nextDrawnTile == 1 or nextDrawnTile == nil then
		return false
	end

  return true
end

function handleArrowKeys(x, y)
  if canMove(x, y) then
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
