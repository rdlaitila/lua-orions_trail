local Component = Class("Component")

function Component:initialize(NAME, SCHEMA)
    self._name = NAME
    self._schema = SCHEMA
    
    for KEY, VALUE in pairs(SCHEMA) do
        self[KEY] = VALUE
    end
    
    return self
end

return Component