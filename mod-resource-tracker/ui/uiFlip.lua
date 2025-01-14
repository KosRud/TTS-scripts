local Array = require("lib-array/Array")
local uiConstants = require("mod-resource-tracker/ui/uiConstants")

local jsonInput = ""

local function makeUiFlip()
	return {
		{
			tag = "VerticalLayout",
			attributes = {
				height = 400 * uiConstants.UI_QUALITY,
				width = uiConstants.UI_WIDTH,
				rectAlignment = "UpperCenter",
				rotation = "180, 0, 0",
				position = string.format(
					"%f %f %f",
					0,
					-50,
					100
				),
				scale = string.format("%f %f %f", 1 / uiConstants.BASE_OBJ_SCALE.x / uiConstants.UI_QUALITY,
					1 / uiConstants.BASE_OBJ_SCALE.z / uiConstants.UI_QUALITY,
					1 / uiConstants.BASE_OBJ_SCALE.y / uiConstants.UI_QUALITY),
				childForceExpandWidth = true,
				childForceExpandHeight = false,
				childAlignment = "UpperLeft",
				spacing = uiConstants.SPACING,
				padding = string.format(
					"%s %s %s %s",
					0,
					0,
					0,
					uiConstants.SPACING
				),
				color = "white",
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
					},
				},
				{
					tag = "VerticalLayout",
					attributes = {
						childForceExpandWidth = true,
						childForceExpandHeight = false,
						flexibleHeight = 1,
						childAlignment = "MiddleCenter",
						spacing = uiConstants.SPACING,
						padding = string.format(
							"%s %s %s %s",
							uiConstants.SPACING,
							uiConstants.SPACING,
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
									id = uiConstants.ELEMENT_IDS.json,
									preferredHeight = 0,
									flexibleHeight = 1,
									fontSize = uiConstants.SPACING,
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
								preferredHeight = 32 * uiConstants.UI_QUALITY,
								flexibleHeight = 0,
								childAlignment = "MiddleRight",
								spacing = uiConstants.SPACING,
							},
							children = {
								{
									tag = "Button",
									attributes = {
										preferredWidth = 288,
										text = "Load",
										fontSize = 18 * uiConstants.UI_QUALITY,
										onClick = "onButtonClickJsonLoad"
									},
								},
								{
									tag = "Button",
									attributes = {
										preferredWidth = 288,
										text = "Save",
										fontSize = 18 * uiConstants.UI_QUALITY,
										onClick = "onButtonClickJsonSave"
									},
								},
							}
						}
					},
				},
			}
		}
	}
end

function onButtonClickJsonLoad()
	self.UI.setAttribute(
		uiConstants.ELEMENT_IDS.json,
		"text",
		"\r" .. -- bugs if the first character is "{"
		JSON.encode_pretty(State.data)
	)
end

function onButtonClickJsonSave()
	State.data = JSON.decode(jsonInput)
	RebuildUi(State)
	onButtonClickJsonLoad()
end

function onJsonInputEdit(_, value)
	jsonInput = value
end

return makeUiFlip
