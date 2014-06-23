local Shipsystem = Class('Shipsystem', Lecs.System)

function Shipsystem:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
end

function Shipsystem:update(DT)
    --print("Ship System Update:" .. tostring(DT))
end

function Shipsystem:draw()    
    --print("Ship System Draw")   
    
    
    for a=1, #self._ecsManager._entities do
        love.graphics.print(
            "Entity: "..tostring(self._ecsManager._entities[a]) .. " with tags: " .. table.tostring(self._ecsManager._entities[a]._tags), 
            0, 
            15*a
        )
    end
    
    love.graphics.print("#entities: " .. tostring(#self._ecsManager._entities), 0, 0)
    
    
end

game.systems.Shipsystem = Shipsystem