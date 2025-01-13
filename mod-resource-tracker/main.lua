local rebuildUi = require("mod-resource-tracker/rebuildUi")

local state = {
	data = {},
	isOpen = false
}

local str = [[
	{
		"resources": {
			"spell slot (level 1)": {
				"max": 4,
				"current": 3
			},
			"spell slot (level 2)": {
				"max": 4,
				"current": 3
			},
			"spell slot (level 3)": {
				"max": 4,
				"current": 3
			},
			"spell slot (level 4)": {
				"max": 4,
				"current": 3
			},
			"spell slot (level 5)": {
				"max": 4,
				"current": 3
			},
			"spell slot (level 6)": {
				"max": 4,
				"current": 3
			},
			"spell slot (level 7)": {
				"max": 4,
				"current": 3
			},
			"spell slot (level 8)": {
				"max": 4,
				"current": 3
			},
			"spell slot (level 9)": {
				"max": 4,
				"current": 3
			}
		}
	}
]]



function onLoad(dataSaved)
	state.data = JSON.decode(str)
	state.self = self
	rebuildUi(state)
end

function onSave()
end
