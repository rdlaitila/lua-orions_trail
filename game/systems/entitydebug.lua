local EntityDebug = Class('EntityDebug', Lecs.System)

function EntityDebug:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
    
    self.debugEnabled = true
end

function EntityDebug:update(DT)
end

function EntityDebug:draw()        
    local liney = 0
    for a=1, #self._ecsManager._entities do
        local entity = self._ecsManager._entities[a]
        love.graphics.print("Entity: " .. tostring(entity), 0, liney)
        liney = liney + 15
        for b=1, #entity._components do
            love.graphics.print("Component: " .. tostring(entity._components[b]), 15, liney)
            liney = liney + 15
        end
    end
end

game.systems.EntityDebug = EntityDebug