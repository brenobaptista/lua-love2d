local player = {}

function player:load()
  self.drawn = { x = 0, y = 0 }
  self.nextDrawn = { x = 0, y = 0 }
  self.transitionSpeed = 25
  self.color = { love.math.colorFromBytes(189, 147, 249) }

  Signal.connect('loadPlayerPosition', function()
    local initialPlayerPosition = {
      x = World.initialPlayerPosition.x * World.tileSize,
      y = World.initialPlayerPosition.y * World.tileSize
    }
    for axis, position in pairs(initialPlayerPosition) do
      self.drawn[axis] = position
      self.nextDrawn[axis] = position
    end
  end)

  Mixer.loadSound('blip', 'audio/blip-sound.wav')
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
  love.graphics.setColor(1, 1, 1)
end

Signal.connect('arrowKeyPressed', function(dx, dy)
  local nextDrawnX = (player.nextDrawn.x / World.tileSize) + dx
  local nextDrawnY = (player.nextDrawn.y / World.tileSize) + dy
  Signal.send('playerTryingToMove', nextDrawnX, nextDrawnY, dx, dy)
end)

Signal.connect('movePlayer', function(nextDrawnX, nextDrawnY)
  player.nextDrawn.x = nextDrawnX * World.tileSize
  player.nextDrawn.y = nextDrawnY * World.tileSize
  Mixer.playSound('blip')
end)

return player
