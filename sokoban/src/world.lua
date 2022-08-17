local levels = require('src/levels')

local world = {}

local function setResolution(level)
  local mapDimensions = { x = 0, y = #levels[level] }

  for _, row in pairs(levels[level]) do
    if mapDimensions.x < #row then mapDimensions.x = #row end
  end

  local windowWidth = world.tileSize * (mapDimensions.x + 2)
  local windowHeight = world.tileSize * (mapDimensions.y + 2)
  love.window.setMode(windowWidth, windowHeight, {})
end

local function loadLevel(level)
  if level <= 0 or level > #levels then return end
  if level ~= world.currentLevel then setResolution(level) end
  world.currentLevel = level

  world.visualGrid = {}
  for y, row in pairs(levels[level]) do
    world.visualGrid[y] = {}
    for x, cell in pairs(row) do
      if cell == world.symbols.initialPlayerPosition then
        world.initialPlayerPosition = { x = x, y = y }
        world.visualGrid[y][x] = world.symbols.floor
      else
        world.visualGrid[y][x] = cell
      end
    end
  end

  Signal.send('loadPlayerPosition')
end

function world:load()
  self.tileSize = 64
  self.currentLevel = 0
  self.symbols = {
    floor = ' ',
    wall = '#',
    box = '$',
    storage = '.',
    boxOnStorage = '*',
    initialPlayerPosition = '@'
  }
  self.colors = {
    [self.symbols.floor] = { love.math.colorFromBytes(40, 42, 54) },
    [self.symbols.wall] = { love.math.colorFromBytes(68, 71, 90) },
    [self.symbols.box] = { love.math.colorFromBytes(241, 250, 140) },
    [self.symbols.storage] = { love.math.colorFromBytes(255, 85, 85) },
    [self.symbols.boxOnStorage] = { love.math.colorFromBytes(255, 184, 108) }
  }
  self.visualGrid = {}
  self.initialPlayerPosition = { x = 0, y = 0 }

  loadLevel(1)

  Signal.connect('loadLevelDifference', function(levelDifference)
    local level = self.currentLevel + levelDifference
    loadLevel(level)
  end)

  Mixer.loadMusic('background', 'audio/background-music.mp3', true, 0.1)
  Mixer.playMusic('background')
end

function world:draw()
  love.graphics.setBackgroundColor(self.colors[self.symbols.floor])

  for y, row in pairs(self.visualGrid) do
    for x, cell in pairs(row) do
      local padding = self.tileSize / 8
      local radius = self.tileSize / 16
      love.graphics.setColor(self.colors[cell])

      if cell == self.symbols.wall then
        local padding = 1
        love.graphics.rectangle(
          'fill',
          x * self.tileSize + padding,
          y * self.tileSize + padding,
          self.tileSize - padding * 2,
          self.tileSize - padding * 2,
          radius,
          radius
        )
      end

      if cell == self.symbols.box or cell == self.symbols.boxOnStorage then
        love.graphics.rectangle(
          'fill',
          x * self.tileSize + padding,
          y * self.tileSize + padding,
          self.tileSize - padding * 2,
          self.tileSize - padding * 2,
          radius,
          radius
        )
      end

      if cell == self.symbols.storage then
        local padding = self.tileSize / 4
        love.graphics.circle(
          'fill',
          x * self.tileSize + padding * 2,
          y * self.tileSize + padding * 2,
          self.tileSize - padding * 3.5)
      end
    end
  end

  love.graphics.setColor(1, 1, 1)
end

local function getTile(x, y)
  return world.visualGrid[y][x]
end

local function updateTile(x, y, value)
  world.visualGrid[y][x] = value
end

local function checkLevelCompletion()
  for _, row in pairs(world.visualGrid) do
    for _, cell in pairs(row) do
      if cell == world.symbols.box then return false end
    end
  end

  return true
end

local function moveBox(boxX, boxY, dx, dy)
  local currentBoxTile = getTile(boxX, boxY)
  local nextBoxTile = getTile(boxX + dx, boxY + dy)

  local obstacles = { world.symbols.wall, world.symbols.box, world.symbols.boxOnStorage }
  for _, obstacle in pairs(obstacles) do
    if nextBoxTile == obstacle then return false end
  end

  if currentBoxTile == world.symbols.boxOnStorage then
    updateTile(boxX, boxY, world.symbols.storage)
  else
    updateTile(boxX, boxY, world.symbols.floor)
  end

  if nextBoxTile == world.symbols.storage then
    updateTile(boxX + dx, boxY + dy, world.symbols.boxOnStorage)

    local isLevelCompleted = checkLevelCompletion()
    if isLevelCompleted then
      Signal.send('loadLevelDifference', 1)
      return false
    end
  else
    updateTile(boxX + dx, boxY + dy, world.symbols.box)
  end

  return true
end

Signal.connect('playerTryingToMove', function(nextDrawnX, nextDrawnY, dx, dy)
  local nextDrawnTile = getTile(nextDrawnX, nextDrawnY)

  if nextDrawnTile == world.symbols.floor or nextDrawnTile == world.symbols.storage then
    Signal.send('movePlayer', nextDrawnX, nextDrawnY)
  end

  if nextDrawnTile == world.symbols.box or nextDrawnTile == world.symbols.boxOnStorage then
    local didBoxMove = moveBox(nextDrawnX, nextDrawnY, dx, dy)
    if didBoxMove then Signal.send('movePlayer', nextDrawnX, nextDrawnY) end
  end
end)

return world
