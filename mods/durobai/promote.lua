local Array = require("js-like/Array")
local config = require("durobai/config")
local util = require("durobai/util")

local function getPromotionBag()
    return getObjectsWithTag(config.tags.promotionsBag)[1]
end

local function getPromotion(dieTag, dieSize)
    local bag = getPromotionBag()
    local dice = Array:new(bag.getObjects())
    local isPlayerOne = dieTag == config.tags.dice[1]
    local promotionDie = dice:find(function(die)
        return die.name ==
                   string.format("D%d_%s", dieSize, isPlayerOne and "A" or "B")
    end)
    return promotionDie
end

function promote(dieObj, promotionDieSize, callback)
    local promotionDie = getPromotion(util.getDieTag(dieObj), promotionDieSize)
    local position = dieObj.getPosition()
    dieObj.destruct()
    local promotionBag = getPromotionBag()
    local obj = promotionBag.takeObject({
        index = promotionDie.index,
        position = position,
        callback_function = callback
    })
    promotionBag.putObject(obj.clone({position = position}))
    return obj
end

return promote
