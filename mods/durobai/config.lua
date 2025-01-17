local Array = require("js-like/Array")

local config = {
    players = Array:new({
        {name = "Blue", color = {r = 0.5, g = 0.5, b = 1}},
        {name = "Yellow", color = {r = 1, g = 1, b = 0.4}}
    }),
    tags = {
        board = "durobai_board",
        dice = Array:new({"durobai_die_blue", "durobai_die_yellow"}),
        promotionsBag = "durobai_reference_dice",
        hp = Array:new({"durobai_hp_blue", "durobai_hp_yellow"})
    },
    rules = {
        promotions = {[6] = 8, [8] = 10, [10] = 12, [12] = 20, [20] = 20},
        defenseOverride = {[20] = 6},
        moveRangeOverride = {[6] = 2},
        attackBonus = 3,
    },
    objects = {
        dieOffsetMult = 100,
        boardSize = 1360,
    },
    ui = {
        rayColor = "rgba(0.4, 1, 0.4, 0.2)",
        rayDirections = Array:new({
            {x = 1, y = 0, z = 0}, {x = 1, y = 0, z = 1}, {x = 0, y = 0, z = 1},
            {x = -1, y = 0, z = 1}, {x = -1, y = 0, z = 0}, {x = -1, y = 0, z = -1},
            {x = 0, y = 0, z = -1}, {x = 1, y = 0, z = -1}
        }),
        color = {
            red = {r = 1, g = 0.5, b = 0.5},
            green = {r = 0.4, g = 0.7, b = 0.4},
            yellow = {r = 0.8, g = 0.8, b = 0.3}
        }
    },
}

return config
