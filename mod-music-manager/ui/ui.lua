local Array = require("lib-array/Array")
local makeUiFlip = require("mod-music-manager/ui/uiFlip")
local makeUiMain = require("mod-music-manager/ui/uiMain")
local style = require("mod-music-manager/ui/style")
local updateUiVars = require("mod-music-manager/ui/updateUiVars")

local function RebuildUi()
	updateUiVars()

	local xmlTable = Array:new({ style }):concat(State.isFlipped and makeUiFlip() or makeUiMain())

	self.UI.setXmlTable(xmlTable)
end

return RebuildUi
