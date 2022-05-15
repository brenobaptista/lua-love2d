gridSize = 64
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

lengthMapY = 0
lengthMapX = 0

for _ in pairs(map) do
  lengthMapY = lengthMapY + 1
end

for _ in pairs(map[1]) do
  lengthMapX = lengthMapX + 1
end
