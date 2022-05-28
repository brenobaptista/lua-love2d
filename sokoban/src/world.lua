world = {}

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

  world:loadLevel(1)
end

function world:draw()
  love.graphics.setBackgroundColor(self.colors[self.symbols.floor])

  for y, row in pairs(self.visualGrid) do
    for x, cell in pairs(row) do
      local padding = self.tileSize / 8
      local radius = world.tileSize / 16
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
end

local function setResolution(level)
  local mapDimensions = { x = 0, y = #levels[level] }

  for _, row in pairs(levels[level]) do
    if mapDimensions.x < #row then mapDimensions.x = #row end
  end

  local windowWidth = world.tileSize * (mapDimensions.x + 2)
  local windowHeight = world.tileSize * (mapDimensions.y + 2)
  love.window.setMode(windowWidth, windowHeight, {})
end

function world:loadLevel(level)
  if level ~= self.currentLevel then setResolution(level) end
  self.currentLevel = level

  self.visualGrid = {}
  for y, row in pairs(levels[level]) do
    self.visualGrid[y] = {}
    for x, cell in pairs(row) do
      if cell == self.symbols.initialPlayerPosition then
        self.initialPlayerPosition = { x = x, y = y }
        self.visualGrid[y][x] = self.symbols.floor
      else
        self.visualGrid[y][x] = cell
      end
    end
  end
end

function world:getTile(x, y)
  return self.visualGrid[y][x]
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

function world:moveBox(x, y, dx, dy)
  local nextDrawnTile = world:getTile(x + dx, y + dy)
  if nextDrawnTile == self.symbols.wall or nextDrawnTile == nil then return false end
  if nextDrawnTile == self.symbols.box or nextDrawnTile == self.symbols.boxOnStorage then return false end

  if world:getTile(x, y) == self.symbols.boxOnStorage then
    updateTile(x, y, self.symbols.storage)
  else
    updateTile(x, y, self.symbols.floor)
  end

  if nextDrawnTile == self.symbols.storage then
    updateTile(x + dx, y + dy, self.symbols.boxOnStorage)

    local isLevelCompleted = checkLevelCompletion()
    if isLevelCompleted then
      signals.send('levelCompleted')
      return false
    end
  else
    updateTile(x + dx, y + dy, self.symbols.box)
  end

  return true
end
