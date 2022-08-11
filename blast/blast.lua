local blast = {}
local pSystem

local function generateParticle(size)
  local particle = love.graphics.newCanvas(size, size)
  love.graphics.setCanvas(particle)
  love.graphics.circle('fill', size / 2, size / 2, size / 2)
  love.graphics.setCanvas()

  return particle
end

function blast.load()
  local particle = generateParticle(128)
  pSystem = love.graphics.newParticleSystem(particle, 1)
  pSystem:setParticleLifetime(0.25, 0.25)
  pSystem:setColors(1, 1, 1, 0.5, 1, 1, 1, 0)
  pSystem:setSizes(0.1, 1)
end

function blast.update(dt)
  pSystem:update(dt)
end

function blast.draw()
  love.graphics.draw(pSystem)
end

function blast.setPosition(x, y)
  pSystem:setPosition(x, y)
end

function blast.emit()
  pSystem:emit(1)
end

return blast
