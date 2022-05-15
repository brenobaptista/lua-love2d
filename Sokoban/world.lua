require('utils')

floor = ' '
wall = '#'
box = '$'
storage = '.'
boxOnStorage = '*'

world = {}
world.tileSize = 64
world.visualGrid = {
  { ' ', ' ', '#', '#', '#', '#', '#', ' ' },
  { '#', '#', '#', ' ', ' ', ' ', '#', ' ' },
  { '#', '.', ' ', '$', ' ', ' ', '#', ' ' },
  { '#', '#', '#', ' ', '$', '.', '#', ' ' },
  { '#', '.', '#', '#', '$', ' ', '#', ' ' },
  { '#', ' ', '#', ' ', '.', ' ', '#', '#' },
  { '#', '$', ' ', '*', '$', '$', '.', '#' },
  { '#', ' ', ' ', ' ', '.', ' ', ' ', '#' },
  { '#', '#', '#', '#', '#', '#', '#', '#' }
}
world.mapDimensions = {
  ['x'] = utils.getLength(world.visualGrid[1]),
  ['y'] = utils.getLength(world.visualGrid)
}
world.colors = {
  [floor] = { 40, 42, 54 },
  [wall] = { 68, 71, 90 },
  [box] = { 241, 250, 140 },
  [storage] = { 255, 85, 85, 1 },
  [boxOnStorage] = { 255, 184, 108 }
}

function world.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(world.colors[' '][1], world.colors[' '][2], world.colors[' '][3]))

  for y, row in pairs(world.visualGrid) do
    for x, cell in pairs(row) do
      local padding = world.tileSize / 8
      love.graphics.setColor(love.math.colorFromBytes(world.colors[cell][1], world.colors[cell][2], world.colors[cell][3]))

      if cell == '#' then
        local padding = 1
				love.graphics.rectangle('fill', x * world.tileSize + padding, y * world.tileSize + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
			end

      if cell == '$' or cell == '*' then
				love.graphics.rectangle('fill', x * world.tileSize + padding, y * world.tileSize + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
			end

      if cell == '.' then
				love.graphics.circle('fill', x * world.tileSize + padding * 4, y * world.tileSize + padding * 4, world.tileSize - padding * 6)
			end
    end
  end
end

function world.getTile(x, y)
  return world.visualGrid[y][x]
end

local function updateTile(x, y, value)
  world.visualGrid[y][x] = value
end

function world.moveBox(boxX, boxY, directionX, directionY)
  local nextDrawnTile = world.getTile(boxX + directionX, boxY + directionY)

  if nextDrawnTile == '#' or nextDrawnTile == nil then
		return false
	end

  if nextDrawnTile == '$' or nextDrawnTile == '*' then
    return false
  end

  local drawnValue = (world.getTile(boxX, boxY) == '*') and '.' or ' '
  updateTile(boxX, boxY, drawnValue)

  local nextDrawnValue = (nextDrawnTile == '.') and '*' or '$'
  updateTile(boxX + directionX, boxY + directionY, nextDrawnValue)

  return true
end
