local audio = {}
local audioState = {}

function audio.load(name, filename, type, shouldLoop)
  audioState[name] = love.audio.newSource(filename, type)
  audioState[name]:setLooping(shouldLoop or false)
end

function audio.play(name)
  audioState[name]:play()
end

function audio.stop(name)
  audioState[name]:stop()
end

return audio
