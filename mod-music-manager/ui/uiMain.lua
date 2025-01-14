local Array = require("lib-array/Array")
local Object = require("lib-array/Object")
local makeHeader = require("mod-music-manager/ui/uiMainHeader")

local function makeUiMain()
	local uiVars = State.uiVars

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
						-50,
						-100
					),
					scale = string.format("%f %f %f", 1 / uiVars.BASE_OBJ_SCALE.x / uiVars.QUALITY,
						1 / uiVars.BASE_OBJ_SCALE.z / uiVars.QUALITY,
						-1 / uiVars.BASE_OBJ_SCALE.y / uiVars.QUALITY),
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
								-- tag = "VerticalLayout",
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
											color = "black",
											preferredWidth = 216 * uiVars.QUALITY,
											preferredHeight = 216 * uiVars.QUALITY,
											minHeight = 216 * uiVars.QUALITY,
											minWidth = 216 * uiVars.QUALITY,
										},
										children = {
											{
												tag = "Text",
												attributes = {
													flexibleWidth = 1,
													preferredHeight = 128 * uiVars.QUALITY,
													text = "Music Manager",
													fontSize = 24 * uiVars.QUALITY,
													fontStyle = "Bold",
													color = "red"
												},
											}
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
