package.path = package.path .. ';../signals.lua;'
local signals = require('signals')

local lust = require('lust')
local describe, beforeEach, it, expect = lust.describe, lust.before, lust.it, lust.expect

describe('testing signals', function()
  beforeEach(function()
    signals.reset()
  end)

  it('can send a signal', function()
    local monster = { isAlive = true }

    signals.connect('monsterKilled', function()
      monster.isAlive = false
    end)

    signals.send('monsterKilled')
    expect(monster.isAlive).to.equal(false)
  end)

  it('can connect multiple callbacks to the same signal', function()
    local monster = { isAlive = true }
    local score = 0

    signals.connect('monsterKilled', function()
      monster.isAlive = false
    end)
    signals.connect('monsterKilled', function()
      score = score + 10
    end)

    signals.send('monsterKilled')
    expect(monster.isAlive).to.equal(false)
    expect(score).to.equal(10)
  end)

  it('can pass parameters while sending a signal', function()
    local logKills = ''
    signals.connect('monsterKilled', function(sender)
      logKills = logKills .. sender.name .. ' has been killed!'
    end)

    local monster = { name = 'monster1' }
    signals.send('monsterKilled', monster)
    expect(logKills).to.equal('monster1 has been killed!')
  end)

  it('can trigger callbacks for every signal', function()
    local score = 0

    signals.connect('monsterKilled', function()
      score = score + 10
    end)

    signals.connect('', function()
      -- will be called every time a signal is sent
      score = score + 10
    end)

    signals.send('monsterKilled')
    expect(score).to.equal(20)
  end)

  it('can disconnect a signal', function()
    local monster = { isAlive = true }

    local signalIndex = signals.connect('monsterKilled', function()
      monster.isAlive = false
    end)

    signals.disconnect(signalIndex)
    signals.send('monsterKilled')
    expect(monster.isAlive).to.equal(true)
  end)

  it('can disconnect a group of signals', function()
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
    expect(score).to.equal(12)
  end)
end)
