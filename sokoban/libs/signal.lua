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
  for index, instance in pairs(state) do
    if instance.group == group then
      state[index] = nil
    end
  end
end

signal.send = function(name, ...)
  for _, instance in pairs(state) do
    if instance.name == name or instance.name == '' then
      instance.callback(...)
    end
  end
end

signal.reset = function()
  state = {}
end

return signal
