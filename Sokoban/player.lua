require('world')

player = {}
player.drawn = {
  ['x'] = world.tileSize * 2,
  ['y'] = world.tileSize * 3
}
player.nextDrawn = {
  ['x'] = world.tileSize * 3,
  ['y'] = world.tileSize * 3
}
player.transitionSpeed = 25
player.color = { 189, 147, 249 }

function player.draw()
  local padding = world.tileSize / 4
  love.graphics.setColor(love.math.colorFromBytes(player.color[1], player.color[2], player.color[3]))
	love.graphics.rectangle('fill', player.drawn.x + padding, player.drawn.y + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
end

function player.updateDrawn(dt)
  player.drawn.y = player.drawn.y - ((player.drawn.y - player.nextDrawn.y) * player.transitionSpeed * dt)
	player.drawn.x = player.drawn.x - ((player.drawn.x - player.nextDrawn.x) * player.transitionSpeed * dt)
end

function player.updateNextDrawn(x, y)
  player.nextDrawn.y = player.nextDrawn.y + world.tileSize * y
  player.nextDrawn.x = player.nextDrawn.x + world.tileSize * x
end

function player.canMove(x, y)
  local nextDrawnX = (player.nextDrawn.x / world.tileSize) + x
  local nextDrawnY = (player.nextDrawn.y / world.tileSize) + y
  local nextDrawnTile = world.getTile(nextDrawnX, nextDrawnY)

  if nextDrawnTile == '#' or nextDrawnTile == nil then
		return false
	end

  if nextDrawnTile == '$' or nextDrawnTile == '*' then
    local didBoxMove = world.moveBox(nextDrawnX, nextDrawnY, x, y)

    if not didBoxMove then
      return false
    end
  end

  return true
end
