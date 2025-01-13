local Array = require("lib-array/Array")
local Object = require("lib-array/Object")

local stateRef = nil

local function rebuildUi(state)
	stateRef = state
	local uiQuality = 4
	local rowHeight = 36 * uiQuality
	local rowSpacing = 16 * uiQuality
	local uiHeightClosed = 100 * uiQuality

	local resources = Object.entries(state.data.resources)
	local uiHeight = math.max(uiHeightClosed, (rowHeight + rowSpacing) * (#resources + 1) - rowSpacing)

	local objScale = state.self.getScale()

	local firstRow = {
		tag = "HorizontalLayout",
		attributes = {
			height = rowHeight * uiQuality,
			childForceExpandWidth = false,
			childForceExpandHeight = false,
			childAlignment = "MiddleRight",
			color = "red",
		},
		children = {
			{
				tag = "Button",
				attributes = {
					preferredHeight = 36 * uiQuality,
					preferredWidth = 36 * uiQuality,
					text = state.isOpen and "▼" or "▶",
					fontSize = 24 * uiQuality,
					textColor = "black",
					colors = "rgb(0.85,0.85,0.85)|rgb(0.95,0.95,0.95)|rgb(0.85,0.85,0.85)",
					onClick = "onButtonClickOpen"
				},
			},

		}
	}

	local rows = state.isOpen and resources:map(
		function(resource)
			return ({
				tag = "HorizontalLayout",
				attributes = {
					childForceExpandWidth = false,
					childForceExpandHeight = false,
					childAlignment = "MiddleRight",
					color = "blue",
				},
				children = {
					{
						tag = "Button",
						attributes = {
							preferredHeight = rowHeight,
							preferredWidth = 36 * uiQuality,
							text = ">",
							fontSize = 24 * uiQuality,
							textColor = "black",
							colors = "rgb(0.85,0.85,0.85)|rgb(0.95,0.95,0.95)|rgb(0.85,0.85,0.85)",
							onClick = "onButtonClickOpen"
						},
					},

				}
			})
		end
	) or Array:new()

	rows:unshift(firstRow)

	state.self.UI.setXmlTable(
		{
			{
				tag = "VerticalLayout",
				attributes = {
					height = state.isOpen and uiHeight or uiHeightClosed,
					width = 400 * uiQuality,
					rectAlignment = "UpperCenter",
					rotation = "0, 0, 0",
					position = string.format(
						"%f %f %f",
						0,
						-50 / objScale.z,
						-10 / objScale.y
					),
					scale = string.format("%f %f %f", -1.0 / objScale.x / uiQuality, -1.0 / objScale.z / uiQuality,
						1.0 / objScale.y / uiQuality),
					childForceExpandWidth = true,
					childForceExpandHeight = false,
					childAlignment = "UpperLeft",
					spacing = rowSpacing,
					color = "white",
				},
				children = rows
			}
		}
	)
end

function onButtonClickOpen()
	stateRef.isOpen = not stateRef.isOpen
	rebuildUi(stateRef)
end

return rebuildUi
