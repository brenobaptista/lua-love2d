local signals = {}
local signalsState = {}

signals.connect = function(name, callback, group)
  local index = #signalsState + 1
  signalsState[index] = {}
  signalsState[index].callback = callback
  signalsState[index].name = name or ''
  signalsState[index].group = group

  return index
end

signals.disconnect = function(index)
  signalsState[index] = nil
end

signals.disconnectGroup = function(group)
  for _, signal in pairs(signalsState) do
    if signal.group == group then
      signal = nil
    end
  end
end

signals.send = function(name, ...)
  for _, signal in pairs(signalsState) do
    if signal.name == name or signal.name == '' then
      signal.callback(...)
    end
  end
end

signals.reset = function()
  signalsState = {}
end

return signals
