local Array = require("lib-array/Array")
local makeUiFlip = require("mod-resource-tracker/ui/uiFlip")
local makeUiMain = require("mod-resource-tracker/ui/uiMain")
local style = require("mod-resource-tracker/ui/style")

local function RebuildUi()
	local xmlTable = Array:new({ style }):concat(State.isFlipped and makeUiFlip() or makeUiMain())

	self.UI.setXmlTable(xmlTable)
end

return RebuildUi
