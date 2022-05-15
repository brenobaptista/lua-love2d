require("utils")

-- 0 means floor
-- 1 means wall
-- 2 means box
-- 3 means location
-- 4 means box in location

world = {}
world.tileSize = 64
world.visualGrid = {
  { 0, 0, 1, 1, 1, 1, 1, 0 },
  { 1, 1, 1, 0, 0, 0, 1, 0 },
  { 1, 3, 0, 2, 0, 0, 1, 0 },
  { 1, 1, 1, 0, 2, 3, 1, 0 },
  { 1, 3, 1, 1, 2, 0, 1, 0 },
  { 1, 0, 1, 0, 3, 0, 1, 1 },
  { 1, 2, 0, 4, 2, 2, 3, 1 },
  { 1, 0, 0, 0, 3, 0, 0, 1 },
  { 1, 1, 1, 1, 1, 1, 1, 1 }
}
world.mapDimensions = {
  ["x"] = utils.getLength(world.visualGrid[1]),
  ["y"] = utils.getLength(world.visualGrid)
}
world.colors = {
  ["floor"] = { 40, 42, 54 },
  ["wall"] = { 68, 71, 90 },
  ["box"] = { 241, 250, 140 },
  ["location"] = { 255, 85, 85, 1 },
  ["boxInLocation"] = { 255, 184, 108 }
}

function world.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(world.colors.floor[1], world.colors.floor[2], world.colors.floor[3]))

	for y=1, #world.visualGrid do
		for x=1, #world.visualGrid[y] do
			if world.visualGrid[y][x] == 1 then
        local padding = 1
        love.graphics.setColor(love.math.colorFromBytes(world.colors.wall[1], world.colors.wall[2], world.colors.wall[3]))
				love.graphics.rectangle("fill", x * world.tileSize + padding, y * world.tileSize + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
			end

      if world.visualGrid[y][x] == 2 then
        local padding = world.tileSize / 8
        love.graphics.setColor(love.math.colorFromBytes(world.colors.box[1], world.colors.box[2], world.colors.box[3]))
				love.graphics.rectangle("fill", x * world.tileSize + padding, y * world.tileSize + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
			end

      if world.visualGrid[y][x] == 3 then
        local padding = world.tileSize / 8
        love.graphics.setColor(love.math.colorFromBytes(world.colors.location[1], world.colors.location[2], world.colors.location[3]))
				love.graphics.circle("fill", x * world.tileSize + padding * 4, y * world.tileSize + padding * 4, world.tileSize - padding * 6)
			end

      if world.visualGrid[y][x] == 4 then
        local padding = world.tileSize / 8
        love.graphics.setColor(love.math.colorFromBytes(world.colors.boxInLocation[1], world.colors.boxInLocation[2], world.colors.boxInLocation[3]))
				love.graphics.rectangle("fill", x * world.tileSize + padding, y * world.tileSize + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
			end
		end
	end
end

function world.getTile(x, y)
  return world.visualGrid[y][x]
end

function world.updateTile(x, y, value)
  world.visualGrid[y][x] = value
end

function world.moveBox(boxX, boxY, directionX, directionY)
  local nextDrawnTile = world.getTile(boxX + directionX, boxY + directionY)

  if nextDrawnTile == 1 or nextDrawnTile == nil then
		return false
	end

  if nextDrawnTile == 2 or nextDrawnTile == 4 then
    return false
  end

  local drawnValue = (world.getTile(boxX, boxY) == 4) and 3 or 0
  world.updateTile(boxX, boxY, drawnValue)

  local nextDrawnValue = (nextDrawnTile == 3) and 4 or 2
  world.updateTile(boxX + directionX, boxY + directionY, nextDrawnValue)

  return true
end
