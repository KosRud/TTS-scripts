local Array = require("js-like/Array")
local Object = require("js-like/Object")
local makeHeader = require("ui/header")
local makeFooter = require("ui/footer")
local makeResourceRow = require("ui/resourceRow")

local function makeUiMain()
    local uiVars = TransientState.uiVars

    local resources = Object.entries(State.config.resources)
    local rows = State.isOpen and resources:map(makeResourceRow) or Array:new()

    local uiHeight = math.max(uiVars.UI_HEIGHT_CLOSED,
                              ((uiVars.ROW_HEIGHT + uiVars.SPACING) *
                                  (#resources + 2) + uiVars.HEADER_PADDING * 2 +
                                  uiVars.FOOTER_PADDING * 2))

    local header = makeHeader()
    local footer = makeFooter()

    local rows = State.isOpen and resources:map(makeResourceRow) or Array:new()

    rows = header:concat(rows, footer)

    return ({
        {
            tag = "VerticalLayout",
            attributes = {
                height = State.isOpen and uiHeight or uiVars.UI_HEIGHT_CLOSED,
                width = uiVars.UI_WIDTH,
                rectAlignment = "UpperCenter",
                rotation = "0, 0, 0",
                position = string.format("%f %f %f", 0, 50, -100),
                scale = string.format("%f %f %f", 1 / uiVars.BASE_OBJ_SCALE.x /
                                          uiVars.QUALITY, 1 /
                                          uiVars.BASE_OBJ_SCALE.z /
                                          uiVars.QUALITY, 1 /
                                          uiVars.BASE_OBJ_SCALE.y /
                                          uiVars.QUALITY),
                childForceExpandWidth = true,
                childForceExpandHeight = false,
                childAlignment = "UpperLeft",
                spacing = uiVars.SPACING,
                color = "white"
            },
            children = rows
        }
    })
end

return makeUiMain
