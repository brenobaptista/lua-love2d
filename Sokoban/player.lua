player = {}

local drawn = {}
local nextDrawn = {}
local transitionSpeed = 25
local color = { 189, 147, 249 }

function player.loadPosition()
  local initialPlayerPosition = world.getInitialPlayerPosition()
  for axis, position in pairs(initialPlayerPosition) do
    drawn[axis] = position
    nextDrawn[axis] = position
  end
end

function player.draw()
  local padding = world.tileSize / 4
  love.graphics.setColor(
    love.math.colorFromBytes(
      color[1],
      color[2],
      color[3]
    )
  )
  love.graphics.rectangle(
    'fill',
    drawn.x + padding,
    drawn.y + padding,
    world.tileSize - padding * 2,
    world.tileSize - padding * 2
  )
end

function player.updateDrawn(dt)
  drawn.y = drawn.y - ((drawn.y - nextDrawn.y) * transitionSpeed * dt)
  drawn.x = drawn.x - ((drawn.x - nextDrawn.x) * transitionSpeed * dt)
end

function player.updateNextDrawn(dx, dy)
  nextDrawn.y = nextDrawn.y + world.tileSize * dy
  nextDrawn.x = nextDrawn.x + world.tileSize * dx
end

function player.canMove(dx, dy)
  local nextDrawnX = (nextDrawn.x / world.tileSize) + dx
  local nextDrawnY = (nextDrawn.y / world.tileSize) + dy
  local nextDrawnTile = world.getTile(nextDrawnX, nextDrawnY)

  if nextDrawnTile == world.symbols.wall or nextDrawnTile == nil then
    return false
  end

  if nextDrawnTile == world.symbols.box or nextDrawnTile == world.symbols.boxOnStorage then
    local didBoxMove = world.moveBox(nextDrawnX, nextDrawnY, dx, dy)

    if not didBoxMove then
      return false
    end
  end

  return true
end
