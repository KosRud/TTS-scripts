local Array = require("js-like/Array")
local config = require("durobai/config")
local state = require("durobai/state")
local util = require("durobai/util")

local function onObjectPickUp(args)
    local player_color, object = args[1], args[2]

    if not util.isDie(object) then return end
    object.registerCollisions()

    local players = Array:new(Player.getPlayers())

    state.activePlayer = players:find(function(player)
        return player.color == player_color
    end)

    local dieTag = config.tags.dice:find(function(tag)
        return object.hasTag(tag)
    end)
    if state.activeDieTag ~= dieTag then
        state.activeDieTag = dieTag
        state.hasAttacked = false
    end

    for _, board in ipairs(util.getBoards(config.tags)) do
        board.call("ShowLines")
    end

end

return onObjectPickUp
