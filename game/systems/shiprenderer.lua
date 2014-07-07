local ShipRenderer = Class('ShipRenderer', Lecs.System)

function ShipRenderer:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
    
    self.debug = true
end

function ShipRenderer:update(DT) 
    local ships = self._ecsManager:getEntitiesWithTag("ship")
end

function ShipRenderer:draw()   
    G_CAMERA:attach()    
    
    local ships = self._ecsManager:getEntitiesWithTag("ship")
    
    if G_VIEW == 1 then
        G_CAMERA.x = ships[1].box2dBody:getX()
        G_CAMERA.y = ships[1].box2dBody:getY()
        G_CAMERA.rot = ships[1].box2dBody:getAngle()*-1
    elseif G_VIEW == 2 then
        G_CAMERA.x = ships[1].box2dBody:getX()
        G_CAMERA.y = ships[1].box2dBody:getY()
        G_CAMERA.rot = math.rad(math.deg(ships[1].box2dBody:getAngle()*-1) - 90)
    end
    
    for a=1, #ships do
        if ships[a].renderCanvasDirty then            
            ships[a].renderCanvasDirty = false
        else
            local bounds = {ships[a]:getBlockGridBounds()}
            local canvasx, canvasy = ships[a]:getBlockGridPixelCoords("world", bounds[1], bounds[2], -1*G_BLOCKWIDTH/2, -1*G_BLOCKHEIGHT/2)
            love.graphics.rectangle(
                "line", 
                canvasx,
                canvasy,
                math.abs(bounds[1]) + math.abs(bounds[3]) * G_BLOCKWIDTH,
                math.abs(bounds[2]) + math.abs(bounds[4]) * G_BLOCKHEIGHT
            )
        end
    end
    
    G_CAMERA:detach()
end

game.systems.ShipRenderer = ShipRenderer