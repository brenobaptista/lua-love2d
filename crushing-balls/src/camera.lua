local camera = {
  scale = 2
}

function camera:draw(callback)
  love.graphics.push()
  love.graphics.scale(self.scale, self.scale)
  callback()
  love.graphics.pop()
end

return camera
