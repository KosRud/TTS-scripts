local Array = require("js-like/Array")
local config = require("durobai/config")
local state = require("durobai/state")

local function snapCoord(coord, gridOffset, gridSize)
    local offset = gridOffset - 0.5 * gridSize
    return math.floor((coord - offset) / gridSize + 0.5) * gridSize + offset
end

local util = {}

local function snapRotation(rotation) return
    math.floor(rotation / 90 + 0.5) * 90 end

function util.getBoards(tags) return getObjectsWithTag(tags.board) end

util.castRay = require("durobai/castRay")

function util.getMoveRange(dieObj)
    local size = util.getNumSides(dieObj)
    return config.moveRangeOverride[size] or size / 2
end

function util.getNumSides(dieObj) return #dieObj.getRotationValues() end

---@param faceActivePlayer boolean
function util.snapDieToGrid(dieObj, activePlayer, faceActivePlayer)
    dieObj.setRotation(dieObj.getRotationValues()[util.getNumSides(dieObj)]
                           .rotation)
    dieObj.rotate({
        x = 0,
        y = snapRotation(activePlayer.getPointerRotation()) +
            (faceActivePlayer and 180 or 0),
        z = 0
    })

    dieObj.setVelocity({x = 0, y = 0, z = 0})
    dieObj.setAngularVelocity({x = 0, y = 0, z = 0})

    local diePosition = dieObj.getPosition()
    diePosition.x = snapCoord(diePosition.x, Grid.offsetX, Grid.sizeX)
    diePosition.z = snapCoord(diePosition.z, Grid.offsetY, Grid.sizeY)
    dieObj.setPosition(diePosition)
end

function util.getSnappedPosition(obj)
    local position = obj.getPosition()
    position.x = snapCoord(position.x, Grid.offsetX, Grid.sizeX)
    position.z = snapCoord(position.z, Grid.offsetY, Grid.sizeY)
    return position
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

function util.getDieTag(dieObj)
    return config.tags.dice:find(function(tag) return dieObj.hasTag(tag) end)
end

function util.isDie(obj)
    return config.tags.dice:some(function(tag) return obj.hasTag(tag) end)
end

return util
