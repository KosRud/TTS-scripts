local config = require("durobai/config")
local utilSnap = require("durobai/utilSnap")

local utilBoard = {}

local function clampCoordOnBoard(coord) return math.min(8, math.max(1, coord)) end

function utilBoard.getBoard() return getObjectsWithTag(config.tags.board)[1] end

function utilBoard.getPositionOnBoard(dieObj, board)
    local diePosition = utilSnap.getSnappedPosition(dieObj)
    local dieOffset = board.positionToLocal(diePosition)
    local boardScale = board.getScale()
    local dieOffsetUnscaled = {
        x = dieOffset.x * boardScale.x,
        z = dieOffset.z * boardScale.z
    }
    local diePosOnBoard = {
        x = math.floor(dieOffsetUnscaled.x / Grid.sizeX + 5),
        y = math.floor(dieOffsetUnscaled.z / Grid.sizeY + 5)
    }
    return diePosOnBoard
end

function utilBoard.isPositionOutsideBoard(positionOnBoard)
    return positionOnBoard.x < 1 or positionOnBoard.x > 8 or positionOnBoard.y <
               1 or positionOnBoard.y > 8
end

return utilBoard

------------ unused ------------

-- local function clampPositionOnboard(positionOnBoard)
--     return {
--         x = clampCoordOnBoard(positionOnBoard.x),
--         y = clampCoordOnBoard(positionOnBoard.y)
--     }
-- end

-- function utilBoard.positionOnBoardToWorld(diePosOnBoard, board)
--     local dieOffsetUnscaled = {
--         x = (diePosOnBoard.x - 4.5) * Grid.sizeX,
--         z = (diePosOnBoard.y - 4.5) * Grid.sizeX
--     }
--     local boardScale = board.getScale()
--     local dieOffset = {
--         x = dieOffsetUnscaled.x / boardScale.x,
--         z = dieOffsetUnscaled.z / boardScale.z,
--         y = 0
--     }
--     local diePosition = board.positionToWorld(dieOffset)
--     local bounds = board.getBounds()
--     diePosition.y = bounds.center.y + bounds.size.y + 0.01

--     return diePosition
-- end

-- function utilBoard.clampDieToBoard(dieObj, board)
--     local positionOnBoard = utilBoard.getPositionOnBoard(dieObj, board)
--     local clampedPositionOnboard = clampPositionOnboard(positionOnBoard)
--     local newPosition = utilBoard.positionOnBoardToWorld(clampedPositionOnboard,
--                                                          board)

--     dieObj.setPosition(newPosition)
-- end
