DebugMode = false
if arg[#arg] == '-debug' then DebugMode = true end

local sti = require('libs/sti')
local player = require('src/player')

local realGravity, pixelsPerMeter, multiplier = 9.81, 16, 2
love.physics.setMeter(pixelsPerMeter)
World = love.physics.newWorld(0, realGravity * pixelsPerMeter * multiplier)
Map = sti('maps/map.lua', { 'box2d' })

local function beginContact(a, b)
  player:beginContact(a, b)
end

local function endContact(a, b)
  player:endContact(a, b)
end

function love.load()
  World:setCallbacks(beginContact, endContact)
  Map:box2d_init(World)
  player:load()

  if not DebugMode then
    Map.layers['Platform'].visible = false
    Map.layers['Player'].visible = false
  end
end

function love.update(dt)
  World:update(dt)
  player:update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(40, 42, 54))
  if DebugMode then
    love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  end

  Map:draw(0, 0, 2, 2)
  love.graphics.push()
  love.graphics.scale(2, 2)
  player:draw()
  love.graphics.pop()
end

function love.keypressed(key)
  if (key == 'w' or key == 'up' or key == 'space') then
    player:jump()
  end
end
