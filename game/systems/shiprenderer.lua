local ShipRenderer = Class('ShipRenderer', Lecs.System)

function ShipRenderer:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
end

function ShipRenderer:update(DT)    
end

function ShipRenderer:draw()
    local ships = self._ecsManager:getEntitiesWithTag("ship")
    
    for a=1, #ships do
        
    end
end

game.systems.ShipRenderer = ShipRenderer