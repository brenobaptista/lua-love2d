require('world')
require('player')

function love.load()
  local startLevel = 1
  world.loadLevel(startLevel)
  player.loadPosition(startLevel)

  arrowKeys = {
    ['up'] = { 0, -1 },
    ['down'] = { 0, 1 },
    ['left'] = { -1, 0 },
    ['right'] = { 1, 0 }
  }
  levelKeys = {
    ['r'] = 0,
    ['n'] = 1,
    ['p'] = -1
  }
end

function love.update(dt)
  player.updateDrawn(dt)
end

function love.draw()
  world.draw()
  player.draw()
end

local function handleArrowKeys(x, y)
  if player.canMove(x, y) then
    player.updateNextDrawn(x, y)
  end
end

local function handleLevelKeys(change)
  local selected = world.currentLevel + change
  if 0 < selected and selected <= #world.levels then
    world.loadLevel(selected)
    player.loadPosition(selected)
  end
end

function love.keypressed(key)
  for direction, coordinates in pairs(arrowKeys) do
    if key == direction then
      handleArrowKeys(coordinates[1], coordinates[2])
    end
  end

  for selection, change in pairs(levelKeys) do
    if key == selection then
      handleLevelKeys(change)
    end
  end
end
