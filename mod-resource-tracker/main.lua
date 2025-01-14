RebuildUi = require("mod-resource-tracker/ui/ui")
State = require("mod-resource-tracker/defaultState")

function onLoad(savedState)
	if savedState and savedState ~= "" then
		State = JSON.decode(savedState)
	end
	RebuildUi()
	return JSON.encode(State)
end

function onSave()
	return JSON.encode(State)
end

function onRotate(spin, flip, player_color, old_spin, old_flip)
	if math.abs(flip - old_flip) < 10 then
		return
	end
	State.isFlipped = math.abs(flip - 180) < 90
	RebuildUi()
end
