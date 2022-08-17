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
  for _, instance in pairs(state) do
    callback(instance)
  end
end

local function update(instance, mouseX, mouseY)
  local isMouseHovering = mouseX > instance.buttonX and mouseX < instance.buttonX + width and
      mouseY > instance.buttonY and mouseY < instance.buttonY + height
  instance.isHovered = isMouseHovering
  if instance.isHovered then love.mouse.setCursor(cursor) end
end

function button.updateAll()
  local mouseX, mouseY = love.mouse.getPosition()
  love.mouse.setCursor()

  loop(function(instance)
    update(instance, mouseX, mouseY)
  end)
end

local function draw(instance)
  local buttonColor = { love.math.colorFromBytes(64, 71, 90) }
  if instance.isHovered then
    buttonColor = { love.math.colorFromBytes(98, 114, 164) }
  end
  love.graphics.setColor(buttonColor)
  love.graphics.rectangle(
    'fill',
    instance.buttonX,
    instance.buttonY,
    width,
    height,
    radius,
    radius
  )

  love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  love.graphics.printf(
    instance.text,
    font,
    instance.buttonX,
    instance.buttonY + (height / 2) - math.ceil(font:getHeight() / 2),
    width,
    'center'
  )

  love.graphics.setColor(1, 1, 1)
end

function button.drawAll()
  loop(function(instance)
    draw(instance)
  end)
end

function button.handleClick()
  loop(function(instance)
    if instance.isHovered then instance.callback() end
  end)
end

return button
