local Array = require("js-like/Array")

local config = {
    tags = {
        board = "durobai_board",
        dice = Array:new({"durobai_die_blue", "durobai_die_yellow"}),
        promotionsBag = "durobai_reference_dice"
    },
    promotions = {[6] = 8, [8] = 10, [10] = 12, [12] = 20, [20] = 20},
    defenseOverride = {[20] = 6},
    moveRangeOverride = {[6] = 2},
    attackBonus = 3,
    dieOffsetMult = 100,
    boardSize = 1360,
    rayColor = "rgba(0.4,1,0.4,0.2)",
    rayDirections = {
        {x = 1, y = 0, z = 0}, {x = 1, y = 0, z = 1}, {x = 0, y = 0, z = 1},
        {x = -1, y = 0, z = 1}, {x = -1, y = 0, z = 0}, {x = -1, y = 0, z = -1},
        {x = 0, y = 0, z = -1}, {x = 1, y = 0, z = -1}
    }
}

return config
