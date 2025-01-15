local Array = {}

function Array:new(tbl) return setmetatable(tbl or {}, {__index = self}) end

function Array:find(predicate)
    for i, v in ipairs(self) do if predicate(v, i, self) then return v end end
    return nil
end

function Array:some(predicate)
    for i, v in ipairs(self) do if predicate(v, i, self) then return true end end
    return nil
end

function Array:map(func)
    local result = self:new()
    for i, value in ipairs(self) do result:push(func(value, i, self)) end
    return result
end

function Array:filter(func)
    local result = self:new()
    for i, value in ipairs(self) do
        if func(value, i, self) then result:push(value) end
    end
    return result
end

function Array:push(...)
    local args = {...}
    for _, value in ipairs(args) do table.insert(self, value) end
    return #self
end

function Array:unshift(...)
    local args = {...}
    local insertedCount = #args
    for _, tbl in ipairs(args) do
        for _, value in ipairs(tbl) do insertedCount = insertedCount + 1; end
    end
    for i = #self, 1, -1 do self[i + insertedCount] = self[i] end
    for i, v in ipairs(args) do self[i] = v end
    return #self
end

function Array:concat(...)
    local result = self:new()
    local args = {...}
    for _, value in ipairs(self) do result:push(value) end
    for _, tbl in ipairs(args) do
        for _, value in ipairs(tbl) do result:push(value) end
    end
    return result
end

return Array
