local makeUiFlip = require("mod-resource-tracker/uiFlip")
local makeUiMain = require("mod-resource-tracker/uiMain")

local function rebuildUi()
	if state.isFlipped then
		self.UI.setXmlTable(makeUiFlip())
	else
		self.UI.setXmlTable(makeUiMain())
	end
end

return rebuildUi
