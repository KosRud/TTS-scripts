local Array = require("lib-array/Array")

local jsonInput = ""

local function makeUiFlip()
	local uiVars = State.uiVars

	return {
		{
			tag = "VerticalLayout",
			attributes = {
				height = 400 * uiVars.QUALITY,
				width = uiVars.UI_WIDTH,
				rectAlignment = "UpperCenter",
				rotation = "180, 0, 0",
				position = string.format(
					"%f %f %f",
					0,
					-50,
					100
				),
				scale = string.format("%f %f %f", 1 / uiVars.BASE_OBJ_SCALE.x / uiVars.QUALITY,
					1 / uiVars.BASE_OBJ_SCALE.z / uiVars.QUALITY,
					1 / uiVars.BASE_OBJ_SCALE.y / uiVars.QUALITY),
				childForceExpandWidth = true,
				childForceExpandHeight = false,
				childAlignment = "UpperLeft",
				spacing = uiVars.SPACING,
				padding = string.format(
					"%s %s %s %s",
					0,
					0,
					0,
					uiVars.SPACING
				),
				color = "white",
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
					},
				},
				{
					tag = "VerticalLayout",
					attributes = {
						childForceExpandWidth = true,
						childForceExpandHeight = false,
						flexibleHeight = 1,
						childAlignment = "MiddleCenter",
						spacing = uiVars.SPACING,
						padding = string.format(
							"%s %s %s %s",
							uiVars.SPACING,
							uiVars.SPACING,
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
									id = uiVars.ELEMENT_IDS.json,
									preferredHeight = 0,
									flexibleHeight = 1,
									fontSize = uiVars.SPACING,
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
								preferredHeight = 32 * uiVars.QUALITY,
								flexibleHeight = 0,
								childAlignment = "MiddleRight",
								spacing = uiVars.SPACING,
							},
							children = {
								{
									tag = "Button",
									attributes = {
										preferredWidth = 108 * uiVars.QUALITY,
										text = "Load",
										fontSize = 18 * uiVars.QUALITY,
										onClick = "onButtonClickJsonLoad"
									},
								},
								{
									tag = "Button",
									attributes = {
										preferredWidth = 108 * uiVars.QUALITY,
										text = "Save",
										fontSize = 18 * uiVars.QUALITY,
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
		State.uiVars.ELEMENT_IDS.json,
		"text",
		"\r" .. -- bugs if the first character is "{"
		JSON.encode_pretty(State.config)
	)
end

function onButtonClickJsonSave()
	State.config = JSON.decode(jsonInput)
	RebuildUi()
	onButtonClickJsonLoad()
end

function onJsonInputEdit(_, value)
	jsonInput = value
end

return makeUiFlip
