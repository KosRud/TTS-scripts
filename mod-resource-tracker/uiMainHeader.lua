local Array = require("lib-array/Array")
local uiConstants = require("mod-resource-tracker/uiConstants")

local function makeHeader()
	return Array:new({
		{
			tag = "HorizontalLayout",
			attributes = {
				preferredHeight = uiConstants.ROW_HEIGHT + uiConstants.HEADER_PADDING * 2,
				flexibleHeight = state.isOpen and 0 or 1,
				childForceExpandWidth = false,
				childForceExpandHeight = false,
				childAlignment = "MiddleRight",
				color = "rgb(0.4, 0.8, 0.4)",
				padding = string.format(
					"%s %s %s %s",
					uiConstants.HEADER_PADDING,
					uiConstants.HEADER_PADDING,
					uiConstants.HEADER_PADDING,
					uiConstants.HEADER_PADDING
				)
			},
			children = {
				{
					tag = "Text",
					attributes = {
						preferredHeight = uiConstants.ROW_HEIGHT,
						flexibleWidth = 1,
						text = "Resource Tracker",
						fontSize = 24 * uiConstants.UI_QUALITY,
						fontStyle = "Bold",
						textColor = "black",
					},
				},
				{
					tag = "Button",
					attributes = {
						preferredHeight = uiConstants.ROW_HEIGHT,
						preferredWidth = uiConstants.ROW_HEIGHT,
						text = state.isOpen and "▼" or "▶",
						fontSize = 24 * uiConstants.UI_QUALITY,
						textColor = "black",
						colors = "rgb(0.85,0.85,0.85)|rgb(0.95,0.95,0.95)|rgb(0.85,0.85,0.85)",
						onClick = "onButtonClickOpen(1)"
					},
				},

			}
		},
	})
end

function onButtonClickOpen()
	state.isOpen = not state.isOpen
	rebuildUi(state)
end

return makeHeader
