local sti = require('libs/sti')
local balls = require('src/balls')
local camera = require('src/camera')
local countdown = require('src/countdown')
local pause = require('src/pause')
local player = require('src/player')
local timer = require('src/timer')

local realGravity, pixelsPerMeter, multiplier = 9.81, 16, 3
love.physics.setMeter(pixelsPerMeter)
World = love.physics.newWorld(0, realGravity * pixelsPerMeter * multiplier)
Map = sti('maps/map.lua', { 'box2d' })

local function beginContact(a, b, collision)
  player:beginContact(a, b, collision)
end

local function endContact(a, b, collision)
  player:endContact(a, b, collision)
end

function love.load()
  World:setCallbacks(beginContact, endContact)
  Map:box2d_init(World)
  Map.layers['Collision'].visible = false
  Map.layers['Player'].visible = false

  balls.load()
  countdown:load(0.5)
  player:load()
end

function love.update(dt)
  if pause.isPaused then return end

  World:update(dt)
  player:update(dt)
  countdown:update(dt, balls.spawn)
  timer:update(dt)
  balls.update()
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(40, 42, 54))

  Map:draw(0, 0, camera.scale, camera.scale)
  timer:draw()
  camera:draw(function()
    player:draw()
    balls.draw()
  end)
  pause:draw()
end

function love.keypressed(key)
  if key == 'escape' then
    pause:toggle()
  end

  if (key == 'w' or key == 'up' or key == 'space') then
    player:jump()
  end
end
