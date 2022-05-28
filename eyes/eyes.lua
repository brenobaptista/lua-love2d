local eyes = {}
local eyesState = {}

function eyes.load(x, y, eyeRadius, pupilRadius)
  table.insert(eyesState, {
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

function eyes.update(eye)
  local cursor = {
    dx = love.mouse.getX() - eye.cornea.x,
    dy = love.mouse.getY() - eye.cornea.y
  }
  cursor.distance = math.sqrt(cursor.dx ^ 2 + cursor.dy ^ 2)

  local radiusDifference = eye.cornea.radius - eye.pupil.radius
  if cursor.distance > radiusDifference then
    eye.pupil.x = eye.cornea.x + (cursor.dx * radiusDifference) / cursor.distance
    eye.pupil.y = eye.cornea.y + (cursor.dy * radiusDifference) / cursor.distance
  else
    eye.pupil.x = eye.cornea.x + cursor.dx
    eye.pupil.y = eye.cornea.y + cursor.dy
  end
end

function eyes.draw(eye)
  love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  love.graphics.circle('fill', eye.cornea.x, eye.cornea.y, eye.cornea.radius)

  love.graphics.setColor(love.math.colorFromBytes(68, 71, 90))
  love.graphics.circle('fill', eye.pupil.x, eye.pupil.y, eye.pupil.radius)
end

function eyes.loop(callback)
  for _, eye in pairs(eyesState) do
    callback(eye)
  end
end

return eyes
