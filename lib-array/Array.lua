local Array = {}

function Array:new(tbl)
	return setmetatable(
		tbl or {},
		{ __index = self }
	)
end

function Array:map(func)
	local result = self:new()
	for i, value in ipairs(self) do
		result[i] = func(value, i, self)
	end
	return result
end

return Array
