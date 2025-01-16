local Array = require("js-like/Array")
local util = require("durobai/util")
local config = require("durobai/config")

local function getCoordBoardLimit(vectorCoord, diePosOnBoard)
    if vectorCoord > 0 then return 8 - diePosOnBoard end
    if vectorCoord < 0 then return diePosOnBoard - 1 end
    return 9999
end

local function getBoardRangeLimit(diePosOnBoard, direction)

    local vector = config.rayDirections[direction]

    return math.min(getCoordBoardLimit(vector.x, diePosOnBoard.x),
                    getCoordBoardLimit(vector.z, diePosOnBoard.y))
end

local function isPositionOnBoard(position)
    if position.x < 1 or position.x > 8 or position.y < 1 or position.y > 8 then
        return false
    end
    return true
end

local function guideRay(diePosition, dieOffset, diePosOnBoard, range, direction)
    local diagonalMultiplier = direction % 2 == 0 and math.sqrt(2) or 1

    local hit = util.castRay(self, diePosition, direction)
    if hit then
        range = math.min(range, hit.distance / diagonalMultiplier / Grid.sizeX)
    end

    range = math.min(range, getBoardRangeLimit(diePosOnBoard, direction))
    log(getBoardRangeLimit(diePosOnBoard, direction))

    range = range * config.boardSize / 8 * diagonalMultiplier

    return {
        tag = "Panel",
        attributes = {
            height = 12,
            width = range,
            color = config.rayColor,
            position = string.format("%f %f %f",
                                     dieOffset.x * config.dieOffsetMult,
                                     dieOffset.z * config.dieOffsetMult, 0),
            pivot = "0 0.5 0.5",
            rotation = string.format("%s %s %s", 0, 0, (direction - 1) * 45)
        }
    }

end

local function rebuildUi(dieObj)
    if not dieObj then
        self.UI.setXmlTable({{}})
        return
    end

    local diePosition = util.getSnappedPosition(dieObj)
    local dieOffset = self.positionToLocal(diePosition)
    local myScale = self.getScale()
    local dieOffsetUnscaled = {
        x = dieOffset.x * myScale.x,
        y = dieOffset.y * myScale.y,
        z = dieOffset.z * myScale.z
    }
    local diePosOnBoard = {
        x = math.floor(dieOffsetUnscaled.x / Grid.sizeX + 5),
        y = math.floor(dieOffsetUnscaled.z / Grid.sizeY + 5)
    }
    local range = util.getMoveRange(dieObj)

    local rays = Array:new({})
    if isPositionOnBoard(diePosOnBoard) then
        for i = 1, 8 do
            rays:push(guideRay(diePosition, dieOffset, diePosOnBoard, range, i))
        end
    end

    self.UI.setXmlTable({
        {
            tag = "Panel",
            attributes = {height = config.boardSize, width = config.boardSize},
            children = rays
        }
    })

end

function ShowLines(dieObj) rebuildUi(dieObj) end

function HideLines() rebuildUi() end
