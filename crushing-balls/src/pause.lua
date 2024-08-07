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

    love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
    love.graphics.setNewFont(20)
    love.graphics.printf(self.text, 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")

    love.graphics.pop()
  end
end

return pause
