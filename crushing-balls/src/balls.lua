local ball = require('src/ball')

local balls = {}
local state = {}

local function loop(callback)
  for _, value in pairs(state) do
    callback(value)
  end
end

function balls.load()
  math.randomseed(os.time())
end

function balls.spawn()
  local side = math.random(2)
  local initialX
  local initialY = Map.height * Map.tileheight / 4
  local velocityX = 160
  local radius = 24
  local offsetX = radius + Map.tilewidth

  if side == 1 then
    initialX = offsetX
  else
    initialX = Map.width * Map.tilewidth / 2 - offsetX
    velocityX = -velocityX
  end

  table.insert(state, ball.new(initialX, initialY, velocityX, radius))
end

function balls.draw()
  loop(function(value)
    value:draw()
  end)
end

return balls
