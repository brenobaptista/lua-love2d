Signals = require('../signals/signals')
Levels = require('src/levels')
World = require('src/world')
local audio = require('src/audio')
local controls = require('src/controls')
local player = require('src/player')

local function handleLoadLevelDifference(levelDifference)
  local level = World.currentLevel + levelDifference
  if 0 < level and level <= #Levels then
    World:loadLevel(level)
    player:loadPosition()
  end
end

function love.load()
  World:load()
  player:load()
  Signals.connect('levelCompleted', function()
    handleLoadLevelDifference(1)
  end)

  controls:load()
  Signals.connect('arrowKeyPressed', function(dx, dy)
    if player:canMove(dx, dy) then
      player:updateNextDrawn(dx, dy)
      audio.play('blip')
    end
  end)
  Signals.connect('levelKeyPressed', function(levelDifference)
    handleLoadLevelDifference(levelDifference)
  end)

  audio.load('blip', 'audio/blip-sound.wav', 'static')
  audio.load('music', 'audio/game-music.mp3', 'stream', true)
  audio.play('music')
  Signals.connect('stopMusic', function(music)
    audio.stop(music)
  end)
end

function love.update(dt)
  player:update(dt)
end

function love.draw()
  World:draw()
  player:draw()
end

function love.keypressed(key)
  controls:handleArrowKeys(key)
  controls:handleLevelKeys(key)
  controls.handleMiscKeys(key)
end
