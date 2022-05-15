utils = {}

function utils.getLength(table)
  local value = 0

  for _ in pairs(table) do
    value = value + 1
  end

  return value
end

utils.arrowKeys = {
  ['up'] = { 0, -1 },
  ['down'] = { 0, 1 },
  ['left'] = { -1, 0 },
  ['right'] = { 1, 0 }
}
