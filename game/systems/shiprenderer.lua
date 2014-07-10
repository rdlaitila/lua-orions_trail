local ShipRenderer = Class("ShipRenderer", Lecs.System)

function ShipRenderer:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
end

function ShipRenderer:update(DT)
end

function ShipRenderer:draw()
    local ships = G_ECSMANAGER:getEntitiesWithTag("ship")
    
    G_CAMERA:attach()
    
    for a=1, #ships do
        local bounds = {ships[a]:getBlockGridBounds()}
        
        if ships[a].isThrustingAhead then
            local thrusterx, thrustery = ships[a]:getBlockGridPixelCoords("world", bounds[1], 0, -1*G_BLOCKWIDTH, 0, true)
            love.graphics.circle('fill', thrusterx, thrustery, 4)
        end
        if ships[a].isThrustingStern then
            local thrusterx, thrustery = ships[a]:getBlockGridPixelCoords("world", bounds[3], 0, G_BLOCKWIDTH, 0, true)
            love.graphics.circle('fill', thrusterx, thrustery, 4)
        end
        if ships[a].isThrustingPort then
            local thrusterx, thrustery = ships[a]:getBlockGridPixelCoords("world", 0, bounds[4], 0, G_BLOCKHEIGHT, true)
            love.graphics.circle('fill', thrusterx, thrustery, 4)
        end
        if ships[a].isThrustingStarboard then
            local thrusterx, thrustery = ships[a]:getBlockGridPixelCoords("world", 0, bounds[2], 0, -1*G_BLOCKHEIGHT, true)
            love.graphics.circle('fill', thrusterx, thrustery, 4)
        end
        
        
        local labelx, labely = ships[a]:getBlockGridPixelCoords("world", 0, bounds[3], 0, G_BLOCKHEIGHT, false)
        love.graphics.print("ship"..a, labelx, labely)
    end
    
    G_CAMERA:detach()
end

game.systems.ShipRenderer = ShipRenderer