local Array = require("lib-array/Array")
local makeUiConfig = require("lib-ui/uiConfig")
local makeUiMain = require("mod-resource-tracker/ui/uiMain")
local style = require("mod-resource-tracker/ui/util/style")
local updateUiVars = require("mod-resource-tracker/ui/util/updateUiVars")

local function RebuildUi()
	updateUiVars()

	local xmlTable = Array:new({ style }):concat(
		State.isFlipped
		and makeUiConfig(TransientState.uiVars.CONFIG_UI_PARAMS)
		or makeUiMain()
	)

	self.UI.setXmlTable(xmlTable)
end

return RebuildUi
