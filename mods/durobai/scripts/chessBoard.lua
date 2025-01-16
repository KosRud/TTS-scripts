local util = require("durobai/util")

local dieOffsetMult = 100
local boardSize = 1360
local rayColor = "rgba(0.5, 0.1, 0.1, 0.2)"

local function guideRay(dieOffset, range, direction)
    return {
        tag = "Panel",
        attributes = {
            height = 12,
            width = range * (direction % 2 == 0 and 1 or math.sqrt(2)),
            color = rayColor,
            position = string.format("%f %f %f", dieOffset.x * dieOffsetMult,
                                     dieOffset.z * dieOffsetMult, 0),
            pivot = "0 0.5 0.5",
            rotation = string.format("%s %s %s", 0, 0, direction * 45)
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
    local range = boardSize / 8 * util.getMoveRange(dieObj)

    self.UI.setXmlTable({
        {
            tag = "Panel",
            attributes = {height = boardSize, width = boardSize},
            children = {
                guideRay(dieOffset, range, 0), guideRay(dieOffset, range, 1),
                guideRay(dieOffset, range, 2), guideRay(dieOffset, range, 3),
                guideRay(dieOffset, range, 4), guideRay(dieOffset, range, 5),
                guideRay(dieOffset, range, 6), guideRay(dieOffset, range, 7),
                guideRay(dieOffset, range, 8)
            }
        }
    })

end

function ShowLines(dieObj) rebuildUi(dieObj) end

function HideLines() rebuildUi() end
