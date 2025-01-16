local config = require("durobai/config")
local state = require("durobai/state")
local util = require("durobai/util")
local promote = require("durobai/promote")

local function onObjectCollisionEnter(args)
    local attackerDie, collision_info = args[1], args[2]
    local defenderDie = collision_info.collision_object

    if not util.isDie(attackerDie) then return end

    attackerDie.unregisterCollisions()
    for _, board in ipairs(util.getBoards(config.tags)) do
        board.call("HideLines")
    end

    if not util.isDie(defenderDie) then
        util.snapDieToGrid(attackerDie, state.activePlayer, true)
        return
    end

    local attackRoll = util.roll(attackerDie, true)
    local defenseRoll = util.roll(defenderDie, false)
    state.hasAttacked = true

    local success = attackRoll > defenseRoll
    local winnerDie = success and attackerDie or defenderDie

    if success then
        defenderDie.destruct()
    else
        attackerDie.destruct()
    end

    local attackerSize = util.getNumSides(attackerDie)
    local defenderSize = util.getNumSides(defenderDie)

    local promotionSize = config.promotions[defenderSize]
    if success and defenderSize >= attackerSize and promotionSize and
        promotionSize > attackerSize then
        broadcastToAll(string.format("promoted to d%d", promotionSize),
                       {r = 0.8, g = 0.8, b = 0.3})
        promote(winnerDie, promotionSize, function(promotedDie)
            util.snapDieToGrid(promotedDie, state.activePlayer, success)
        end)
    end

    if success then
        broadcastToAll("success", {r = 0.4, g = 0.7, b = 0.4})
    else
        broadcastToAll("failure", {r = 1, g = 0.5, b = 0.5})
    end
end

return onObjectCollisionEnter
