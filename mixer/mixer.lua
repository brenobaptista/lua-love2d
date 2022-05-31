local mixer = {}
local musicState = {}
local soundState = {}
local mutedSounds = {}
local volumes = {
  master = 1,
  music = 1,
  sound = 1
}

function mixer.setVolume(type, volume)
  local oldVolume = volumes[type]
  volumes[type] = volume

  for name, music in pairs(musicState) do
    local currentVolume = music:getVolume()
    musicState[name]:setVolume(currentVolume * volume / oldVolume)
  end

  for name, sound in pairs(soundState) do
    local currentVolume = sound:getVolume()
    soundState[name]:setVolume(currentVolume * volume / oldVolume)
  end

  for name, mutedSound in pairs(mutedSounds) do
    local currentVolume = mutedSound:getVolume()
    mutedSounds[name]:setVolume(currentVolume * volume / oldVolume)
  end
end

function mixer.loadMusic(name, filename, loop, volume)
  musicState[name] = love.audio.newSource(filename, 'stream')
  musicState[name]:setLooping(loop or false)
  musicState[name]:setVolume(volumes.master * volumes.music * (volume or 1))
end

function mixer.playMusic(name)
  musicState[name]:play()
end

function mixer.pauseMusic(name)
  musicState[name]:pause()
end

function mixer.stopMusic(name)
  musicState[name]:stop()
end

function mixer.unloadMusic(name)
  musicState[name] = nil
end

function mixer.loadSound(name, filename, volume)
  soundState[name] = love.audio.newSource(filename, 'static')
  soundState[name]:setVolume(volumes.master * volumes.sound * (volume or 1))
end

function mixer.playSound(name)
  soundState[name]:play()
end

function mixer.muteSound(name)
  mutedSounds[name] = soundState[name]:getVolume()
  soundState[name]:setVolume(0)
end

function mixer.unmuteSound(name)
  soundState[name]:setVolume(mutedSounds[name])
  mutedSounds[name] = nil
end

function mixer.unloadSound(name)
  soundState[name] = nil
end

return mixer
