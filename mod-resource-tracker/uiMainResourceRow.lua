local Array = require("lib-array/Array")
local Object = require("lib-array/Object")
local uiConstants = require("mod-resource-tracker/uiConstants")

local function makeResourceRow(resource, resourceId)
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
					preferredWidth = uiConstants.SPACING,
				}
			},
			{
				tag = "Text",
				attributes = {
					preferredHeight = uiConstants.ROW_HEIGHT,
					flexibleWidth = 1,
					alignment = "MiddleRight",
					text = resource[1] .. ":",
					resizeTextForBestFit = true,
					resizeTextMaxSize = 22 * uiConstants.UI_QUALITY,
					resizeTextMinSize = 0,
					textColor = "black",
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
			{
				tag = "Text",
				attributes = {
					preferredHeight = uiConstants.ROW_HEIGHT,
					minWidth = uiConstants.RESOURCE_COUNT_MIN_WIDTH,
					text = resource[2].current,
					alignment = "MiddleRight",
					fontSize = 24 * uiConstants.UI_QUALITY,
					textColor = "black",
				},
			},
			{
				tag = "Text",
				attributes = {
					preferredHeight = uiConstants.ROW_HEIGHT,
					text = " / ",
					fontSize = 24 * uiConstants.UI_QUALITY,
					textColor = "black",
				},
			},
			{
				tag = "Text",
				attributes = {
					preferredHeight = uiConstants.ROW_HEIGHT,
					minWidth = uiConstants.RESOURCE_COUNT_MIN_WIDTH,
					alignment = "MiddleLeft",
					text = resource[2].max,
					fontSize = 24 * uiConstants.UI_QUALITY,
					textColor = "black",
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
			{
				tag = "Button",
				attributes = {
					preferredHeight = uiConstants.ROW_HEIGHT,
					preferredWidth = uiConstants.ROW_HEIGHT,
					text = "-",
					fontSize = 24 * uiConstants.UI_QUALITY,
					textColor = "black",
					colors = "rgb(0.85,0.85,0.85)|rgb(0.95,0.95,0.95)|rgb(0.85,0.85,0.85)",
					onClick = string.format("onButtonClickResourceMinus(%d)", resourceId)
				},
			},
			{
				tag = "HorizontalLayout", -- padding
				attributes = {
					childForceExpandWidth = false,
					childForceExpandHeight = false,
					childAlignment = "MiddleLeft",
					preferredWidth = uiConstants.SPACING_S,
				}
			},
			{
				tag = "Button",
				attributes = {
					preferredHeight = uiConstants.ROW_HEIGHT,
					preferredWidth = uiConstants.ROW_HEIGHT,
					text = "+",
					fontSize = 24 * uiConstants.UI_QUALITY,
					textColor = "black",
					colors = "rgb(0.85,0.85,0.85)|rgb(0.95,0.95,0.95)|rgb(0.85,0.85,0.85)",
					onClick = string.format("onButtonClickResourcePlus(%d)", resourceId)
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
	})
end

function onButtonClickResourceMinus(_, resourceIdStr)
	local resourceId = tonumber(resourceIdStr)
	local resource = Object.entries(state.data.resources)[resourceId][2]
	resource.current = math.max(resource.current - 1, 0)
	rebuildUi(state)
end

function onButtonClickResourcePlus(_, resourceIdStr)
	local resourceId = tonumber(resourceIdStr)
	local resource = Object.entries(state.data.resources)[resourceId][2]
	resource.current = math.min(resource.current + 1, resource.max)
	rebuildUi(state)
end

return makeResourceRow
