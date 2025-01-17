local config = require("durobai/config")
local state = require("durobai/state")
local util = require("durobai/util")
local promote = require("durobai/promote")

local function onObjectCollisionEnter(args)
    local attackerDie, collision_info = args[1], args[2]
    local defenderDie = collision_info.collision_object
    local board = util.getBoard()

    if not util.isDie(attackerDie) then return end

    attackerDie.unregisterCollisions()
    board.call("HideLines")

    if not util.isDie(defenderDie) then

        -- workaround for getting several collision instances in rapid succession instead of one when the die falls
        if state.dieThatMadeHpAttack == attackerDie then return end
        state.dieThatMadeHpAttack = attackerDie

        local positionOnBoard = util.getPositionOnBoard(attackerDie, board)

        if util.isPositionOutsideBoard(positionOnBoard) then
            util.rollAttackHp(attackerDie)
            attackerDie.setPosition(state.pickPositions[attackerDie])
            state.pickPositions[attackerDie] = nil
        end

        util.snapDieToGrid(attackerDie, state.activePlayer, true)
        return
    end

    local attackRoll = util.rollAttack(attackerDie)
    local defenseRoll = util.rollDefense(defenderDie)
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

    local promotionSize = config.rules.promotions[defenderSize]
    if success and defenderSize >= attackerSize and promotionSize and
        promotionSize > attackerSize then
        broadcastToAll(string.format("promoted to d%d", promotionSize),
                       config.ui.color.yellow)
        promote(winnerDie, promotionSize, function(promotedDie)
            util.snapDieToGrid(promotedDie, state.activePlayer, success)
        end)
    end

    if success then
        broadcastToAll("success", config.ui.color.green)
    else
        broadcastToAll("failure", config.ui.color.red)
    end
end

return onObjectCollisionEnter
