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
	local uiHeight = math.max(uiHeightClosed, (rowHeight + rowSpacing) * (#resources + 1))

	local firstRow = {
		tag = "HorizontalLayout",
		attributes = {
			height = rowHeight,
			childForceExpandWidth = false,
			childForceExpandHeight = false,
			childAlignment = "MiddleRight",
		},
		children = {
			{
				tag = "Text",
				attributes = {
					preferredHeight = rowHeight,
					flexibleWidth = 1,
					text = "Resource Tracker",
					fontSize = 24 * uiQuality,
					fontStyle = "Bold",
					textColor = "black",
				},
			},
			{
				tag = "Button",
				attributes = {
					preferredHeight = rowHeight,
					preferredWidth = rowHeight,
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
					childAlignment = "MiddleLeft",
				},
				children = {
					{
						tag = "HorizontalLayout", -- padding
						attributes = {
							childForceExpandWidth = false,
							childForceExpandHeight = false,
							childAlignment = "MiddleLeft",
							preferredWidth = 36 * uiQuality,
						}
					},
					{
						tag = "Text",
						attributes = {
							preferredHeight = rowHeight,
							text = resource[1],
							fontSize = 24 * uiQuality,
							textColor = "black",
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
						-50,
						-100
					),
					scale = string.format("%f %f %f", -1 / state.baseObjScale.x / uiQuality,
						-1 / state.baseObjScale.z / uiQuality,
						1 / state.baseObjScale.y / uiQuality),
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
