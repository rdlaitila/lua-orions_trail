local ecs = {}

ecs.components = {}
ecs.entities = {}
ecs.updateSystems = {}
ecs.renderSystems = {}

--[[
-- Creates New Component
-- Returns: Component Object
-- Example: Simple Instantiation
---     ecs:newComponent("position", {x=0, y=0})
]]
function ecs:newComponent(NAME, SCHEMA)
    local component = {}
    local component_mt = {}
    
    component._name = NAME    
    component._schema = SCHEMA
    
    component_mt.__index = function(TABLE, KEY)
        if rawget(TABLE._schema, KEY) ~= nil then
                return rawget(TABLE._schema, KEY)
        elseif KEY == "_name" then       
            return rawget(TABLE, "_name")
        elseif KEY == "_schema" then
            return rawget(TABLE, "_schema")
        else
            return nil
        end
    end
    
    component_mt.__newindex = function(TABLE, KEY, VALUE)
        return nil
    end
    
    setmetatable(component, component_mt)
    self.components[component._name] = component
    
    return component
end

function ecs:newEntity(NAME, COMPONENTS)
end

function ecs:newRenderSystem(NAME, PRIORITY, CALLBACK)
end

function ecs:newUpdateSystem(NAME, PRIORITY, CALLBACK)
end

function ecs:update(DT)
end

function ecs:draw()
end

function ecs:queryEntities(...)
    
end

return ecs