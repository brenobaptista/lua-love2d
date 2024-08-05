local ball = require('src/ball')

local balls = {}
local state = {}

function balls.load()
  math.randomseed(os.time())
end

function balls.spawn()
  local side = math.random(2)
  local initialX
  local initialY = love.graphics.getHeight() / 4
  local velocityX = 160
  local radius = 24
  local offsetX = radius + Map.tilewidth

  if side == 1 then
    initialX = offsetX
  else
    initialX = love.graphics.getWidth() / 2 - offsetX
    velocityX = -velocityX
  end

  table.insert(state, ball.new(initialX, initialY, velocityX, radius))
end

local function removeFromTable(index)
  table.remove(state, index)
end

function balls.update()
  for index, value in ipairs(state) do
    value:checkBoundariesAndRemove(removeFromTable, index)
  end
end

function balls.draw()
  for _, value in ipairs(state) do
    value:draw()
  end
end

return balls
