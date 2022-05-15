require("map")

function love.load()
  floorColor = { 40, 42, 54 }
  wallColor = { 68, 71, 90 }
  playerColor = { 189, 147, 249 }
	player = {
    renderedX = gridSize * 3,
    renderedY = gridSize * 3,
		destinationX = gridSize * 3,
		destinationY = gridSize * 3,
		transitionSpeed = 25
	}
end

function love.update(dt)
	player.renderedY = player.renderedY - ((player.renderedY - player.destinationY) * player.transitionSpeed * dt)
	player.renderedX = player.renderedX - ((player.renderedX - player.destinationX) * player.transitionSpeed * dt)
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(floorColor[1], floorColor[2], floorColor[3]))

  local padding = 15
  love.graphics.setColor(love.math.colorFromBytes(playerColor[1], playerColor[2], playerColor[3]))
	love.graphics.rectangle("fill", player.renderedX + padding, player.renderedY + padding, gridSize - padding * 2, gridSize - padding * 2)

	for y=1, #map do
		for x=1, #map[y] do
			if map[y][x] == 1 then
        local padding = 1
        love.graphics.setColor(love.math.colorFromBytes(wallColor[1], wallColor[2], wallColor[3]))
				love.graphics.rectangle("fill", x * gridSize + padding, y * gridSize + padding, gridSize - padding * 2, gridSize - padding * 2)
			end
		end
	end
end

function love.keypressed(key)
	if key == "up" then
		if canMove(0, -1) then
			player.destinationY = player.destinationY - gridSize
		end

	elseif key == "down" then
		if canMove(0, 1) then
			player.destinationY = player.destinationY + gridSize
		end

	elseif key == "left" then
		if canMove(-1, 0) then
			player.destinationX = player.destinationX - gridSize
		end

	elseif key == "right" then
		if canMove(1, 0) then
			player.destinationX = player.destinationX + gridSize
		end
	end
end

function canMove(x, y)
  local destinationTile = map[(player.destinationY / gridSize) + y][(player.destinationX / gridSize) + x]

  if destinationTile == 1 or destinationTile == nil then
		return false
	end

  return true
end
