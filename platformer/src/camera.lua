local camera = {
  translateX = 0,
  translateY = 0,
  scale = 2
}

function camera:draw(callback)
  love.graphics.push("transform")
  love.graphics.scale(self.scale, self.scale)
  love.graphics.translate(-self.translateX, -self.translateY)
  callback()
  love.graphics.pop()
end

function camera:setPosition(x, y)
  local mapWidth = Map.width * Map.tilewidth
  self.translateX = math.max(x - love.graphics.getWidth() / 2 / self.scale, 0)
  self.translateX = math.min(self.translateX, mapWidth - love.graphics.getWidth() / 2)

  local mapHeight = Map.height * Map.tileheight
  self.translateY = math.max(y - love.graphics.getHeight() / 2 / self.scale, 0)
  self.translateY = math.min(self.translateY, mapHeight - love.graphics.getHeight() / 2)
end

return camera
