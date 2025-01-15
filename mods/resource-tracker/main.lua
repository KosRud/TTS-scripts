RebuildUi = function()
    require("lib-ui")({
        getStyle = require("mod-music-manager/util/style"),
        makeUiMain = require("mod-music-manager/ui/uiMain"),
        object = self,
        updateUiVars = require("mod-music-manager/ui/util/updateUiVars")
    })
end
State = require("mod-resource-tracker/defaultState")
---@type TransientState
TransientState = {}

function onLoad(savedState)
    if savedState and savedState ~= "" then State = JSON.decode(savedState) end
    RebuildUi()
    return JSON.encode(State)
end

function onSave() return JSON.encode(State) end

function onRotate(...)
    local onRotate = require("lib-ui.hooks.onRotate")

    onRotate(function(isFlipped) State.isFlipped = isFlipped end, {...})
end
