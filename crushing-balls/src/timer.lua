local timer = {
  elapsedTime = 0
}

function timer:update(dt)
  self.elapsedTime = self.elapsedTime + dt
end

function timer:draw()
  local formattedTime = string.format("%.1f", self.elapsedTime)
  local font = love.graphics.newFont(40)
  local offsetFontHeight = math.ceil(font:getHeight() / 2)

  love.graphics.push("all")
  love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  love.graphics.printf(
    formattedTime,
    font,
    0,
    love.graphics.getHeight() / 4 - offsetFontHeight,
    love.graphics.getWidth(),
    "center"
  )
  love.graphics.pop()
end

return timer
