-- class which defines stack type object

stack = class('stack')


function stack:initialize()
    -- entry table
    self.entry = {}
end


-- push a value on to the stack
function stack:push(...)
    if ... then
    local targs = {...}
    -- add values
    for _,v in ipairs(targs) do
        table.insert(self.entry, v)
    end
    end
end

-- pop a value from the stack
function stack:pop(num)

    -- get num values from stack
    local num = num or 1

    -- return table
    local entries = {}

    -- get values into entries
    for i = 1, num do
    -- get last entry
    if #self.entry ~= 0 then
        table.insert(entries, self.entry[#self.entry])
        -- remove last value
        table.remove(self.entry)
    else
        break
    end
    end
    -- return unpacked entries
    return unpack(entries)
end

-- get entries
function stack:getn()
    return #self.entry
end

-- list values
function stack:list()
    for i,v in pairs(self.entry) do
    print(i, v)
    end
end
  