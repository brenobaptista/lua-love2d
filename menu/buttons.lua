local buttons = {}
local buttonsState = {}

buttons.radius = 4
buttons.margin = 16
buttons.height = 64
buttons.width = 256
buttons.font = love.graphics.newFont('fonts/Inter/Inter-Thin.ttf', 32)
buttons.cursor = love.mouse.getSystemCursor("hand")

function buttons:load(text, callback)
  table.insert(buttonsState, {
    text = text,
    callback = callback,
    isHovered = false,
    buttonX = (love.graphics.getWidth() / 2) - (self.width / 2)
  })

  local totalHeight = (self.height + self.margin) * #buttonsState
  for i = 1, #buttonsState do
    buttonsState[i].buttonY = (love.graphics.getHeight() / 2) - (totalHeight / 2) +
        (i - 1) * (self.height + self.margin)
  end
end

function buttons:update(button, mouseX, mouseY)
  local isMouseHovering = mouseX > button.buttonX and mouseX < button.buttonX + self.width and
      mouseY > button.buttonY and mouseY < button.buttonY + self.height
  button.isHovered = isMouseHovering
end

function buttons:draw(button)
  local buttonColor
  if button.isHovered then
    buttonColor = { love.math.colorFromBytes(98, 114, 164) }
  else
    buttonColor = { love.math.colorFromBytes(64, 71, 90) }
  end

  love.graphics.setColor(buttonColor)
  love.graphics.rectangle(
    'fill',
    button.buttonX,
    button.buttonY,
    self.width,
    self.height,
    self.radius,
    self.radius
  )

  love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  love.graphics.printf(
    button.text,
    self.font,
    button.buttonX,
    button.buttonY + (self.height / 2) - math.ceil(self.font:getHeight() / 2),
    self.width,
    "center"
  )
end

function buttons.loop(callback)
  for _, button in pairs(buttonsState) do callback(button) end
end

local function findHoveredButton()
  for _, button in pairs(buttonsState) do
    if button.isHovered then return true, button end
  end

  return false
end

function buttons.handleClick()
  local found, button = findHoveredButton()
  if found then button.callback() end
end

function buttons:setCursor()
  local found = findHoveredButton()
  if found then love.mouse.setCursor(self.cursor) else love.mouse.setCursor() end
end

return buttons
