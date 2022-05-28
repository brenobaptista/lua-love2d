signals = require('../signals/signals')
require('src/levels')
require('src/world')
require('src/player')

local arrowKeys, levelKeys

function love.load()
  world:load()
  player:load()

  signals.connect('levelCompleted', function()
    local nextLevel = world.currentLevel + 1
    if 0 < nextLevel and nextLevel <= #levels then
      world:loadLevel(nextLevel)
      player:loadPosition()
    end
  end)

  love.keyboard.setKeyRepeat(true)
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

  sounds = {}
  sounds.blip = love.audio.newSource('audio/blip-sound.wav', 'static')
  sounds.music = love.audio.newSource('audio/game-music.mp3', 'stream')
  sounds.music:setLooping(true)
  sounds.music:play()
end

function love.update(dt)
  player:update(dt)
end

function love.draw()
  world:draw()
  player:draw()
end

local function handleArrowKeys(dx, dy)
  if player:canMove(dx, dy) then
    player:updateNextDrawn(dx, dy)
    sounds.blip:play()
  end
end

local function handleLevelKeys(levelDifference)
  local selected = world.currentLevel + levelDifference
  if 0 < selected and selected <= #levels then
    world:loadLevel(selected)
    player:loadPosition()
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

  if key == 'm' then
    sounds.music:stop()
  end
end
