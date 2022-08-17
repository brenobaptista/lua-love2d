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
  for _, instance in pairs(state) do
    callback(instance)
  end
end

local function update(instance)
  local cursor = {}
  cursor.dx = love.mouse.getX() - instance.cornea.x
  cursor.dy = love.mouse.getY() - instance.cornea.y
  cursor.distance = math.sqrt(cursor.dx ^ 2 + cursor.dy ^ 2)

  local radiusDifference = instance.cornea.radius - instance.pupil.radius
  if cursor.distance > radiusDifference then
    instance.pupil.x = instance.cornea.x + (cursor.dx * radiusDifference) / cursor.distance
    instance.pupil.y = instance.cornea.y + (cursor.dy * radiusDifference) / cursor.distance
  else
    instance.pupil.x = instance.cornea.x + cursor.dx
    instance.pupil.y = instance.cornea.y + cursor.dy
  end
end

function eye.updateAll()
  loop(function(instance)
    update(instance)
  end)
end

local function draw(instance)
  love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  love.graphics.circle('fill', instance.cornea.x, instance.cornea.y, instance.cornea.radius)

  love.graphics.setColor(love.math.colorFromBytes(68, 71, 90))
  love.graphics.circle('fill', instance.pupil.x, instance.pupil.y, instance.pupil.radius)

  love.graphics.setColor(1, 1, 1)
end

function eye.drawAll()
  loop(function(instance)
    draw(instance)
  end)
end

return eye
