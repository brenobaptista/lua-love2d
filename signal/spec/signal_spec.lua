package.path = package.path .. ';../signal.lua;'
local signal = require('signal')

local lust = require('lust')
local describe, beforeEach, it, expect = lust.describe, lust.before, lust.it, lust.expect

describe('testing signals', function()
  beforeEach(function()
    signal.reset()
  end)

  it('can send a signal', function()
    local monster = { isAlive = true }

    signal.connect('monsterKilled', function()
      monster.isAlive = false
    end)

    signal.send('monsterKilled')
    expect(monster.isAlive).to.equal(false)
  end)

  it('can connect multiple callbacks to the same signal', function()
    local monster = { isAlive = true }
    local score = 0

    signal.connect('monsterKilled', function()
      monster.isAlive = false
    end)
    signal.connect('monsterKilled', function()
      score = score + 10
    end)

    signal.send('monsterKilled')
    expect(monster.isAlive).to.equal(false)
    expect(score).to.equal(10)
  end)

  it('can pass parameters while sending a signal', function()
    local logKills = ''
    signal.connect('monsterKilled', function(sender)
      logKills = logKills .. sender.name .. ' has been killed!'
    end)

    local monster = { name = 'monster1' }
    signal.send('monsterKilled', monster)
    expect(logKills).to.equal('monster1 has been killed!')
  end)

  it('can trigger callbacks for every signal', function()
    local score = 0

    signal.connect('monsterKilled', function()
      score = score + 10
    end)

    signal.connect('', function()
      -- will be called every time a signal is sent
      score = score + 10
    end)

    signal.send('monsterKilled')
    expect(score).to.equal(20)
  end)

  it('can disconnect a signal', function()
    local monster = { isAlive = true }

    local signalIndex = signal.connect('monsterKilled', function()
      monster.isAlive = false
    end)

    signal.disconnect(signalIndex)
    signal.send('monsterKilled')
    expect(monster.isAlive).to.equal(true)
  end)

  it('can disconnect a group of signals', function()
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
    expect(score).to.equal(12)
  end)
end)
