local Array = require("lib-array/Array")

local function makeHeader()
	local uiVars = State.uiVars

	return Array:new({
		{
			tag = "HorizontalLayout",
			attributes = {
				preferredHeight = uiVars.ROW_HEIGHT + uiVars.HEADER_PADDING * 2,
				flexibleHeight = State.isOpen and 0 or 1,
				childForceExpandWidth = false,
				childForceExpandHeight = false,
				childAlignment = "MiddleRight",
				color = "rgb(0.4, 0.8, 0.4)",
				padding = string.format(
					"%s %s %s %s",
					uiVars.HEADER_PADDING,
					uiVars.HEADER_PADDING,
					uiVars.HEADER_PADDING,
					uiVars.HEADER_PADDING
				)
			},
			children = {
				{
					tag = "Text",
					attributes = {
						preferredHeight = uiVars.ROW_HEIGHT,
						flexibleWidth = 1,
						text = "Resource Tracker",
						fontSize = 24 * uiVars.QUALITY,
						fontStyle = "Bold",
						textColor = "black",
					},
				},
				{
					tag = "Button",
					attributes = {
						preferredHeight = uiVars.ROW_HEIGHT,
						preferredWidth = uiVars.ROW_HEIGHT,
						text = State.isOpen and "▼" or "▶",
						fontSize = 24 * uiVars.QUALITY,
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
	State.isOpen = not State.isOpen
	RebuildUi()
end

return makeHeader
