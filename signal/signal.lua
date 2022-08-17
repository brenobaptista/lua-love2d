local signal = {}
local state = {}

signal.connect = function(name, callback, group)
  local index = #state + 1
  state[index] = {}
  state[index].callback = callback
  state[index].name = name or ''
  state[index].group = group

  return index
end

signal.disconnect = function(index)
  state[index] = nil
end

signal.disconnectGroup = function(group)
  for index, value in pairs(state) do
    if value.group == group then
      state[index] = nil
    end
  end
end

signal.send = function(name, ...)
  for _, value in pairs(state) do
    if value.name == name or value.name == '' then
      value.callback(...)
    end
  end
end

signal.reset = function()
  state = {}
end

return signal
