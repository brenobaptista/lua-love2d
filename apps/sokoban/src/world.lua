world = {}
world.tileSize = 64
world.symbols = {
  floor = ' ',
  wall = '#',
  box = '$',
  storage = '.',
  boxOnStorage = '*',
  player = '@'
}
world.currentLevel = 0

local initialPlayerPosition = {}
local visualGrid = {}
local colors = {
  [world.symbols.floor] = { 40, 42, 54 },
  [world.symbols.wall] = { 68, 71, 90 },
  [world.symbols.box] = { 241, 250, 140 },
  [world.symbols.storage] = { 255, 85, 85, 1 },
  [world.symbols.boxOnStorage] = { 255, 184, 108 }
}

local function setResolution(level)
  local mapDimensions = {}
  mapDimensions.y = #levels[level]
  mapDimensions.x = 0

  for _, row in pairs(levels[level]) do
    if mapDimensions.x < #row then
      mapDimensions.x = #row
    end
  end

  local windowWidth = world.tileSize * (mapDimensions.x + 2)
  local windowHeight = world.tileSize * (mapDimensions.y + 2)
  love.window.setMode(windowWidth, windowHeight, {})
end

local function updateInitialPlayerPosition(gridX, gridY)
  initialPlayerPosition = {
    x = gridX,
    y = gridY
  }
end

function world.getInitialPlayerPosition()
  return {
    x = initialPlayerPosition.x * world.tileSize,
    y = initialPlayerPosition.y * world.tileSize
  }
end

function world.loadLevel(level)
  if level ~= world.currentLevel then
    setResolution(level)
  end

  visualGrid = {}
  for y, row in pairs(levels[level]) do
    visualGrid[y] = {}
    for x, cell in pairs(row) do
      if cell == world.symbols.player then
        updateInitialPlayerPosition(x, y)
        visualGrid[y][x] = world.symbols.floor
      else
        visualGrid[y][x] = cell
      end
    end
  end

  world.currentLevel = level
end

function world.draw()
  love.graphics.setBackgroundColor(
    love.math.colorFromBytes(
      colors[world.symbols.floor][1],
      colors[world.symbols.floor][2],
      colors[world.symbols.floor][3]
    )
  )

  for y, row in pairs(visualGrid) do
    for x, cell in pairs(row) do
      local padding = world.tileSize / 8
      love.graphics.setColor(
        love.math.colorFromBytes(
          colors[cell][1],
          colors[cell][2],
          colors[cell][3]
        )
      )

      if cell == world.symbols.wall then
        local padding = 1
        love.graphics.rectangle(
          'fill',
          x * world.tileSize + padding,
          y * world.tileSize + padding,
          world.tileSize - padding * 2,
          world.tileSize - padding * 2
        )
      end

      if cell == world.symbols.box or cell == world.symbols.boxOnStorage then
        love.graphics.rectangle(
          'fill',
          x * world.tileSize + padding,
          y * world.tileSize + padding,
          world.tileSize - padding * 2,
          world.tileSize - padding * 2
        )
      end

      if cell == world.symbols.storage then
        love.graphics.circle(
          'fill',
          x * world.tileSize + padding * 4,
          y * world.tileSize + padding * 4,
          world.tileSize - padding * 6)
      end
    end
  end
end

function world.getTile(x, y)
  return visualGrid[y][x]
end

local function updateTile(x, y, value)
  visualGrid[y][x] = value
end

function world.moveBox(x, y, dx, dy)
  local nextDrawnTile = world.getTile(x + dx, y + dy)

  if nextDrawnTile == world.symbols.wall or nextDrawnTile == nil then
    return false
  end

  if nextDrawnTile == world.symbols.box or nextDrawnTile == world.symbols.boxOnStorage then
    return false
  end

  local drawnValue
  if world.getTile(x, y) == world.symbols.boxOnStorage then
    drawnValue = world.symbols.storage
  else
    drawnValue = world.symbols.floor
  end
  updateTile(x, y, drawnValue)

  local nextDrawnValue
  if nextDrawnTile == world.symbols.storage then
    nextDrawnValue = world.symbols.boxOnStorage
  else
    nextDrawnValue = world.symbols.box
  end

  updateTile(x + dx, y + dy, nextDrawnValue)

  return true
end
