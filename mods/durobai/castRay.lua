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

local rayDirections = {
    {x = 1, y = 0, z = 0}, {x = 1, y = 0, z = 1}, {x = 0, y = 0, z = 1},
    {x = -1, y = 0, z = 1}, {x = -1, y = 0, z = 0}, {x = -1, y = 0, z = -1},
    {x = 0, y = 0, z = -1}, {x = 1, y = 0, z = -1}
}

local function castRay(board, diePosition, direction)
    local origin = diePosition
    local bounds = board.getBounds()
    origin.y = bounds.center.y + bounds.size.y + 0.01

    return Physics.cast({
        origin = diePosition,
        direction = vectorToWorld(board, rayDirections[direction + 1]),
        type = 1,
        debug = true
    })[1]
end

return castRay
