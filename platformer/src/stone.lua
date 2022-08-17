local stone = {}
local state = {}

local function load(polygon, width, height, initialX, initialY)
  local body = love.physics.newBody(World, initialX, initialY, 'dynamic')
  local shape = {}
  if polygon == 'rectangle' then
    shape = love.physics.newRectangleShape(width, height)
  elseif polygon == 'ellipse' then
    shape = love.physics.newCircleShape(width / 2)
  end
  local fixture = love.physics.newFixture(body, shape)

  table.insert(state, {
    polygon = polygon,
    width = width,
    height = height,
    initialX = initialX,
    initialY = initialY,
    physics = {
      body = body,
      shape = shape,
      fixture = fixture
    },
  })
end

function stone.loadAll()
  for i = 1, #Map.layers['Stone'].objects do
    local polygon = Map.layers['Stone'].objects[i].shape
    local width = Map.layers['Stone'].objects[i].width
    local height = Map.layers['Stone'].objects[i].height
    local initialX = Map.layers['Stone'].objects[i].x + width / 2
    local initialY = Map.layers['Stone'].objects[i].y + height / 2

    load(polygon, width, height, initialX, initialY)
  end
end

local function loop(callback)
  for _, value in pairs(state) do
    callback(value)
  end
end

local function draw(value)
  love.graphics.push()
  love.graphics.translate(
    value.physics.body:getX(),
    value.physics.body:getY()
  )
  love.graphics.rotate(value.physics.body:getAngle())
  love.graphics.setColor(love.math.colorFromBytes(98, 114, 164))
  if value.polygon == 'rectangle' then
    love.graphics.rectangle('line', -value.width / 2, -value.height / 2, value.width, value.height)
  elseif value.polygon == 'ellipse' then
    love.graphics.circle('line', 0, 0, value.width / 2)
  end
  love.graphics.pop()

  love.graphics.setColor(1, 1, 1)
end

function stone.drawAll()
  loop(function(value)
    draw(value)
  end)
end

return stone
