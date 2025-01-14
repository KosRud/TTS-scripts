local Array = require("lib-array/Array")
local Object = require("lib-array/Object")

local function makeResourceRow(resource, resourceId)
	local uiVars = State.uiVars

	return ({
		tag = "HorizontalLayout",
		attributes = {
			childForceExpandWidth = false,
			childForceExpandHeight = false,
			childAlignment = "MiddleLeft",
		},
		children = {
			{
				tag = "HorizontalLayout", -- padding
				attributes = {
					childForceExpandWidth = false,
					childForceExpandHeight = false,
					childAlignment = "MiddleLeft",
					preferredWidth = uiVars.SPACING,
				}
			},
			{
				tag = "Text",
				attributes = {
					preferredHeight = uiVars.ROW_HEIGHT,
					flexibleWidth = 1,
					alignment = "MiddleRight",
					text = resource[1] .. ":",
					resizeTextForBestFit = true,
					resizeTextMaxSize = 22 * uiVars.QUALITY,
					resizeTextMinSize = 0,
				},
			},
			{
				tag = "HorizontalLayout", -- padding
				attributes = {
					childForceExpandWidth = false,
					childForceExpandHeight = false,
					childAlignment = "MiddleLeft",
					preferredWidth = uiVars.SPACING,
				}
			},
			{
				tag = "Text",
				attributes = {
					preferredHeight = uiVars.ROW_HEIGHT,
					minWidth = uiVars.RESOURCE_COUNT_MIN_WIDTH,
					text = resource[2].current,
					alignment = "MiddleRight",
					fontSize = 24 * uiVars.QUALITY,
				},
			},
			{
				tag = "Text",
				attributes = {
					preferredHeight = uiVars.ROW_HEIGHT,
					text = " / ",
					fontSize = 24 * uiVars.QUALITY,
				},
			},
			{
				tag = "Text",
				attributes = {
					preferredHeight = uiVars.ROW_HEIGHT,
					minWidth = uiVars.RESOURCE_COUNT_MIN_WIDTH,
					alignment = "MiddleLeft",
					text = resource[2].max,
					fontSize = 24 * uiVars.QUALITY,
				},
			},
			{
				tag = "HorizontalLayout", -- padding
				attributes = {
					childForceExpandWidth = false,
					childForceExpandHeight = false,
					childAlignment = "MiddleLeft",
					preferredWidth = uiVars.SPACING,
				}
			},
			{
				tag = "Button",
				attributes = {
					preferredHeight = uiVars.ROW_HEIGHT,
					preferredWidth = uiVars.ROW_HEIGHT,
					text = "-",
					fontSize = 24 * uiVars.QUALITY,
					onClick = string.format("onButtonClickResourceMinus(%d)", resourceId)
				},
			},
			{
				tag = "HorizontalLayout", -- padding
				attributes = {
					childForceExpandWidth = false,
					childForceExpandHeight = false,
					childAlignment = "MiddleLeft",
					preferredWidth = uiVars.SPACING_S,
				}
			},
			{
				tag = "Button",
				attributes = {
					preferredHeight = uiVars.ROW_HEIGHT,
					preferredWidth = uiVars.ROW_HEIGHT,
					text = "+",
					fontSize = 24 * uiVars.QUALITY,
					onClick = string.format("onButtonClickResourcePlus(%d)", resourceId)
				},
			},
			{
				tag = "HorizontalLayout", -- padding
				attributes = {
					childForceExpandWidth = false,
					childForceExpandHeight = false,
					childAlignment = "MiddleLeft",
					preferredWidth = uiVars.SPACING,
				}
			},
		}
	})
end

function onButtonClickResourceMinus(_, resourceIdStr)
	local resourceId = tonumber(resourceIdStr)
	local resource = Object.entries(State.config.resources)[resourceId][2]
	resource.current = math.max(resource.current - 1, 0)
	RebuildUi()
end

function onButtonClickResourcePlus(_, resourceIdStr)
	local resourceId = tonumber(resourceIdStr)
	local resource = Object.entries(State.config.resources)[resourceId][2]
	resource.current = math.min(resource.current + 1, resource.max)
	RebuildUi()
end

return makeResourceRow
