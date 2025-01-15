local state = require("ui/state")

local function onRotate(args)
    local spin, flip, player_color, old_spin, old_flip = args[1], args[2],
                                                         args[3], args[4],
                                                         args[5]

    if math.abs(flip - old_flip) < 10 then return end
    state.isFlipped = math.abs(flip - 180) < 90
end

return onRotate
