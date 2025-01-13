local renderUi = require("mod-resource-tracker/renderUi")
local stateDefault = require("mod-resource-tracker/defaultState")

state = stateDefault

function onLoad(savedState)
	if savedState and savedState ~= "" then
		state = JSON.decode(savedState)
	end
	renderUi(state)
	return JSON.encode(state)
end

function onSave()
	return JSON.encode(state)
end

function onRotate(spin, flip, player_color, old_spin, old_flip)
	if math.abs(flip - old_flip) < 10 then
		return
	end
	state.isFlipped = math.abs(flip - 180) < 90
	renderUi(state)
end
