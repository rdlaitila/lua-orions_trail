local Entity = Class("Entity")

function Entity:initialize()
    Lecs.uuid.randomseed(os.time())    
    
    self._id = Lecs.uuid()    
    self._ecsManager = nil
    self._components = {}
    self._tags = {}   
end

function Entity:addComponent(...)
    local componentargs = {...}
    
    for KEY, VALUE in pairs(componentargs) do
        local componentFound = false
        
        for a=1, #self._components do
            if self._components[a] == VALUE then
                componentFound = true
            end
        end
        
        if componentFound == true  then
            -- TODO: handle failure code
        else
            VALUE._entity = self
            table.insert(self._components, VALUE)
        end
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