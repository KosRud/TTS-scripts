local Array = require("lib-array.Array")

local Object = {}

function Object.entries(obj)
	local tuples = Array:new({})
	for key, value in pairs(obj) do
		tuples:push({ key, value })
	end
	return tuples
end

function Object.fromEntries(entries)
	local result = {}
	for _, v in ipairs(entries) do
		local key, value = v[0], v[1]
		result[key] = value
	end
	return result
end

return Object
