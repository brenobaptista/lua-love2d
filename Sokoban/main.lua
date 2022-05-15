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

function renderWorld()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(world.colors.floor[1], world.colors.floor[2], world.colors.floor[3]))

	for y=1, #world.visualGrid do
		for x=1, #world.visualGrid[y] do
			if world.visualGrid[y][x] == 1 then
        local padding = 1
        love.graphics.setColor(love.math.colorFromBytes(world.colors.wall[1], world.colors.wall[2], world.colors.wall[3]))
				love.graphics.rectangle("fill", x * world.tileSize + padding, y * world.tileSize + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
			end
		end
	end
end

function renderPlayer()
  local padding = world.tileSize / 4
  love.graphics.setColor(love.math.colorFromBytes(player.color[1], player.color[2], player.color[3]))
	love.graphics.rectangle("fill", player.rendered.x + padding, player.rendered.y + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
end

function love.draw()
  renderWorld()
  renderPlayer()
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
