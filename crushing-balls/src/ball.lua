local ball = {}
ball.__index = ball

function ball.new(initialX, initialY, velocityX, radius)
  local self = setmetatable({}, ball)

  self.radius = radius
  self.physics = {}
  self.physics.body = love.physics.newBody(World, initialX, initialY, 'dynamic')
  self.physics.body:setLinearVelocity(velocityX, 0)
  self.physics.shape = love.physics.newCircleShape(self.radius)
  self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
  self.physics.fixture:setRestitution(0.8)

  return self
end

function ball:draw()
  love.graphics.setColor(love.math.colorFromBytes(255, 85, 85))
  love.graphics.circle('fill', self.physics.body:getX(), self.physics.body:getY(), self.radius)
  love.graphics.setColor(1, 1, 1)
end

return ball
