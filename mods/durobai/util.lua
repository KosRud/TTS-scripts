local config = require("durobai/config")
local state = require("durobai/state")

local util = {}

local function snapRotation(rotation) return
    math.floor(rotation / 90 + 0.5) * 90 end

function util.getBoards(tags) return getObjectsWithTag(tags.board) end

function util.getNumSides(dieObj) return #dieObj.getRotationValues() end

---@param toActivePlayer boolean
function util.snap(dieObj, activePlayer, toActivePlayer)
    dieObj.setRotation(dieObj.getRotationValues()[util.getNumSides(dieObj)]
                           .rotation)
    dieObj.rotate({
        x = 0,
        y = snapRotation(activePlayer.getPointerRotation()) +
            (toActivePlayer and 180 or 0),
        z = 0
    })
end

function util.roll(dieObj, isAttack)
    local numSidesOrig = util.getNumSides(dieObj)
    local defenseOverride = config.defenseOverride[numSidesOrig]
    local numSides = not isAttack and defenseOverride or numSidesOrig

    local result = math.floor(math.random() * numSides) + 1
    local mod = not state.hasAttacked and isAttack and config.attackBonus or 0
    local resultWithMod = result + mod
    print(string.format("%s: (d%d%s) %d%s", isAttack and "attack" or "defense",
                        numSidesOrig, defenseOverride and
                            string.format(" -> d%d", defenseOverride) or "",
                        result,
                        mod ~= 0 and
                            string.format("+ %d = %d", config.attackBonus,
                                          resultWithMod) or ""))
    return resultWithMod
end

function util.isDie(obj)
    return config.tags.dice:some(function(tag) return obj.hasTag(tag) end)
end

return util