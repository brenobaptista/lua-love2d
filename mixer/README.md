# Mixer

> A wrapper for the audio module of LÖVE

This library is inspired by `pygame.mixer`, the pygame module for audio.

## Music

Music refers to long tracks of audio, like background music.

```lua
  mixer.loadMusic(name, filename, loop?, volume?)
  mixer.playMusic(name)
  mixer.pauseMusic(name)
  mixer.stopMusic(name)
  mixer.unloadMusic(name)
```

## Sound

Sound refers to short tracks of audio, like crash noises or beeps.

```lua
  mixer.loadSound(name, filename, volume?)
  mixer.playSound(name)
  mixer.muteSound(name)
  mixer.unmuteSound(name)
  mixer.unloadSound(name)
```

## Volume

There are three general types of volumes: `master`, `music` and `sound`.
The default value is 1 (100%), but it can be changed using the `setVolume` method.

```lua
  mixer.setVolume(type, volume)
```
