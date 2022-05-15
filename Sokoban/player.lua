require("world")

player = {}
player.rendered = {
  ["x"] = world.tileSize * 2,
  ["y"] = world.tileSize * 3
}
player.destination = {
  ["x"] = world.tileSize * 3,
  ["y"] = world.tileSize * 3
}
player.transitionSpeed = 25
player.color = { 189, 147, 249 }

function player.draw()
  local padding = world.tileSize / 4
  love.graphics.setColor(love.math.colorFromBytes(player.color[1], player.color[2], player.color[3]))
	love.graphics.rectangle("fill", player.rendered.x + padding, player.rendered.y + padding, world.tileSize - padding * 2, world.tileSize - padding * 2)
end

function player.updatePlayerRenderedPosition(dt)
  player.rendered.y = player.rendered.y - ((player.rendered.y - player.destination.y) * player.transitionSpeed * dt)
	player.rendered.x = player.rendered.x - ((player.rendered.x - player.destination.x) * player.transitionSpeed * dt)
end

function player.updatePlayerDestinationPosition(x, y)
  player.destination.y = player.destination.y + world.tileSize * y
  player.destination.x = player.destination.x + world.tileSize * x
end
