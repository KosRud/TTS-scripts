local Array = require("js-like/Array")

local config = {
    tags = {
        board = "durobai_board",
        dice = Array:new({"durobai_die_blue", "durobai_die_yellow"})
    },
    promotions = {[6] = 8, [8] = 10, [10] = 12, [12] = 20},
    defenseOverride = {[20] = 6},
    attackBonus = 3
}

return config
