local Array = require("lib-array/Array")

local jsonInput = ""
local configUiParams = {}

local function makeUiConfig(params)
	configUiParams = params

	local spacing = 12 * params.QUALITY

	return {
		{
			tag = "VerticalLayout",
			attributes = {
				height = params.UI_HEIGHT or (400 * params.QUALITY),
				width = params.UI_WIDTH,
				rectAlignment = "UpperCenter",
				rotation = "180, 180, 0",
				position = string.format(
					"%f %f %f",
					0,
					50,
					100
				),
				scale = string.format("%f %f %f", 1 / params.BASE_OBJ_SCALE.x / params.QUALITY,
					1 / params.BASE_OBJ_SCALE.z / params.QUALITY,
					1 / params.BASE_OBJ_SCALE.y / params.QUALITY),
				childForceExpandWidth = true,
				childForceExpandHeight = false,
				childAlignment = "UpperLeft",
				padding = string.format(
					"%s %s %s %s",
					0,
					0,
					0,
					12 * params.QUALITY
				),
				color = "white",
			},
			children = {
				{
					tag = "Text",
					attributes = {
						preferredHeight = 64 * params.QUALITY,
						flexibleWidth = 1,
						text = "Resource Tracker",
						fontSize = 24 * params.QUALITY,
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
						spacing = spacing,
						padding = string.format(
							"%s %s %s %s",
							spacing,
							spacing,
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
									id = "json",
									preferredHeight = 0,
									flexibleHeight = 1,
									fontSize = 12 * params.QUALITY,
									lineType = "MultiLineNewLine",
									onValueChanged = "onJsonInputEdit"
								}
							}
						},
						{
							tag = "HorizontalLayout",
							attributes = {
								childForceExpandWidth = false,
								childForceExpandHeight = true,
								preferredHeight = 32 * params.QUALITY,
								flexibleHeight = 0,
								childAlignment = "MiddleRight",
								spacing = spacing,
							},
							children = {
								{
									tag = "Button",
									attributes = {
										preferredWidth = 108 * params.QUALITY,
										text = "Load",
										fontSize = 18 * params.QUALITY,
										onClick = "onButtonClickJsonLoad"
									},
								},
								{
									tag = "Button",
									attributes = {
										preferredWidth = 108 * params.QUALITY,
										text = "Save",
										fontSize = 18 * params.QUALITY,
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
	config = configUiParams.getConfig()

	self.UI.setAttribute(
		TransientState.uiVars.ELEMENT_IDS.json,
		"text",
		"\r" .. -- bugs if the first character is "{"
		JSON.encode_pretty(config)
	)
end

function onButtonClickJsonSave()
	local config = JSON.decode(jsonInput)

	configUiParams.setConfig(config)
	RebuildUi()
	onButtonClickJsonLoad()
end

function onJsonInputEdit(_, value)
	jsonInput = value
end

return makeUiConfig
