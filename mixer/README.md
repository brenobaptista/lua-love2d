# Mixer

> A wrapper for the audio module of LÖVE

## Loading audio

```lua
mixer.load('blip', 'audio/blip-sound.wav', 'static')
mixer.load('music', 'audio/game-music.mp3', 'stream', true)
```

## Playing audio

```lua
mixer.play('music')
```

## Stopping audio

```lua
mixer.stop('music')
```
