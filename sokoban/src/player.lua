local player = {}

function player:load()
  self.drawn = { x = 0, y = 0 }
  self.nextDrawn = { x = 0, y = 0 }
  self.transitionSpeed = 25
  self.color = { love.math.colorFromBytes(189, 147, 249) }

  self:loadPosition()
end

function player:update(dt)
  self.drawn.x = self.drawn.x - ((self.drawn.x - self.nextDrawn.x) * self.transitionSpeed * dt)
  self.drawn.y = self.drawn.y - ((self.drawn.y - self.nextDrawn.y) * self.transitionSpeed * dt)
end

function player:draw()
  local padding = World.tileSize / 4
  local radius = World.tileSize / 16
  love.graphics.setColor(self.color)
  love.graphics.rectangle(
    'fill',
    self.drawn.x + padding,
    self.drawn.y + padding,
    World.tileSize - padding * 2,
    World.tileSize - padding * 2,
    radius,
    radius
  )
end

function player:loadPosition()
  local initialPlayerPosition = {
    x = World.initialPlayerPosition.x * World.tileSize,
    y = World.initialPlayerPosition.y * World.tileSize
  }
  for axis, position in pairs(initialPlayerPosition) do
    self.drawn[axis] = position
    self.nextDrawn[axis] = position
  end
end

function player:updateNextDrawn(dx, dy)
  self.nextDrawn.x = self.nextDrawn.x + World.tileSize * dx
  self.nextDrawn.y = self.nextDrawn.y + World.tileSize * dy
end

function player:canMove(dx, dy)
  local nextDrawnX = (self.nextDrawn.x / World.tileSize) + dx
  local nextDrawnY = (self.nextDrawn.y / World.tileSize) + dy
  local nextDrawnTile = World:getTile(nextDrawnX, nextDrawnY)

  if nextDrawnTile == World.symbols.wall or nextDrawnTile == nil then return false end

  if nextDrawnTile == World.symbols.box or nextDrawnTile == World.symbols.boxOnStorage then
    local didBoxMove = World:moveBox(nextDrawnX, nextDrawnY, dx, dy)
    if not didBoxMove then return false end
  end

  return true
end

return player
