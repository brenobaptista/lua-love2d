local button = {}
local state = {}

local radius = 4
local margin = 16
local height = 64
local width = 256
local font = love.graphics.newFont('fonts/Inter/Inter-Thin.ttf', 32)
local cursor = love.mouse.getSystemCursor('hand')

function button.load(text, callback)
  table.insert(state, {
    text = text,
    callback = callback,
    isHovered = false,
    buttonX = (love.graphics.getWidth() / 2) - (width / 2)
  })

  local totalHeight = (height + margin) * #state
  for i = 1, #state do
    state[i].buttonY = (love.graphics.getHeight() / 2) - (totalHeight / 2) +
        (i - 1) * (height + margin)
  end
end

local function loop(callback)
  for _, value in pairs(state) do
    callback(value)
  end
end

local function update(value, mouseX, mouseY)
  local isMouseHovering = mouseX > value.buttonX and mouseX < value.buttonX + width and
      mouseY > value.buttonY and mouseY < value.buttonY + height
  value.isHovered = isMouseHovering
  if value.isHovered then love.mouse.setCursor(cursor) end
end

function button.updateAll()
  local mouseX, mouseY = love.mouse.getPosition()
  love.mouse.setCursor()

  loop(function(value)
    update(value, mouseX, mouseY)
  end)
end

local function draw(value)
  local buttonColor = { love.math.colorFromBytes(64, 71, 90) }
  if value.isHovered then
    buttonColor = { love.math.colorFromBytes(98, 114, 164) }
  end
  love.graphics.setColor(buttonColor)
  love.graphics.rectangle(
    'fill',
    value.buttonX,
    value.buttonY,
    width,
    height,
    radius,
    radius
  )

  love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  love.graphics.printf(
    value.text,
    font,
    value.buttonX,
    value.buttonY + (height / 2) - math.ceil(font:getHeight() / 2),
    width,
    'center'
  )

  love.graphics.setColor(1, 1, 1)
end

function button.drawAll()
  loop(function(value)
    draw(value)
  end)
end

function button.handleClick()
  loop(function(value)
    if value.isHovered then value.callback() end
  end)
end

return button
