local pause = {
  isPaused = false,
  text = "Paused"
}

function pause:toggle()
  self.isPaused = not self.isPaused
end

function pause:draw()
  if self.isPaused then
    love.graphics.push("all")

    love.graphics.setColor(0, 0, 0, 0.3)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
    love.graphics.setNewFont(24)
    love.graphics.printf(self.text, 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")

    love.graphics.pop()
  end
end

return pause
