require("utils")

-- 0 means floor
-- 1 means wall

world = {}
world.tileSize = 64
world.visualGrid = {
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
world.mapDimensions = {
  ["x"] = getLength(world.visualGrid[1]),
  ["y"] = getLength(world.visualGrid)
}
world.colors = {
  ["floor"] = { 40, 42, 54 },
  ["wall"] = { 68, 71, 90 }
}

function getTile(x, y)
  return world.visualGrid[y][x]
end
