local pause = {
  isPaused = false,
  text = "Paused",
  canToggle = true
}

function pause:toggle()
  if self.canToggle then
    self.isPaused = not self.isPaused
  end
end

function pause:draw()
  if self.isPaused then
    local font = love.graphics.newFont(48)
    local offsetFontHeight = math.ceil(font:getHeight() / 2)

    love.graphics.push("all")

    love.graphics.setColor(0, 0, 0, 0.3)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
    love.graphics.printf(
      self.text,
      font,
      0,
      love.graphics.getHeight() / 2 - offsetFontHeight,
      love.graphics.getWidth(),
      "center"
    )

    love.graphics.pop()
  end
end

return pause
