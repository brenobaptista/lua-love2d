Mixer = require('libs/mixer')
Signals = require('libs/signals')
World = require('src/world')
local controls = require('src/controls')
local player = require('src/player')

function love.load()
  player:load()
  World:load()
  controls:load()
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
