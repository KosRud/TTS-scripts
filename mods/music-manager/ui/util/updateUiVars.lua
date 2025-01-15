---@type UiVars
local uiVars = {}

local function updateUiVars()
	uiVars.BASE_OBJ_SCALE = {
		x = 6,
		y = 0.1,
		z = 6
	}
	uiVars.QUALITY = State.config.uiQuality

	uiVars.UI_HEIGHT = 100 * uiVars.BASE_OBJ_SCALE.z * uiVars.QUALITY
	uiVars.UI_WIDTH = 100 * uiVars.BASE_OBJ_SCALE.x * uiVars.QUALITY

	uiVars.SPACING = 12 * uiVars.QUALITY
	uiVars.SPACING_S = 6 * uiVars.QUALITY

	uiVars.HEADER_PADDING = 12 * uiVars.QUALITY

	uiVars.CONFIG_UI_PARAMS = {
		getConfig = function()
			return State.config
		end,
		setConfig = function(config)
			State.config = config
		end,
		UI_WIDTH = uiVars.UI_WIDTH,
		UI_HEIGHT = uiVars.UI_HEIGHT,
		QUALITY = uiVars.QUALITY,
		BASE_OBJ_SCALE = uiVars.BASE_OBJ_SCALE
	}

	TransientState.uiVars = uiVars
end

return updateUiVars
