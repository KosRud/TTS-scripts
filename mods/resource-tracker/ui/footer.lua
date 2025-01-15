local Array = require("js-like/Array")

local function makeFooter()
    local uiVars = TransientState.uiVars

    return State.isOpen and Array:new({
        {
            tag = "HorizontalLayout",
            attributes = {
                childForceExpandWidth = false,
                childForceExpandHeight = false,
                childAlignment = "MiddleRight",
                padding = string.format("%s %s %s %s", 0, 0,
                                        uiVars.FOOTER_PADDING,
                                        uiVars.FOOTER_PADDING)
            },
            children = {
                {
                    tag = "Button",
                    attributes = {
                        preferredHeight = uiVars.ROW_HEIGHT,
                        preferredWidth = 144 * uiVars.QUALITY,
                        text = "Reset",
                        fontSize = 24 * uiVars.QUALITY,
                        onClick = "onButtonClickReset"
                    }
                }, {
                    tag = "HorizontalLayout", -- padding
                    attributes = {
                        childForceExpandWidth = false,
                        childForceExpandHeight = false,
                        childAlignment = "MiddleLeft",
                        preferredWidth = uiVars.SPACING
                    }
                }
            }
        }
    }) or Array:new()
end

function onButtonClickReset()
    for k, v in pairs(State.config.resources) do v.current = v.max end
    RebuildUi()
end

return makeFooter
