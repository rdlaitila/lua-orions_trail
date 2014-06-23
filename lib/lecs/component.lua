local Component = Class("Component")

function Component:initialize(NAME, SCHEMA)
    self._ecsManager = nil
    self._name = NAME
    self._schema = SCHEMA    
    
    for KEY, VALUE in pairs(SCHEMA) do
        self[KEY] = VALUE
    end
end

return Component