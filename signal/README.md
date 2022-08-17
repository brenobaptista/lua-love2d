# Signal

> Signal module for LÖVE

## Testing

Change directory into the `spec` folder:

```sh
cd signal/spec
```

Run the tests:

```sh
lua signal_spec.lua
```

## Documentation

### Sending a signal

```lua
local monster = { isAlive = true }

signal.connect('monsterKilled', function()
  monster.isAlive = false
end)

signal.send('monsterKilled')
print(monster.isAlive) -- false
```

### Connecting multiple callbacks to the same signal

```lua
local monster = { isAlive = true }
local score = 0

signal.connect('monsterKilled', function()
  monster.isAlive = false
end)
signal.connect('monsterKilled', function()
  score = score + 10
end)

signal.send('monsterKilled')
print(monster.isAlive) -- false
print(score) -- 10
```

### Passing parameters while sending a signal

```lua
local logKills = ''
signal.connect('monsterKilled', function(sender)
  logKills = logKills .. sender.name .. ' has been killed!'
end)

local monster = { name = 'monster1' }
signal.send('monsterKilled', monster)
print(logKills) -- 'monster1 has been killed!'
```

### Triggering callbacks for every signal

```lua
local score = 0

signal.connect('monsterKilled', function()
  score = score + 10
end)

signal.connect('', function()
  -- will be called every time a signal is sent
  score = score + 10
end)

signal.send('monsterKilled')
print(score) -- 20
```

### Disconnecting a signal

```lua
local monster = { isAlive = true }

local signalIndex = signal.connect('monsterKilled', function()
  monster.isAlive = false
end)

signal.disconnect(signalIndex)
signal.send('monsterKilled')
print(monster.isAlive) -- true
```

### Disconnecting a group of signals

```lua
local score = 0

signal.connect('monsterKilled', function()
  score = score + 10
end, 'group1')
signal.connect('monsterKilled', function()
  score = score + 11
end, 'group1')
signal.connect('monsterKilled', function()
  score = score + 12
end, 'group2')

signal.disconnectGroup('group1')
signal.send('monsterKilled')
print(score) -- 12
```
