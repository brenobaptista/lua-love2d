local controls = {}

function controls:load()
  love.keyboard.setKeyRepeat(true)

  self.arrowKeys = {
    up = { 0, -1 },
    down = { 0, 1 },
    left = { -1, 0 },
    right = { 1, 0 }
  }
  self.levelKeys = {
    r = 0,
    n = 1,
    p = -1
  }
end

function controls:handleArrowKeys(key)
  for direction, gridDifference in pairs(self.arrowKeys) do
    if key == direction then
      Signals.send('arrowKeyPressed', gridDifference[1], gridDifference[2])
    end
  end
end

function controls:handleLevelKeys(key)
  for selection, levelDifference in pairs(self.levelKeys) do
    if key == selection then
      Signals.send('levelKeyPressed', levelDifference)
    end
  end
end

function controls.handleMiscKeys(key)
  if key == 'm' then
    Signals.send('stopMusic', 'music')
  end
end

return controls
