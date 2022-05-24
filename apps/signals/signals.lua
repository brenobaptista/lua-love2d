local signals = {}
local s = {}

signals.connect = function(signalName, callback, groupName)
  local id = #s + 1
  s[id] = {}
  s[id].callback = callback
  s[id].signalName = signalName or ''
  s[id].groupName = groupName

  return id
end

signals.disconnect = function(id)
  s[id] = nil
end

signals.disconnectGroup = function(groupName)
  for i, v in pairs(s) do
    if s[i].groupName == groupName then
      s[i] = nil
    end
  end
end

signals.send = function(signalName, ...)
  for i, v in pairs(s) do
    if s[i].signalName == signalName or s[i].signalName == '' then
      s[i].callback(...)
    end
  end
end

signals.reset = function()
  s = {}
end

return signals
