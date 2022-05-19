world = {}
world.visualGrid = {}
world.playerPosition = {}
world.tileSize = 64
world.currentLevel = 0
world.symbols = {
  floor = ' ',
  wall = '#',
  box = '$',
  storage = '.',
  boxOnStorage = '*',
  player = '@'
}
world.colors = {
  [world.symbols.floor] = { 40, 42, 54 },
  [world.symbols.wall] = { 68, 71, 90 },
  [world.symbols.box] = { 241, 250, 140 },
  [world.symbols.storage] = { 255, 85, 85, 1 },
  [world.symbols.boxOnStorage] = { 255, 184, 108 }
}

local function setResolution(level)
  local visualGrid = levels[level]
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
  for y, row in pairs(levels[level]) do
    world.visualGrid[y] = {}
    for x, cell in pairs(row) do
      if cell == world.symbols.player then
        world.playerPosition = {
          ['x'] = x,
          ['y'] = y
        }
        world.visualGrid[y][x] = world.symbols.floor
      else
        world.visualGrid[y][x] = cell
      end
    end
  end

  world.currentLevel = level
end

function world.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(world.colors[world.symbols.floor][1], world.colors[world.symbols.floor][2], world.colors[world.symbols.floor][3]))

  for y, row in pairs(world.visualGrid) do
    for x, cell in pairs(row) do
      local padding = world.tileSize / 8
      love.graphics.setColor(love.math.colorFromBytes(world.colors[cell][1], world.colors[cell][2], world.colors[cell][3]))

      if cell == world.symbols.wall then
        local padding = 1
        love.graphics.rectangle('fill', x * world.tileSize + padding, y * world.tileSize + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
      end

      if cell == world.symbols.box or cell == world.symbols.boxOnStorage then
        love.graphics.rectangle('fill', x * world.tileSize + padding, y * world.tileSize + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
      end

      if cell == world.symbols.storage then
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

  if nextDrawnTile == world.symbols.wall or nextDrawnTile == nil then
    return false
  end

  if nextDrawnTile == world.symbols.box or nextDrawnTile == world.symbols.boxOnStorage then
    return false
  end

  local drawnValue = (world.getTile(boxX, boxY) == world.symbols.boxOnStorage) and world.symbols.storage or world.symbols.floor
  updateTile(boxX, boxY, drawnValue)

  local nextDrawnValue = (nextDrawnTile == world.symbols.storage) and world.symbols.boxOnStorage or world.symbols.box
  updateTile(boxX + directionX, boxY + directionY, nextDrawnValue)

  return true
end
