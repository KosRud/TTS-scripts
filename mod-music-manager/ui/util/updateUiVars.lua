local uiVars = {}

function updateUiVars()
	uiVars.QUALITY = State.config.uiQuality
	uiVars.BASE_OBJ_SCALE = {
		x = 6,
		y = 0.1,
		z = 6
	}

	uiVars.UI_HEIGHT = 100 * uiVars.BASE_OBJ_SCALE.z * uiVars.QUALITY
	uiVars.UI_WIDTH = 100 * uiVars.BASE_OBJ_SCALE.x * uiVars.QUALITY

	uiVars.SPACING_S = 6 * uiVars.QUALITY
	uiVars.SPACING = 12 * uiVars.QUALITY

	uiVars.HEADER_PADDING = 12 * uiVars.QUALITY

	uiVars.ELEMENT_IDS = {
		json = "json",
	}

	State.uiVars = uiVars
end

return updateUiVars
