local eye = {}
local state = {}

function eye.load(x, y, eyeRadius, pupilRadius)
  table.insert(state, {
    cornea = {
      x = x,
      y = y,
      radius = eyeRadius
    },
    pupil = {
      x = x,
      y = y,
      radius = pupilRadius
    }
  })
end

local function loop(callback)
  for _, value in pairs(state) do
    callback(value)
  end
end

local function update(value)
  local cursor = {}
  cursor.dx = love.mouse.getX() - value.cornea.x
  cursor.dy = love.mouse.getY() - value.cornea.y
  cursor.distance = math.sqrt(cursor.dx ^ 2 + cursor.dy ^ 2)

  local radiusDifference = value.cornea.radius - value.pupil.radius
  if cursor.distance > radiusDifference then
    value.pupil.x = value.cornea.x + (cursor.dx * radiusDifference) / cursor.distance
    value.pupil.y = value.cornea.y + (cursor.dy * radiusDifference) / cursor.distance
  else
    value.pupil.x = value.cornea.x + cursor.dx
    value.pupil.y = value.cornea.y + cursor.dy
  end
end

function eye.updateAll()
  loop(function(value)
    update(value)
  end)
end

local function draw(value)
  love.graphics.push("all")
  love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  love.graphics.circle('fill', value.cornea.x, value.cornea.y, value.cornea.radius)

  love.graphics.setColor(love.math.colorFromBytes(68, 71, 90))
  love.graphics.circle('fill', value.pupil.x, value.pupil.y, value.pupil.radius)
  love.graphics.pop()
end

function eye.drawAll()
  loop(function(value)
    draw(value)
  end)
end

return eye
