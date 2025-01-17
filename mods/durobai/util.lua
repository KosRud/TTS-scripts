local Array = require("js-like/Array")
local config = require("durobai/config")
local state = require("durobai/state")
local utilBoard = require("durobai/utilBoard")
local utilSnap = require("durobai/utilSnap")
local utilDie = require("durobai/utilDie")

local util = {}

util.clampDieToBoard = utilBoard.clampDieToBoard
util.getBoard = utilBoard.getBoard
util.isPositionOutsideBoard = utilBoard.isPositionOutsideBoard
util.getPositionOnBoard = utilBoard.getPositionOnBoard
util.castRay = require("durobai/castRay")
util.getSnappedPosition = utilSnap.getSnappedPosition
util.snapDieToGrid = utilSnap.snapDieToGrid
util.getNumSides = utilDie.getNumSides
util.getMoveRange = utilDie.getMoveRange

local function damageOpponent(dieObj, damage)
    local hpTag = config.tags.hp:find(function(_, id)
        return not dieObj.hasTag(config.tags.dice[id])
    end)
    local hpCounter = getObjectsWithTag(hpTag)[1]
    local curHp = hpCounter.getValue()
    local newHp = math.max(0, curHp - damage)
    hpCounter.setValue(newHp)
    return {oldHp = curHp, newHp = newHp}
end

local function announceVictory(attackerDie)
    local player = config.players:find(function(_, id)
        return attackerDie.hasTag(config.tags.dice[id])
    end)
    broadcastToAll(string.format("%s wins!", player.name), player.color)
end

function util.rollAttack(attackerDie)
    local numSides = util.getNumSides(attackerDie)

    local result = math.floor(math.random() * numSides) + 1
    local mod = not state.hasAttacked and config.rules.attackBonus or 0
    local resultWithMod = result + mod
    printToAll(string.format("attack: (d%d) %d%s", numSides, result,
                             mod ~= 0 and
                                 string.format("+ %d = %d", config.rules.attackBonus,
                                               resultWithMod) or ""))
    return resultWithMod
end

function util.rollAttackHp(attackerDie)
    local numSides = util.getNumSides(attackerDie)
    local result = math.floor(math.random() * numSides) + 1
    printToAll(string.format("attack: (d%d) %d", numSides, result))

    local hpValues = damageOpponent(attackerDie, result)
    printToAll(string.format("hp reduction: %d => %d", hpValues.oldHp,
                             hpValues.newHp), config.ui.color.red)

    if hpValues.newHp <= 0 then announceVictory(attackerDie) end

    return result
end

function util.colorString(color)
    return string.format("%s %s %s", color.r, color.g, color.b)
end

function util.rollDefense(defenderDie)
    local numSidesOrig = util.getNumSides(defenderDie)
    local defenseOverride = config.rules.defenseOverride[numSidesOrig] or nil
    local numSides = defenseOverride or numSidesOrig

    local result = math.floor(math.random() * numSides) + 1
    printToAll(string.format("defense: (d%d%s) %d", numSidesOrig,
                             defenseOverride and
                                 string.format(" -> d%d", defenseOverride) or "",
                             result))
    return result
end

function util.getDieTag(dieObj)
    return config.tags.dice:find(function(tag) return dieObj.hasTag(tag) end)
end

function util.isDie(obj)
    return config.tags.dice:some(function(tag) return obj.hasTag(tag) end)
end

return util
