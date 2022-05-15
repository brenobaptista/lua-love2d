require("utils")

-- 0 means floor
-- 1 means wall
-- 2 means box

world = {}
world.tileSize = 64
world.visualGrid = {
  { 0, 0, 1, 1, 1, 1, 1, 0 },
  { 1, 1, 1, 0, 0, 0, 1, 0 },
  { 1, 0, 0, 2, 0, 0, 1, 0 },
  { 1, 1, 1, 0, 2, 0, 1, 0 },
  { 1, 0, 1, 1, 2, 0, 1, 0 },
  { 1, 0, 1, 0, 0, 0, 1, 1 },
  { 1, 2, 0, 2, 2, 2, 0, 1 },
  { 1, 0, 0, 0, 0, 0, 0, 1 },
  { 1, 1, 1, 1, 1, 1, 1, 1 }
}
world.mapDimensions = {
  ["x"] = utils.getLength(world.visualGrid[1]),
  ["y"] = utils.getLength(world.visualGrid)
}
world.colors = {
  ["floor"] = { 40, 42, 54 },
  ["wall"] = { 68, 71, 90 },
  ["box"] = { 255, 184, 108 }
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

  world.updateTile(boxX, boxY, 0)
  world.updateTile(boxX + directionX, boxY + directionY, 2)
  return true
end
