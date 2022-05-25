player = {}

function player:load()
  self.drawn = { x = 0, y = 0 }
  self.nextDrawn = { x = 0, y = 0 }
  self.transitionSpeed = 25
  self.color = { love.math.colorFromBytes(189, 147, 249) }

  player:loadPosition()
end

function player:update(dt)
  self.drawn.x = self.drawn.x - ((self.drawn.x - self.nextDrawn.x) * self.transitionSpeed * dt)
  self.drawn.y = self.drawn.y - ((self.drawn.y - self.nextDrawn.y) * self.transitionSpeed * dt)
end

function player:draw()
  local padding = world.tileSize / 4
  local radius = world.tileSize / 16
  love.graphics.setColor(self.color)
  love.graphics.rectangle(
    'fill',
    self.drawn.x + padding,
    self.drawn.y + padding,
    world.tileSize - padding * 2,
    world.tileSize - padding * 2,
    radius,
    radius
  )
end

function player:loadPosition()
  local initialPlayerPosition = {
    x = world.initialPlayerPosition.x * world.tileSize,
    y = world.initialPlayerPosition.y * world.tileSize
  }
  for axis, position in pairs(initialPlayerPosition) do
    self.drawn[axis] = position
    self.nextDrawn[axis] = position
  end
end

function player:updateNextDrawn(dx, dy)
  self.nextDrawn.x = self.nextDrawn.x + world.tileSize * dx
  self.nextDrawn.y = self.nextDrawn.y + world.tileSize * dy
end

function player:canMove(dx, dy)
  local nextDrawnX = (self.nextDrawn.x / world.tileSize) + dx
  local nextDrawnY = (self.nextDrawn.y / world.tileSize) + dy
  local nextDrawnTile = world:getTile(nextDrawnX, nextDrawnY)

  if nextDrawnTile == world.symbols.wall or nextDrawnTile == nil then return false end

  if nextDrawnTile == world.symbols.box or nextDrawnTile == world.symbols.boxOnStorage then
    local didBoxMove = world:moveBox(nextDrawnX, nextDrawnY, dx, dy)
    if not didBoxMove then return false end
  end

  return true
end
