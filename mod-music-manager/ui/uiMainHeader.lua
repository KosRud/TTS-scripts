local Array = require("lib-array/Array")

local function makeHeader()
	local uiVars = State.uiVars

	return {
		tag = "HorizontalLayout",
		attributes = {
			preferredHeight = 36 * uiVars.QUALITY + uiVars.HEADER_PADDING * 2,
			flexibleHeight = State.isOpen and 0 or 1,
			childForceExpandWidth = false,
			childForceExpandHeight = false,
			childAlignment = "MiddleCenter",
			color = "rgb(0.9, 0.9, 0.4)",
		},
		children = {
			{
				tag = "Text",
				attributes = {
					flexibleWidth = 1,
					text = "Music Manager",
					fontSize = 24 * uiVars.QUALITY,
					fontStyle = "Bold",
				},
			}
		}
	}
end

return makeHeader
