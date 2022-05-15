utils = {}

function utils.getLength(table)
  local value = 0

  for _ in pairs(table) do
    value = value + 1
  end

  return value
end
