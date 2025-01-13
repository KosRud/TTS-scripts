local Array = require("lib-array/Array")
local Object = require("lib-array/Object")

local stateRef = nil

local jsonInput = ""

local UI_QUALITY = 4
local ROW_HEIGHT = 36 * UI_QUALITY
local ROW_SPACING = 12 * UI_QUALITY
local UI_HEIGHT_CLOSED = 100 * UI_QUALITY
local RESOURCE_COUNT_MIN_WIDTH = 30 * UI_QUALITY
local LINE_WIDTH = 4 * UI_QUALITY
local HEADER_PADDING = 12 * UI_QUALITY

local uiElementIds = {
	json = "json",
}

local function uiMain(state)
	local resources = Object.entries(state.data.resources)
	local uiHeight = math.max(
		UI_HEIGHT_CLOSED,
		(
			(ROW_HEIGHT + ROW_SPACING) * (#resources + 1)
			+ HEADER_PADDING * 2
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
		}
	})

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
							preferredWidth = 12 * UI_QUALITY,
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
							resizeTextMaxSize = 24 * UI_QUALITY,
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
							preferredWidth = 12 * UI_QUALITY,
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
							preferredWidth = 12 * UI_QUALITY,
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
							preferredWidth = 6 * UI_QUALITY,
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
							preferredWidth = 12 * UI_QUALITY,
						}
					},
				}
			})
		end
	) or Array:new()

	rows = header:concat(rows)

	self.UI.setXmlTable(
		{
			{
				tag = "VerticalLayout",
				attributes = {
					height = state.isOpen and uiHeight or UI_HEIGHT_CLOSED,
					width = 400 * UI_QUALITY,
					rectAlignment = "UpperCenter",
					rotation = "0, 0, 0",
					position = string.format(
						"%f %f %f",
						0,
						-50,
						-100
					),
					scale = string.format("%f %f %f", -1 / state.baseObjScale.x / UI_QUALITY,
						-1 / state.baseObjScale.z / UI_QUALITY,
						1 / state.baseObjScale.y / UI_QUALITY),
					childForceExpandWidth = true,
					childForceExpandHeight = false,
					childAlignment = "UpperLeft",
					spacing = ROW_SPACING,
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
				width = 400 * UI_QUALITY,
				rectAlignment = "UpperCenter",
				rotation = "180, 0, 0",
				position = string.format(
					"%f %f %f",
					0,
					-50,
					100
				),
				scale = string.format("%f %f %f", 1 / state.baseObjScale.x / UI_QUALITY,
					1 / state.baseObjScale.z / UI_QUALITY,
					1 / state.baseObjScale.y / UI_QUALITY),
				childForceExpandWidth = true,
				childForceExpandHeight = false,
				childAlignment = "UpperLeft",
				spacing = ROW_SPACING,
				padding = string.format(
					"%s %s %s %s",
					0,
					0,
					0,
					12 * UI_QUALITY
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
						spacing = 12 * UI_QUALITY,
						padding = string.format(
							"%s %s %s %s",
							12 * UI_QUALITY,
							12 * UI_QUALITY,
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
									fontSize = 12 * UI_QUALITY,
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
								spacing = ROW_SPACING,
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
	stateRef = state
	if state.isFlipped then
		uiFlip(state)
	else
		uiMain(state)
	end
end

function onButtonClickOpen()
	stateRef.isOpen = not stateRef.isOpen
	rebuildUi(stateRef)
end

function onButtonClickResourceMinus(_, resourceIdStr)
	local resourceId = tonumber(resourceIdStr)
	local resource = Object.entries(stateRef.data.resources)[resourceId][2]
	resource.current = resource.current - 1
	rebuildUi(stateRef)
end

function onButtonClickResourcePlus(_, resourceIdStr)
	local resourceId = tonumber(resourceIdStr)
	local resource = Object.entries(stateRef.data.resources)[resourceId][2]
	resource.current = resource.current + 1
	rebuildUi(stateRef)
end

function onButtonClickJsonLoad()
	self.UI.setAttribute(
		uiElementIds.json,
		"text",
		"\r" .. -- bugs if the first character is "{"
		JSON.encode_pretty(stateRef.data)
	)
end

function onButtonClickJsonSave()
	stateRef.data = JSON.decode(jsonInput)
	rebuildUi(stateRef)
	onButtonClickJsonLoad()
end

function onJsonInputEdit(_, value)
	jsonInput = value
end

return rebuildUi
