local camera = {
  translateX = 0,
  translateY = 0,
  scale = 2
}

function camera:draw(callback)
  love.graphics.push()
  love.graphics.scale(self.scale, self.scale)
  love.graphics.translate(-self.translateX, -self.translateY)
  callback()
  love.graphics.pop()
end

function camera:setPosition(x, y)
  local mapWidth = Map.width * Map.tilewidth
  self.translateX = math.max(x - love.graphics.getWidth() / 2 / self.scale, 0)
  self.translateX = math.min(self.translateX, mapWidth - love.graphics.getWidth() / 2)
  self.translateY = y
end

return camera
