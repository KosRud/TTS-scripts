local Array = require("lib-array/Array")
local uiConstants = require("mod-resource-tracker/ui/uiConstants")

local function makeFooter()
	return State.isOpen and Array:new({
		{
			tag = "HorizontalLayout",
			attributes = {
				childForceExpandWidth = false,
				childForceExpandHeight = false,
				childAlignment = "MiddleRight",
				padding = string.format(
					"%s %s %s %s",
					0,
					0,
					uiConstants.FOOTER_PADDING,
					uiConstants.FOOTER_PADDING
				)
			},
			children = {
				{
					tag = "Button",
					attributes = {
						preferredHeight = uiConstants.ROW_HEIGHT,
						preferredWidth = 144 * uiConstants.UI_QUALITY,
						text = "Reset",
						fontSize = 24 * uiConstants.UI_QUALITY,
						onClick = "onButtonClickReset"
					},
				},
				{
					tag = "HorizontalLayout", -- padding
					attributes = {
						childForceExpandWidth = false,
						childForceExpandHeight = false,
						childAlignment = "MiddleLeft",
						preferredWidth = uiConstants.SPACING,
					}
				},
			}
		}
	}) or Array:new()
end

function onButtonClickReset()
	for k, v in pairs(State.data.resources) do
		v.current = v.max
	end
	RebuildUi(State)
end

return makeFooter
