local ShipRenderer = Class("ShipRenderer", Lecs.System)

function ShipRenderer:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
end

function ShipRenderer:update(DT)
end

function ShipRenderer:draw()
    local ships = G_ECSMANAGER:getEntitiesWithTag("ship")
    
    for a=1, #ships do
        local bounds = {ships[a]:getBlockGridBounds()}
        local labelx, labely = ships[a]:getBlockGridPixelCoords("world", 0, bounds[3], 0, G_BLOCKHEIGHT, false)
        love.graphics.print("ship"..a, labelx, labely)
    end
end

game.systems.ShipRenderer = ShipRenderer