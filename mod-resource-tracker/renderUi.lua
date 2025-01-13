local Array = require("lib-array/Array")
local Object = require("lib-array/Object")

local UI_QUALITY = 3
local BASE_OBJ_SCALE = {
	x = 5,
	y = 0.1,
	z = 1
}

local jsonInput = ""
local uiElementIds = {
	json = "json",
}

local ROW_HEIGHT = 36 * UI_QUALITY
local SPACING = 12 * UI_QUALITY
local SPACING_S = 6 * UI_QUALITY
local UI_HEIGHT_CLOSED = 100 * UI_QUALITY
local UI_WIDTH = 100 * BASE_OBJ_SCALE.x * UI_QUALITY
local RESOURCE_COUNT_MIN_WIDTH = 30 * UI_QUALITY
local LINE_WIDTH = 4 * UI_QUALITY

local HEADER_PADDING = 12 * UI_QUALITY
local FOOTER_PADDING = SPACING_S



local function uiMain(state)
	local resources = Object.entries(state.data.resources)
	local uiHeight = math.max(
		UI_HEIGHT_CLOSED,
		(
			(ROW_HEIGHT + SPACING) * (#resources + 2)
			+ HEADER_PADDING * 2
			+ FOOTER_PADDING * 2
		)
	)

	local header = Array:new({
		{
			tag = "HorizontalLayout",
			attributes = {
				preferredHeight = ROW_HEIGHT + HEADER_PADDING * 2,
				flexibleHeight = state.isOpen and 0 or 1,
				childForceExpandWidth = false,
				childForceExpandHeight = false,
				childAlignment = "MiddleRight",
				color = "rgb(0.4, 0.8, 0.4)",
				padding = string.format(
					"%s %s %s %s",
					HEADER_PADDING,
					HEADER_PADDING,
					HEADER_PADDING,
					HEADER_PADDING
				)
			},
			children = {
				{
					tag = "Text",
					attributes = {
						preferredHeight = ROW_HEIGHT,
						flexibleWidth = 1,
						text = "Resource Tracker",
						fontSize = 24 * UI_QUALITY,
						fontStyle = "Bold",
						textColor = "black",
					},
				},
				{
					tag = "Button",
					attributes = {
						preferredHeight = ROW_HEIGHT,
						preferredWidth = ROW_HEIGHT,
						text = state.isOpen and "▼" or "▶",
						fontSize = 24 * UI_QUALITY,
						textColor = "black",
						colors = "rgb(0.85,0.85,0.85)|rgb(0.95,0.95,0.95)|rgb(0.85,0.85,0.85)",
						onClick = "onButtonClickOpen(1)"
					},
				},

			}
		},
	})

	local footer = state.isOpen and Array:new({
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
					FOOTER_PADDING,
					FOOTER_PADDING
				)
			},
			children = {
				{
					tag = "Button",
					attributes = {
						preferredHeight = ROW_HEIGHT,
						preferredWidth = 144 * UI_QUALITY,
						text = "Reset",
						fontSize = 24 * UI_QUALITY,
						textColor = "black",
						colors = "rgb(0.85,0.85,0.85)|rgb(0.95,0.95,0.95)|rgb(0.85,0.85,0.85)",
						onClick = "onButtonClickReset"
					},
				},
				{
					tag = "HorizontalLayout", -- padding
					attributes = {
						childForceExpandWidth = false,
						childForceExpandHeight = false,
						childAlignment = "MiddleLeft",
						preferredWidth = SPACING,
					}
				},
			}
		}
	}) or Array:new()

	local rows = state.isOpen and resources:map(
		function(resource, resourceId)
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
							preferredWidth = SPACING,
						}
					},
					{
						tag = "Text",
						attributes = {
							preferredHeight = ROW_HEIGHT,
							flexibleWidth = 1,
							alignment = "MiddleRight",
							text = resource[1] .. ":",
							resizeTextForBestFit = true,
							resizeTextMaxSize = 22 * UI_QUALITY,
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
							preferredWidth = SPACING,
						}
					},
					{
						tag = "Text",
						attributes = {
							preferredHeight = ROW_HEIGHT,
							minWidth = RESOURCE_COUNT_MIN_WIDTH,
							text = resource[2].current,
							alignment = "MiddleRight",
							fontSize = 24 * UI_QUALITY,
							textColor = "black",
						},
					},
					{
						tag = "Text",
						attributes = {
							preferredHeight = ROW_HEIGHT,
							text = " / ",
							fontSize = 24 * UI_QUALITY,
							textColor = "black",
						},
					},
					{
						tag = "Text",
						attributes = {
							preferredHeight = ROW_HEIGHT,
							minWidth = RESOURCE_COUNT_MIN_WIDTH,
							alignment = "MiddleLeft",
							text = resource[2].max,
							fontSize = 24 * UI_QUALITY,
							textColor = "black",
						},
					},
					{
						tag = "HorizontalLayout", -- padding
						attributes = {
							childForceExpandWidth = false,
							childForceExpandHeight = false,
							childAlignment = "MiddleLeft",
							preferredWidth = SPACING,
						}
					},
					{
						tag = "Button",
						attributes = {
							preferredHeight = ROW_HEIGHT,
							preferredWidth = ROW_HEIGHT,
							text = "-",
							fontSize = 24 * UI_QUALITY,
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
							preferredWidth = SPACING_S,
						}
					},
					{
						tag = "Button",
						attributes = {
							preferredHeight = ROW_HEIGHT,
							preferredWidth = ROW_HEIGHT,
							text = "+",
							fontSize = 24 * UI_QUALITY,
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
							preferredWidth = SPACING,
						}
					},
				}
			})
		end
	) or Array:new()

	rows = header:concat(rows, footer)

	self.UI.setXmlTable(
		{
			{
				tag = "VerticalLayout",
				attributes = {
					height = state.isOpen and uiHeight or UI_HEIGHT_CLOSED,
					width = UI_WIDTH,
					rectAlignment = "UpperCenter",
					rotation = "0, 0, 0",
					position = string.format(
						"%f %f %f",
						0,
						-50,
						-100
					),
					scale = string.format("%f %f %f", -1 / BASE_OBJ_SCALE.x / UI_QUALITY,
						-1 / BASE_OBJ_SCALE.z / UI_QUALITY,
						1 / BASE_OBJ_SCALE.y / UI_QUALITY),
					childForceExpandWidth = true,
					childForceExpandHeight = false,
					childAlignment = "UpperLeft",
					spacing = SPACING,
					color = "white",
				},
				children = rows
			}
		}
	)
