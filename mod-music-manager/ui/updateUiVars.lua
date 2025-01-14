local uiVars = {}

function updateUiVars()
	uiVars.QUALITY = State.config.uiQuality
	uiVars.BASE_OBJ_SCALE = {
		x = 8,
		y = 0.1,
		z = 2
	}

	uiVars.ROW_HEIGHT = 36 * uiVars.QUALITY
	uiVars.SPACING = 12 * uiVars.QUALITY
	uiVars.SPACING_S = 6 * uiVars.QUALITY
	uiVars.UI_HEIGHT_CLOSED = 100 * uiVars.QUALITY
	uiVars.UI_WIDTH = 100 * uiVars.BASE_OBJ_SCALE.x * uiVars.QUALITY
	uiVars.RESOURCE_COUNT_MIN_WIDTH = 30 * uiVars.QUALITY
	uiVars.LINE_WIDTH = 4 * uiVars.QUALITY

	uiVars.HEADER_PADDING = 12 * uiVars.QUALITY
	uiVars.FOOTER_PADDING = uiVars.SPACING_S

	uiVars.ELEMENT_IDS = {
		json = "json",
	}

	State.uiVars = uiVars
end

return updateUiVars
