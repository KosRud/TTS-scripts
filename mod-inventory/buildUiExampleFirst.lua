local function buildUiExampleFirst()
	return
	{
		tag = "HorizontalLayout",
		attributes = {

			childForceExpandWidth = false,
			childForceExpandHeight = false,
			childAlignment = "MiddleCenter",
			spacing = 48,
			padding = 24,
			width = 200,
			height = 200,
			color = "white"
		},
		children = {
			{
				tag = "Text",
				attributes = {
					fontSize = 60,
					color = "black",
				},
				value = "Example",
			},
		}
	}
end

return buildUiExampleFirst
