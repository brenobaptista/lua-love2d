local timer = {
  elapsedTime = 0
}

function timer:update(dt)
  self.elapsedTime = self.elapsedTime + dt
end

function timer:draw()
  local formattedTime = string.format("%.1f", self.elapsedTime)

  love.graphics.push("all")
  love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  love.graphics.setNewFont(40)
  love.graphics.printf(formattedTime, 0, love.graphics.getHeight() / 4, love.graphics.getWidth(),
    "center")
  love.graphics.pop()
end

return timer
