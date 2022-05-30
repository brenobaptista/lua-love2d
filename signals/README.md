# Signals

> Signals module for LÖVE

## Testing

Change directory into the `spec` folder:

```sh
cd signals/spec
```

Run the tests:

```sh
lua signals_spec.lua
```

## Documentation

### Sending a signal

```lua
local monster = { isAlive = true }

signals.connect('monsterKilled', function()
  monster.isAlive = false
end)

signals.send('monsterKilled')
print(monster.isAlive) -- false
```

### Connecting multiple callbacks to the same signal

```lua
local monster = { isAlive = true }
local score = 0

signals.connect('monsterKilled', function()
  monster.isAlive = false
end)
signals.connect('monsterKilled', function()
  score = score + 10
end)

signals.send('monsterKilled')
print(monster.isAlive) -- false
print(score) -- 10
```

### Passing parameters while sending a signal

```lua
local logKills = ''
signals.connect('monsterKilled', function(sender)
  logKills = logKills .. sender.name .. ' has been killed!'
end)

local monster = { name = 'monster1' }
signals.send('monsterKilled', monster)
print(logKills) -- 'monster1 has been killed!'
```

### Triggering callbacks for every signal

```lua
local score = 0

signals.connect('monsterKilled', function()
  score = score + 10
end)

signals.connect('', function()
  -- will be called every time a signal is sent
  score = score + 10
end)

signals.send('monsterKilled')
print(score) -- 20
```

### Disconnecting a signal

```lua
local monster = { isAlive = true }

local signalIndex = signals.connect('monsterKilled', function()
  monster.isAlive = false
end)

signals.disconnect(signalIndex)
signals.send('monsterKilled')
print(monster.isAlive) -- true
```

### Disconnecting a group of signals

```lua
local score = 0

signals.connect('monsterKilled', function()
  score = score + 10
end, 'group1')
signals.connect('monsterKilled', function()
  score = score + 11
end, 'group1')
signals.connect('monsterKilled', function()
  score = score + 12
end, 'group2')

signals.disconnectGroup('group1')
signals.send('monsterKilled')
print(score) -- 12
```
