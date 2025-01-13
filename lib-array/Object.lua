local Array = require("lib-array/Array")

local Object = {}

function Object.entries(obj)
	local tuples = Array:new({})
	for key, value in pairs(obj) do
		tuples:push({ key, value })
	end
	return tuples
end

return Object
