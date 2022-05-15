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

  local padding = 15
  love.graphics.setColor(love.math.colorFromBytes(playerColor[1], playerColor[2], playerColor[3]))
	love.graphics.rectangle("fill", player.renderedX + padding, player.renderedY + padding, gridSize - padding * 2, gridSize - padding * 2)

	for y=1, #map do
		for x=1, #map[y] do
			if map[y][x] == 1 then
        local padding = 1
        love.graphics.setColor(love.math.colorFromBytes(gridColor[1], gridColor[2], gridColor[3]))
				love.graphics.rectangle("fill", (x - 1) * gridSize + padding, (y - 1) * gridSize + padding, gridSize - padding * 2, gridSize - padding * 2)
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
  local destinationTile = map[(player.destinationY / gridSize) + y + 1][(player.destinationX / gridSize) + x + 1]

  if destinationTile == 1 or destinationTile == nil then
		return false
	end

  return true
end
