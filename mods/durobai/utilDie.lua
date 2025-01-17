local config = require("durobai/config")

local utilDie = {}

function utilDie.getNumSides(dieObj) return #dieObj.getRotationValues() end

function utilDie.getMoveRange(dieObj)
    local size = utilDie.getNumSides(dieObj)
    return config.rules.moveRangeOverride[size] or size / 2
end

return utilDie
