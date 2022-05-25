eyes = {}
local e = {}

function eyes.load(x, y, eyeRadius, pupilRadius)
  table.insert(e, {
    eye = {
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

function eyes.update(v)
  local cursor = {
    dx = love.mouse.getX() - v.eye.x,
    dy = love.mouse.getY() - v.eye.y
  }
  cursor.distance = math.sqrt(cursor.dx ^ 2 + cursor.dy ^ 2)

  local radiusDifference = v.eye.radius - v.pupil.radius
  if cursor.distance > radiusDifference then
    v.pupil.x = v.eye.x + (cursor.dx * radiusDifference) / cursor.distance
    v.pupil.y = v.eye.y + (cursor.dy * radiusDifference) / cursor.distance
  else
    v.pupil.x = v.eye.x + cursor.dx
    v.pupil.y = v.eye.y + cursor.dy
  end
end

function eyes.draw(v)
  love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  love.graphics.circle('fill', v.eye.x, v.eye.y, v.eye.radius)

  love.graphics.setColor(love.math.colorFromBytes(68, 71, 90))
  love.graphics.circle('fill', v.pupil.x, v.pupil.y, v.pupil.radius)
end

function eyes.loop(callback)
  for _, v in pairs(e) do
    callback(v)
  end
end
