local utilDie = require("durobai/utilDie")

local utilSnap = {}

local function snapRotation(rotation) return
    math.floor(rotation / 90 + 0.5) * 90 end

local function snapCoord(coord, gridOffset, gridSize)
    local offset = gridOffset - 0.5 * gridSize
    return math.floor((coord - offset) / gridSize + 0.5) * gridSize + offset
end

function utilSnap.getSnappedPosition(obj)
    local position = obj.getPosition()
    position.x = snapCoord(position.x, Grid.offsetX, Grid.sizeX)
    position.z = snapCoord(position.z, Grid.offsetY, Grid.sizeY)
    return position
end

---@param faceActivePlayer boolean
function utilSnap.snapDieToGrid(dieObj, activePlayer, faceActivePlayer)
    dieObj.setRotation(dieObj.getRotationValues()[utilDie.getNumSides(dieObj)]
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

return utilSnap
