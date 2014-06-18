local Manager = Class("Manager")

function Manager:initialize()
    self._entities = {}
    self._systems = {}
    
    return self
end

function Manager:addEntity(ENTITY)
    local entityFound = false
    
    for a=1, #self._entities do
        if self._entities[a] == ENTITY then
            entityFound = true
            break
        end
    end
    
    if entityFound == false then
        table.insert(self._entities, ENTITY)
    else
        -- TODO: failcode
    end
end

function Manager:addSystem(SYSTEM)
    local systemFound = false
    
    for a=1, #self._systems do
        if self._systems[a] == SYSTEM then
            systemFound = true
            break
        end
    end
    
    if systemFound == false then
        table.insert(self._systems, SYSTEM)
    else
        -- TODO: failcode
    end
end

function Manager:getEntities(...)
end

return Manager