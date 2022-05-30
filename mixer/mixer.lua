local mixer = {}
local mixerState = {}

function mixer.load(name, filename, type, shouldLoop)
  mixerState[name] = love.audio.newSource(filename, type)
  mixerState[name]:setLooping(shouldLoop or false)
end

function mixer.play(name)
  mixerState[name]:play()
end

function mixer.stop(name)
  mixerState[name]:stop()
end

return mixer
