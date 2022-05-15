function love.load()
  backgroundColor = { 40, 42, 54 }
  playerColor = { 189, 147, 249 }
  gridColor = { 68, 71, 90 }
  gridSize = 64
	player = {
    renderedX = gridSize * 2,
    renderedY = gridSize * 2,
		destinationX = gridSize * 2,
		destinationY = gridSize * 2,
		transitionSpeed = 25
	}
	map = {
		{ 0, 0, 1, 1, 1, 1, 1, 0 },
		{ 1, 1, 1, 0, 0, 0, 1, 0 },
		{ 1, 0, 0, 0, 0, 0, 1, 0 },
		{ 1, 1, 1, 0, 0, 0, 1, 0 },
		{ 1, 0, 1, 1, 0, 0, 1, 0 },
		{ 1, 0, 1, 0, 0, 0, 1, 1 },
		{ 1, 0, 0, 0, 0, 0, 0, 1 },
		{ 1, 0, 0, 0, 0, 0, 0, 1 },
		{ 1, 1, 1, 1, 1, 1, 1, 1 }
	}
end

function love.update(dt)
	player.renderedY = player.renderedY - ((player.renderedY - player.destinationY) * player.transitionSpeed * dt)
	player.renderedX = player.renderedX - ((player.renderedX - player.destinationX) * player.transitionSpeed * dt)
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(backgroundColor[1], backgroundColor[2], backgroundColor[3]))

  love.graphics.setColor(love.math.colorFromBytes(playerColor[1], playerColor[2], playerColor[3]))
	love.graphics.rectangle("fill", player.renderedX, player.renderedY, gridSize, gridSize)

	for y=1, #map do
		for x=1, #map[y] do
			if map[y][x] == 1 then
        love.graphics.setColor(love.math.colorFromBytes(gridColor[1], gridColor[2], gridColor[3]))
				love.graphics.rectangle("fill", (x - 1) * gridSize, (y - 1) * gridSize, gridSize, gridSize)
			end
		end
	end
end

function love.keypressed(key)
	if key == "up" then
		if checkMapCollision(0, -1) then
			player.destinationY = player.destinationY - gridSize
		end

	elseif key == "down" then
		if checkMapCollision(0, 1) then
			player.destinationY = player.destinationY + gridSize
		end

	elseif key == "left" then
		if checkMapCollision(-1, 0) then
			player.destinationX = player.destinationX - gridSize
		end

	elseif key == "right" then
		if checkMapCollision(1, 0) then
			player.destinationX = player.destinationX + gridSize
		end
	end
end

function checkMapCollision(x, y)
  local wouldDestinationCollide = map[(player.destinationY / gridSize) + y + 1][(player.destinationX / gridSize) + x + 1]

	if wouldDestinationCollide == 1 or wouldDestinationCollide == nil then
		return false
	end

	return true
end
