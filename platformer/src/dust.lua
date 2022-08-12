local dust = {}
local pSystem

local function generateParticle(size)
  local particle = love.graphics.newCanvas(size, size)
  love.graphics.setCanvas(particle)
  love.graphics.circle('fill', size / 2, size / 2, size / 2)
  love.graphics.setCanvas()

  return particle
end

function dust.load()
  local particle = generateParticle(4)
  pSystem = love.graphics.newParticleSystem(particle, 10)
  pSystem:setParticleLifetime(0.1, 0.2)
  pSystem:setColors(1, 1, 1, 0.4, 0.5, 0.5, 0.5, 0.1)
  pSystem:setSizes(0.25, 0.5)
  pSystem:setDirection(-math.pi / 2)
  pSystem:setLinearAcceleration(0, -50)
end

function dust.update(dt)
  pSystem:update(dt)
end

function dust.draw()
  love.graphics.draw(pSystem)
end

function dust.setPosition(x, y)
  pSystem:setPosition(x, y)
end

function dust.emit()
  pSystem:emit(1)
end

return dust
