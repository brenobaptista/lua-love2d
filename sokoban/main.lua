Signals = require('../signals/signals')
Levels = require('src/levels')
World = require('src/world')
local audio = require('src/audio')
local player = require('src/player')

local arrowKeys, levelKeys

function love.load()
  World:load()
  player:load()

  Signals.connect('levelCompleted', function()
    local nextLevel = World.currentLevel + 1
    if 0 < nextLevel and nextLevel <= #Levels then
      World:loadLevel(nextLevel)
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

  audio.load('blip', 'audio/blip-sound.wav', 'static')
  audio.load('music', 'audio/game-music.mp3', 'stream', true)

  audio.play('music')
end

function love.update(dt)
  player:update(dt)
end

function love.draw()
  World:draw()
  player:draw()
end

local function handleArrowKeys(dx, dy)
  if player:canMove(dx, dy) then
    player:updateNextDrawn(dx, dy)
    audio.play('blip')
  end
end

local function handleLevelKeys(levelDifference)
  local selected = World.currentLevel + levelDifference
  if 0 < selected and selected <= #Levels then
    World:loadLevel(selected)
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
    audio.stop('music')
  end
end
