Signals = require('../signals/signals')
World = require('src/world')
local audio = require('src/audio')
local controls = require('src/controls')
local player = require('src/player')

function love.load()
  player:load()
  World:load()
  controls:load()

  audio.load('blip', 'audio/blip-sound.wav', 'static')
  audio.load('music', 'audio/game-music.mp3', 'stream', true)
  audio.play('music')
  Signals.connect('playAudio', function(selectedAudio)
    audio.play(selectedAudio)
  end)
  Signals.connect('stopAudio', function(selectedAudio)
    audio.stop(selectedAudio)
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
  controls:keypressed(key)
end
