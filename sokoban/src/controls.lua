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

local function handleArrowKeys(key)
  for direction, gridDifference in pairs(controls.arrowKeys) do
    if key == direction then
      Signals.send('arrowKeyPressed', gridDifference[1], gridDifference[2])
    end
  end
end

local function handleLevelKeys(key)
  for selection, levelDifference in pairs(controls.levelKeys) do
    if key == selection then
      Signals.send('loadLevelDifference', levelDifference)
    end
  end
end

local function handleMiscKeys(key)
  if key == 'm' then
    Audio.stop('music')
  end
end

function controls:keypressed(key)
  handleArrowKeys(key)
  handleLevelKeys(key)
  handleMiscKeys(key)
end

return controls
