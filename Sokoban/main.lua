require("world")
require("player")

function love.load()
  arrowKeys = {
    ["up"] = { 0, -1 },
    ["down"] = { 0, 1 },
    ["left"] = { -1, 0 },
    ["right"] = { 1, 0 }
  }
end

function love.update(dt)
	player.updatePlayerRenderedPosition(dt)
end

function love.draw()
  world.draw()
  player.draw()
end

function canMove(x, y)
  local destinationTile = world.getTile((player.destination.x / world.tileSize) + x, (player.destination.y / world.tileSize) + y)

  if destinationTile == 1 or destinationTile == nil then
		return false
	end

  return true
end

function handleArrowKeys(x, y)
  if canMove(x, y) then
    player.updatePlayerDestinationPosition(x, y)
  end
end

function love.keypressed(key)
  for k, v in pairs(arrowKeys) do
    if key == k then
      handleArrowKeys(v[1], v[2])
    end
  end
end
