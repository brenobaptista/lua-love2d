# Audio

> An audio library wrapper for LÖVE

## Loading audio

```lua
audio.load('blip', 'audio/blip-sound.wav', 'static')
audio.load('music', 'audio/game-music.mp3', 'stream', true)
```

## Playing audio

```lua
audio.play('music')
```

## Stopping audio

```lua
audio.stop('music')
```
