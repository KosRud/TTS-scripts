local config = require("durobai/config")
local state = require("durobai/state")
local util = require("durobai/util")

local function onObjectCollisionEnter(args)
    local attackerDie, collision_info = args[1], args[2]

    local defenderDie = collision_info.collision_object

    if not util.isDie(attackerDie) then return end

    attackerDie.unregisterCollisions()
    for _, board in ipairs(util.getBoards(config.tags)) do
        board.call("HideLines")
    end

    if not util.isDie(defenderDie) then return end

    local attackRoll = util.roll(attackerDie, true)
    local defenseRoll = util.roll(defenderDie, false)
    state.hasAttacked = true

    local success = attackRoll > defenseRoll
    local winner = success and attackerDie or defenderDie

    if success then
        defenderDie.destruct()
    else
        attackerDie.destruct()
    end

    local attackerSize = util.getNumSides(attackerDie)
    local defenderSize = util.getNumSides(defenderDie)

    local promotion = config.promotions[defenderSize]
    if success and defenderSize >= attackerSize and promotion then
        broadcastToAll(string.format("promoted to: d%d", promotion),
                       {r = 0.9, g = 0.9, b = 0.4})
    end

    if success then
        broadcastToAll("success", {r = 0.4, g = 0.7, b = 0.4})
    else
        broadcastToAll("failure", {r = 1, g = 0.5, b = 0.5})
    end

    util.snap(winner, state.activePlayer, success)

    attackerDie.unregisterCollisions()
end

return onObjectCollisionEnter
