local player = {}

function player:load()
  self.width = Map.layers['Player'].objects[1].width
  self.height = Map.layers['Player'].objects[1].height
  self.initialX = Map.layers['Player'].objects[1].x + self.width / 2
  self.initialY = Map.layers['Player'].objects[1].y + self.height / 2

  self.grounded = false
  self.defaultGracePeriod = 0.15
  self.jumpGraceTimer = self.defaultGracePeriod
  self.jumpImpulse = 400
  self.movementForce = 400

  self.physics = {}
  self.physics.body = love.physics.newBody(World, self.initialX, self.initialY, 'dynamic')
  self.physics.body:setFixedRotation(true)
  self.physics.body:setLinearDamping(1)
  self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
  self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
  self.physics.sensorShape = love.physics.newRectangleShape(0, self.height / 2, self.width - 2, 2)
  self.physics.sensorFixture = love.physics.newFixture(self.physics.body, self.physics.sensorShape, 0)
  self.physics.sensorFixture:setSensor(true)
end

local function move(self)
  if love.keyboard.isDown('d', 'right') then
    self.physics.body:applyForce(self.movementForce, 0)
  end

  if love.keyboard.isDown('a', 'left') then
    self.physics.body:applyForce(-self.movementForce, 0)
  end
end

local function decreaseGraceTimer(self, dt)
  if not self.grounded and self.jumpGraceTimer > 0 then
    self.jumpGraceTimer = self.jumpGraceTimer - dt
  end
end

function player:update(dt)
  move(self)
  decreaseGraceTimer(self, dt)
end

function player:draw()
  love.graphics.setColor(love.math.colorFromBytes(189, 147, 249))
  love.graphics.rectangle(
    'fill',
    self.physics.body:getX() - self.width / 2,
    self.physics.body:getY() - self.height / 2,
    self.width,
    self.height
  )

  if DebugMode then
    love.graphics.setColor(love.math.colorFromBytes(80, 250, 123))
    love.graphics.rectangle(
      'fill',
      self.physics.body:getX() - self.width / 2 + 1,
      self.physics.body:getY() - 1 + self.height / 2,
      self.width - 2,
      2
    )
  end

  love.graphics.setColor(1, 1, 1)
end

function player:beginContact(a, b)
  if a == self.physics.sensorFixture or b == self.physics.sensorFixture then
    self.grounded = true
    self.jumpGraceTimer = self.defaultGracePeriod
  end
end

function player:endContact(a, b)
  if a == self.physics.sensorFixture or b == self.physics.sensorFixture then
    self.grounded = false
  end
end

function player:jump()
  if self.grounded or self.jumpGraceTimer > 0 then
    self.physics.body:applyLinearImpulse(0, -self.jumpImpulse)
    self.jumpGraceTimer = 0
  end
end

return player
