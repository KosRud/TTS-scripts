RebuildUi = function()
    local buildUi = require("ui/init")
    local updateUiVars = require("music-manager/ui/util/updateUiVars")

    updateUiVars()
    buildUi({
        configUiParams = TransientState.uiVars.CONFIG_UI_PARAMS,
        getIsFlipped = function() return State.isFlipped end,
        style = require("music-manager/ui/util/getStyle"),
        makeUiMain = require("music-manager/ui/uiMain"),
        object = self
    })
end
State = require("music-manager/defaultState")
---@type TransientState
TransientState = {}

function onLoad(savedState)
    if savedState and savedState ~= "" then State = JSON.decode(savedState) end
    RebuildUi()
    return JSON.encode(State)
end

function onSave() return JSON.encode(State) end

function onRotate(...)
    local onRotate = require("ui/hooks/onRotate")

    onRotate(function(isFlipped) State.isFlipped = isFlipped end, {...})

    RebuildUi()
end
