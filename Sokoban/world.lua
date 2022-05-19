floor = ' '
wall = '#'
box = '$'
storage = '.'
boxOnStorage = '*'

world = {}
world.visualGrid = {}
world.tileSize = 64
world.currentLevel = 0
world.levels = {
  {
    ['visualGrid'] = {
      { ' ', ' ', '#', '#', '#' },
      { ' ', ' ', '#', '.', '#' },
      { ' ', ' ', '#', ' ', '#', '#', '#', '#' },
      { '#', '#', '#', '$', ' ', '$', '.', '#' },
      { '#', '.', ' ', '$', ' ', '#', '#', '#' },
      { '#', '#', '#', '#', '$', '#' },
      { ' ', ' ', ' ', '#', '.', '#' },
      { ' ', ' ', ' ', '#', '#', '#' },
    },
    ['playerPosition'] = {
      ['x'] = 5,
      ['y'] = 5
    }
  },
  {
    ['visualGrid'] = {
      { ' ', ' ', '#', '#', '#', '#', '#' },
      { '#', '#', '#', ' ', ' ', ' ', '#' },
      { '#', '.', ' ', '$', ' ', ' ', '#' },
      { '#', '#', '#', ' ', '$', '.', '#' },
      { '#', '.', '#', '#', '$', ' ', '#' },
      { '#', ' ', '#', ' ', '.', ' ', '#', '#' },
      { '#', '$', ' ', '*', '$', '$', '.', '#' },
      { '#', ' ', ' ', ' ', '.', ' ', ' ', '#' },
      { '#', '#', '#', '#', '#', '#', '#', '#' }
    },
    ['playerPosition'] = {
      ['x'] = 3,
      ['y'] = 3
    }
  }
}
world.colors = {
  [floor] = { 40, 42, 54 },
  [wall] = { 68, 71, 90 },
  [box] = { 241, 250, 140 },
  [storage] = { 255, 85, 85, 1 },
  [boxOnStorage] = { 255, 184, 108 }
}

local function setResolution(level)
  local visualGrid = world.levels[level].visualGrid
  local mapDimensions = {}
  mapDimensions.y = #visualGrid
  mapDimensions.x = 0

  for _, row in pairs(visualGrid) do
    if mapDimensions.x < #row then
      mapDimensions.x = #row
    end
  end

  windowWidth = world.tileSize * (mapDimensions.x + 2)
  windowHeight = world.tileSize * (mapDimensions.y + 2)
  love.window.setMode(windowWidth, windowHeight, {})
end

function world.loadLevel(level)
  if level ~= world.currentLevel then
    setResolution(level)
  end

  world.visualGrid = {}
  for y, row in pairs(world.levels[level].visualGrid) do
    world.visualGrid[y] = {}
    for x, cell in pairs(row) do
      world.visualGrid[y][x] = cell
    end
  end

  world.currentLevel = level
end

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
