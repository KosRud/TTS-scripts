local rebuildUi = require("mod-resource-tracker/rebuildUi")

local state = {
	data = {
		resources = {
			["spell slot (level 1)"] = {
				max = 4,
				current = 4
			},
			["spell slot (level 2)"] = {
				max = 3,
				current = 3
			},
			["spell slot (level 3)"] = {
				max = 2,
				current = 2
			}
		}
	},
	isOpen = true,
	baseObjScale = {
		x = 4,
		y = 0.1,
		z = 1
	},
	isFlipped = false,
}



function onLoad(savedState)
	if savedState and savedState ~= "" then
		state = JSON.decode(savedState)
	end
	rebuildUi(state)
end

function onSave()
	return JSON.encode(state)
end

function onRotate(spin, flip, player_color, old_spin, old_flip)
	if math.abs(flip - old_flip) < 10 then
		return
	end
	state.isFlipped = math.abs(flip - 180) < 90
	rebuildUi(state)
end
