DebugMode = false
if arg[#arg] == '-debug' then DebugMode = true end

local sti = require('libs/sti')
local camera = require('src/camera')
local player = require('src/player')

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
  player:load()

  if not DebugMode then
    Map.layers['Collision'].visible = false
    Map.layers['Player'].visible = false
  end
end

function love.update(dt)
  World:update(dt)
  player:update(dt)

  local x, y = player:getPosition()
  camera:setPosition(x, y)
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(40, 42, 54))

  Map:draw(-camera.translateX, -camera.translateY, camera.scale, camera.scale)
  camera:draw(function()
    player:draw()
  end)
end

function love.keypressed(key)
  if (key == 'w' or key == 'up' or key == 'space') then
    player:jump()
  end
end
