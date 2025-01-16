local config = require("durobai/config")

local function vectorToWorld(obj, localVector)
    local worldPos = obj.positionToWorld(localVector)
    local myPos = obj.getPosition()
    local worldVec = {
        x = worldPos.x - myPos.x,
        y = worldPos.y - myPos.y,
        z = worldPos.z - myPos.z
    }
    return worldVec
end

local function castRay(board, diePosition, direction)
    local origin = diePosition
    local bounds = board.getBounds()
    origin.y = bounds.center.y + bounds.size.y + 0.01

    return Physics.cast({
        origin = diePosition,
        direction = vectorToWorld(board, config.rayDirections[direction]),
        type = 1
    })[1]
end

return castRay
