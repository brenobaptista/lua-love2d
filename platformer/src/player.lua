local dust = require('src/dust')

local player = {}

function player:load()
  self.width = Map.layers['Player'].objects[1].width
  self.height = Map.layers['Player'].objects[1].height
  self.radius = Map.layers['Player'].objects[1].width / 2
  self.initialX = Map.layers['Player'].objects[1].x + self.width / 2
  self.initialY = Map.layers['Player'].objects[1].y + self.height / 2

  self.grounded = false
  self.defaultGracePeriod = 0.15
  self.jumpGraceTimer = self.defaultGracePeriod
  self.jumpImpulse = 200
  self.movementForce = 200
  self.groundCollisions = {}

  self.physics = {}
  self.physics.body = love.physics.newBody(World, self.initialX, self.initialY, 'dynamic')
  self.physics.body:setFixedRotation(true)
  self.physics.body:setLinearDamping(1)
  self.physics.shape = love.physics.newCircleShape(self.radius)
  self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
  self.physics.sensorShape = love.physics.newRectangleShape(0, self.height / 2, self.width - 2, 2)
  self.physics.sensorFixture = love.physics.newFixture(self.physics.body, self.physics.sensorShape, 0)
  self.physics.sensorFixture:setSensor(true)

  self.xVelEmitDust = 20
  dust.load()
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

local function emitDust(self)
  local xVel, _ = self.physics.body:getLinearVelocity()
  if self.grounded and math.abs(xVel) > self.xVelEmitDust then
    dust.setPosition(self.physics.body:getX(), self.physics.body:getY() + self.radius)
    dust.emit()
  end
end

function player:update(dt)
  move(self)
  decreaseGraceTimer(self, dt)

  emitDust(self)
  dust.update(dt)
end

function player:draw()
  love.graphics.setColor(love.math.colorFromBytes(189, 147, 249))
  love.graphics.circle(
    'line',
    self.physics.body:getX(),
    self.physics.body:getY(),
    self.radius
  )

  if DebugMode then
    love.graphics.setColor(love.math.colorFromBytes(80, 250, 123))
    love.graphics.print(tostring(self.grounded), 16)
    love.graphics.rectangle(
      'line',
      self.physics.body:getX() - self.width / 2 + 1,
      self.physics.body:getY() - 1 + self.height / 2,
      self.width - 2,
      2
    )
  end

  love.graphics.setColor(1, 1, 1)
  dust.draw()
end

function player:beginContact(a, b, collision)
  if a == self.physics.sensorFixture or b == self.physics.sensorFixture then
    table.insert(self.groundCollisions, collision)
    self.grounded = true
    self.jumpGraceTimer = self.defaultGracePeriod
  end
end

function player:endContact(a, b, collision)
  if a == self.physics.sensorFixture or b == self.physics.sensorFixture then
    for position, groundCollision in pairs(self.groundCollisions) do
      if groundCollision == collision then
        table.remove(self.groundCollisions, position)
        break
      end
    end
  end

  if #self.groundCollisions == 0 then
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
