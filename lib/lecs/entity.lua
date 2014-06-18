local Entity = Class("Entity")

function Entity:initialize()
    self._components = {}
    self._tags = {}
end

function Entity:addComponent(COMPONENT)
    local componentFound = false
    
    for a=1, #self._components do
        if self._components[a] == COMPONENT then
            componentFound = true
        end
    end
    
    if componentFound == true  then
        -- TODO: handle failure code
    else        
        table.insert(self._components, COMPONENT)
    end
end

function Entity:addTag(TAGNAME)
    local tagFound = false
    
    for a=1, #self._tags do
        if self._tags[a] == TAGNAME then
            tagFound = true
            break
        end
    end
    
    if tagFound == true then
        -- TODO: failcode
    else
        table.insert(self._tags, TAGNAME)
    end
end

function Entity:getComponent(COMPONENT_NAME)
    local componentFound = false
    
    for a=1, #self._components do
        if self._components[a]._name == COMPONENT_NAME then
            return self._components[a]
        end
    end
end

return Entity