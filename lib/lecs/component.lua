local Component = class("Component")

function Component:initialize(NAME)
    self._ecsManager = nil
    self._entity = nil
    self._name = NAME    
end

return Component