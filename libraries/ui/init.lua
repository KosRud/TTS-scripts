local Array = require("js-like/Array")
local makeUiConfig = require("ui/uiConfig")
local state = require("ui/state")

---@param params UiParams
local function rebuildUi(params)
	local xmlTable = Array:new({ params.style }):concat(
		state.isFlipped
		and makeUiConfig(params.configUiParams, params.object)
		or params.makeUiMain()
	)

	params.object.UI.setXmlTable(xmlTable)
end

return rebuildUi