end

local function uiFlip(state)
	self.UI.setXmlTable({
		{
			tag = "VerticalLayout",
			attributes = {
				height = 400 * UI_QUALITY,
				width = UI_WIDTH,
				rectAlignment = "UpperCenter",
				rotation = "180, 0, 0",
				position = string.format(
					"%f %f %f",
					0,
					-50,
					100
				),
				scale = string.format("%f %f %f", 1 / BASE_OBJ_SCALE.x / UI_QUALITY,
					1 / BASE_OBJ_SCALE.z / UI_QUALITY,
					1 / BASE_OBJ_SCALE.y / UI_QUALITY),
				childForceExpandWidth = true,
				childForceExpandHeight = false,
				childAlignment = "UpperLeft",
				spacing = SPACING,
				padding = string.format(
					"%s %s %s %s",
					0,
					0,
					0,
					SPACING
				),
				color = "white",
			},
			children = {
				{
					tag = "Text",
					attributes = {
						preferredHeight = ROW_HEIGHT,
						flexibleWidth = 1,
						text = "Resource Tracker",
						fontSize = 24 * UI_QUALITY,
						fontStyle = "Bold",
					},
				},
				{
					tag = "VerticalLayout",
					attributes = {
						childForceExpandWidth = true,
						childForceExpandHeight = false,
						flexibleHeight = 1,
						childAlignment = "MiddleCenter",
						spacing = SPACING,
						padding = string.format(
							"%s %s %s %s",
							SPACING,
							SPACING,
							0,
							0
						),
					},
					children = {
						{
							tag = "HorizontalLayout", -- wrapper to limit size expansion due to large text
							attributes = {
								childForceExpandWidth = true,
								childForceExpandHeight = false,
								childAlignment = "MiddleCenter",
								preferredHeight = 0,
								flexibleHeight = 1,
							},
							children = {
								tag = "InputField",
								attributes = {
									id = uiElementIds.json,
									preferredHeight = 0,
									flexibleHeight = 1,
									fontSize = SPACING,
									colors =
									"rgba(0.7,0.7,0.7,1)|rgba(0.8,0.8,0.8,1)|rgba(0.8,0.8,0.8,1)|rgba(0.4,0.4,0.4,1)",
									lineType = "MultiLineNewLine",
									characterLimit = 0,
									onValueChanged = "onJsonInputEdit"
								}
							}
						},
						{
							tag = "HorizontalLayout",
							attributes = {
								childForceExpandWidth = false,
								childForceExpandHeight = true,
								preferredHeight = 32 * UI_QUALITY,
								flexibleHeight = 0,
								childAlignment = "MiddleRight",
								spacing = SPACING,
							},
							children = {
								{
									tag = "Button",
									attributes = {
										preferredWidth = 288,
										text = "Load",
										fontSize = 18 * UI_QUALITY,
										textColor = "black",
										colors = "rgb(0.85,0.85,0.85)|rgb(0.95,0.95,0.95)|rgb(0.85,0.85,0.85)",
										onClick = "onButtonClickJsonLoad"
									},
								},
								{
									tag = "Button",
									attributes = {
										preferredWidth = 288,
										text = "Save",
										fontSize = 18 * UI_QUALITY,
										textColor = "black",
										colors = "rgb(0.85,0.85,0.85)|rgb(0.95,0.95,0.95)|rgb(0.85,0.85,0.85)",
										onClick = "onButtonClickJsonSave"
									},
								},
							}
						}
					},
				},
			}
		}
	})
end


local function rebuildUi(state)
	if state.isFlipped then
		uiFlip(state)
	else
		uiMain(state)
	end
end

function onButtonClickOpen()
	state.isOpen = not state.isOpen
	rebuildUi(state)
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

function onButtonClickJsonLoad()
	self.UI.setAttribute(
		uiElementIds.json,
		"text",
		"\r" .. -- bugs if the first character is "{"
		JSON.encode_pretty(state.data)
	)
end

function onButtonClickJsonSave()
	state.data = JSON.decode(jsonInput)
	rebuildUi(state)
	onButtonClickJsonLoad()
end

function onJsonInputEdit(_, value)
	jsonInput = value
end

function onButtonClickReset()
	for k, v in pairs(state.data.resources) do
		v.current = v.max
	end
	rebuildUi(state)
end

return rebuildUi
