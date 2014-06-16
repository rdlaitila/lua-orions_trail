local Entity

function Entity:new()
    local self = {}
    
    self._components = {}
    self._tags = {}
    
    return self
end

function Entity:addComponent(NAME, VALUES)
    table.insert(self._components, Component:new(NAME, VALUES))
end

function Entity:getComponent(NAME)
    for a=1, #self._components do
        if self._components[a]._name == NAME then
            return self._components[a]
        end
    end
end

function Entity:removeComponent()
end

return Entity