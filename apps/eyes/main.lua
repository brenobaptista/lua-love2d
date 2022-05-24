local eyes = {}

local function loadEye(x, y, eyeRadius, pupilRadius)
  return {
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
  }
end

function love.load()
  table.insert(eyes, loadEye(125, 150, 50, 15))
  table.insert(eyes, loadEye(275, 150, 50, 15))
end

function love.update(dt)
  for _, v in pairs(eyes) do
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
end

local function drawEye(v)
  love.graphics.setColor(love.math.colorFromBytes(248, 248, 242))
  love.graphics.circle('fill', v.eye.x, v.eye.y, v.eye.radius)

  love.graphics.setColor(love.math.colorFromBytes(68, 71, 90))
  love.graphics.circle('fill', v.pupil.x, v.pupil.y, v.pupil.radius)
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(40, 42, 54))

  for _, v in pairs(eyes) do
    drawEye(v)
  end
end
