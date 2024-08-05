local countdown = {}

function countdown:load()
  self.interval = 1
  self.timer = self.interval
end

function countdown:update(dt, callback)
  self.timer = self.timer - dt

  if self.timer <= 0 then
    callback()
    self.timer = self.interval
  end
end

return countdown
