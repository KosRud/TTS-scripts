local uiVars = {}

function updateUiVars()
	uiVars.QUALITY = State.config.uiQuality
	uiVars.BASE_OBJ_SCALE = {
		x = 5,
		y = 0.1,
		z = 1
	}

	uiVars.UI_HEIGHT_CLOSED = 100 * uiVars.QUALITY
	uiVars.UI_WIDTH = 100 * uiVars.BASE_OBJ_SCALE.x * uiVars.QUALITY


	uiVars.SPACING = 12 * uiVars.QUALITY
	uiVars.SPACING_S = 6 * uiVars.QUALITY

	uiVars.FOOTER_PADDING = uiVars.SPACING_S
	uiVars.HEADER_PADDING = 12 * uiVars.QUALITY
	uiVars.LINE_WIDTH = 4 * uiVars.QUALITY
	uiVars.RESOURCE_COUNT_MIN_WIDTH = 30 * uiVars.QUALITY
	uiVars.ROW_HEIGHT = 36 * uiVars.QUALITY


	uiVars.ELEMENT_IDS = {
		json = "json",
	}

	uiVars.CONFIG_UI_PARAMS = {
		getConfig = function()
			return State.config
		end,
		setConfig = function(config)
			State.config = config
		end,
		UI_WIDTH = uiVars.UI_WIDTH,
		UI_HEIGHT = nil,
		QUALITY = uiVars.QUALITY,
		BASE_OBJ_SCALE = uiVars.BASE_OBJ_SCALE
	}

	TransientState.uiVars = uiVars
end

return updateUiVars
