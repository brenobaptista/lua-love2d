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

function player.updatePlayerRenderedPosition(dt)
  player.rendered.y = player.rendered.y - ((player.rendered.y - player.destination.y) * player.transitionSpeed * dt)
	player.rendered.x = player.rendered.x - ((player.rendered.x - player.destination.x) * player.transitionSpeed * dt)
end

function player.updatePlayerDestinationPosition(x, y)
  player.destination.y = player.destination.y + world.tileSize * y
  player.destination.x = player.destination.x + world.tileSize * x
end
