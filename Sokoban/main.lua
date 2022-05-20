require('levels')
require('world')
require('player')

local arrowKeys, levelKeys

function love.load()
  local startLevel = 1
  world.loadLevel(startLevel)
  player.loadPosition()

  arrowKeys = {
    up = { 0, -1 },
    down = { 0, 1 },
    left = { -1, 0 },
    right = { 1, 0 }
  }
  levelKeys = {
    r = 0,
    n = 1,
    p = -1
  }
end

function love.update(dt)
  player.updateDrawn(dt)
end

function love.draw()
  world.draw()
  player.draw()
end

local function handleArrowKeys(dx, dy)
  if player.canMove(dx, dy) then
    player.updateNextDrawn(dx, dy)
  end
end

local function handleLevelKeys(levelDifference)
  local selected = world.currentLevel + levelDifference
  if 0 < selected and selected <= #levels then
    world.loadLevel(selected)
    player.loadPosition()
  end
end

function love.keypressed(key)
  for direction, gridDifference in pairs(arrowKeys) do
    if key == direction then
      handleArrowKeys(gridDifference[1], gridDifference[2])
    end
  end

  for selection, levelDifference in pairs(levelKeys) do
    if key == selection then
      handleLevelKeys(levelDifference)
    end
  end
end
