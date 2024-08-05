local ball = {}
ball.__index = ball

function ball.new(initialX, initialY, velocityX, velocityY, radius)
  local self = setmetatable({}, ball)

  self.radius = radius
  self.physics = {}
  self.physics.body = love.physics.newBody(World, initialX, initialY, 'dynamic')
  self.physics.body:setLinearVelocity(velocityX, velocityY)
  self.physics.shape = love.physics.newCircleShape(self.radius)
  self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
  self.physics.fixture:setRestitution(0.8)

  return self
end

function ball:checkBoundariesAndRemove(removeFromTable, index)
  local x, y = self.physics.body:getPosition()

  if
      x < -self.radius
      or x > love.graphics.getWidth() / 2 + self.radius
      or y < -self.radius
      or y > love.graphics.getHeight() / 2 + self.radius
  then
    self.physics.body:destroy()
    removeFromTable(index)
  end
end

function ball:draw()
  local x, y = self.physics.body:getPosition()

  love.graphics.setColor(love.math.colorFromBytes(255, 85, 85))
  love.graphics.circle('line', x, y, self.radius)
  love.graphics.setColor(1, 1, 1)
end

return ball
