local colors = {
  background = { 40, 42, 54 },
  eye = { 248, 248, 242 },
  pupil = { 68, 71, 90 }
}

local function drawEye(x, y, eyeRadius, pupilRadius)
  local eye = {}
  eye.x = x
  eye.y = y
  eye.radius = eyeRadius

  local cursor = {}
  cursor.dx = love.mouse.getX() - eye.x
  cursor.dy = love.mouse.getY() - eye.y
  cursor.distance = math.sqrt(cursor.dx ^ 2 + cursor.dy ^ 2)

  local pupil = {}
  pupil.radius = pupilRadius
  local radiusDifference = eye.radius - pupil.radius

  if cursor.distance > radiusDifference then
    pupil.x = eye.x + (cursor.dx * radiusDifference) / cursor.distance
    pupil.y = eye.y + (cursor.dy * radiusDifference) / cursor.distance
  else
    pupil.x = eye.x + cursor.dx
    pupil.y = eye.y + cursor.dy
  end

  love.graphics.setBackgroundColor(
    love.math.colorFromBytes(
      colors.background[1],
      colors.background[2],
      colors.background[3]
    )
  )

  love.graphics.setColor(
    love.math.colorFromBytes(
      colors.eye[1],
      colors.eye[2],
      colors.eye[3]
    )
  )
  love.graphics.circle(
    'fill',
    eye.x,
    eye.y,
    eye.radius
  )

  love.graphics.setColor(
    love.math.colorFromBytes(
      colors.pupil[1],
      colors.pupil[2],
      colors.pupil[3]
    )
  )
  love.graphics.circle(
    'fill',
    pupil.x,
    pupil.y,
    pupil.radius
  )
end

function love.draw()
  drawEye(125, 150, 50, 15)
  drawEye(275, 150, 50, 15)
end
