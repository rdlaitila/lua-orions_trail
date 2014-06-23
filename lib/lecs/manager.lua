local Manager = Class("Manager")

function Manager:initialize()
    self._entities = {}
    self._systems = {}
end

function Manager:update(DT)
    table.sort(self._systems, function(A, B) 
        return A._priority < B._priority
    end)
    
    for a=1, #self._systems do
        self._systems[a]:update(DT)
    end
end

function Manager:draw()
    table.sort(self._systems, function(A, B) 
        return A._priority < B._priority
    end)
    
    for a=1, #self._systems do
        self._systems[a]:draw()
    end
end

function Manager:addEntity(...)
    local entityargs = {...}
    
    for key, value in pairs(entityargs) do
        local entityFound = false
        
        for b=1, #self._entities do
            if self._entities[b] == value then
                entityFound = true
                break
            end
        end
        
        if entityFound == false then
            value._ecsManager = self
            table.insert(self._entities, value)
        else
            -- TODO: failcode
        end
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
        SYSTEM._ecsManager = self
        table.insert(self._systems, SYSTEM)
    else
        -- TODO: failcode
    end
end

function Manager:getEntitiesWithTag(TAGNAME)    
    local entities = {}    
    for a=1, #self._entities do
        for b=1, #self._entities[a]._tags do                    
            if self._entities[a]._tags[b]:lower() == TAGNAME:lower() then                
                table.insert(entities, self._entities[a])                
            end
        end
    end
    return entities
end

return Manager