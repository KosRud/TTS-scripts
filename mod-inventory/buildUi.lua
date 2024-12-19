local function buildUi(self, canvasSize, childrenBuilders)
	local objectScale = self.getScale()
	local children = childrenBuilders:map(function(builder) return builder() end)

	return {
		{
			tag = "VerticalLayout",
			attributes = {
				width = canvasSize.x * objectScale.x,
				height = canvasSize.z * objectScale.z,
				scale = string.format(
					"%f %f %f",
					100 / canvasSize.x / objectScale.x,
					-100 / canvasSize.z / objectScale.z,
					1),
				position = "0 0 60",
				color = "transparent",
				childForceExpandWidth = false,
				childForceExpandHeight = false,
				childAlignment = "MiddleCenter",
				spacing = "48",
			},
			children = children
		}
	}
end

return buildUi
