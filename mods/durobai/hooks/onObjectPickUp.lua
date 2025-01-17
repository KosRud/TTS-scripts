local Array = require("js-like/Array")
local config = require("durobai/config")
local state = require("durobai/state")
local util = require("durobai/util")

local function onObjectPickUp(args)
    local player_color, object = args[1], args[2]

    if not util.isDie(object) then return end
    object.registerCollisions()
    state.pickPositions[object] = object.getPosition()
    state.dieThatMadeHpAttack = nil

    local players = Array:new(Player.getPlayers())

    state.activePlayer = players:find(function(player)
        return player.color == player_color
    end)

    local dieTag = util.getDieTag(object)
    if state.activeDieTag ~= dieTag then
        state.activeDieTag = dieTag
        state.hasAttacked = false
    end

    util.getBoard().call("ShowLines", object)

end

return onObjectPickUp
