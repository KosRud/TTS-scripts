local Array = require("lib-array/Array")
local Object = require("lib-array/Object")
local makeHeader = require("mod-music-manager/ui/uiMainHeader")

local function makeUiMain()
	local uiVars = TransientState.uiVars

	return (
		{
			{
				tag = "VerticalLayout",
				attributes = {
					height = uiVars.UI_HEIGHT,
					width = uiVars.UI_WIDTH,
					rectAlignment = "UpperCenter",
					rotation = "0, 0, 0",
					position = string.format(
						"%f %f %f",
						0,
						50,
						-100
					),
					scale = string.format("%f %f %f", 1 / uiVars.BASE_OBJ_SCALE.x / uiVars.QUALITY,
						1 / uiVars.BASE_OBJ_SCALE.z / uiVars.QUALITY,
						1 / uiVars.BASE_OBJ_SCALE.y / uiVars.QUALITY),
					childForceExpandWidth = true,
					childForceExpandHeight = false,
					childAlignment = "UpperLeft",
				},
				children = {
					makeHeader(),
					{
						tag = "HorizontalLayout",
						attributes = {
							preferredHeight = 0,
							flexibleHeight = 1,
							childForceExpandWidth = false,
							childForceExpandHeight = true,
							color = "rgb(0.9, 0.9, 0.4)",
						},
						children = {
							{
								tag = "VerticalScrollView",
								attributes = {
									preferredWidth = 216 * uiVars.QUALITY,
									flexibleWidth = 0,
									scrollbarColors = "yellow | red | green | blue",
									verticalScrollbarVisibility = "Permanent",
									color = "green",
								},
								children = {
									{
										tag = "VerticalLayout",
										attributes = {
											childForceExpandHeight = false,
											childForceExpandWidth = true,
											height = 2000 * uiVars.QUALITY -- must calculate
										},
										children = {
											{
												tag = "VerticalLayout",
												attributes = {
													preferredHeight = 216 * uiVars.QUALITY,
													color = "blue"
												},
												children = {}
											},
											{
												tag = "VerticalLayout",
												attributes = {
													preferredHeight = 216 * uiVars.QUALITY,
													color = "red"
												},
												children = {}
											},
											{
												tag = "VerticalLayout",
												attributes = {
													preferredHeight = 216 * uiVars.QUALITY,
													color = "green"
												},
												children = {}
											},
										}
									},
								}
							},
							{
								tag = "HorizontalLayout", -- padding
								attributes = {
									preferredWidth = uiVars.SPACING_S,
								},

							},
							{
								tag = "VerticalScrollView",
								attributes = {
									preferredWidth = 0,
									flexibleWidth = 1,
									scrollbarColors = "yellow | red | green | blue",
								},
								children = {
									--
								}
							}
						}
					}
				}
			}
		}
	)
end

return makeUiMain
