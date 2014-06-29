local ShipRenderer = Class('ShipRenderer', Lecs.System)

local BLOCK_WIDTH = 40
local BLOCK_HEIGHT = 40

function ShipRenderer:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
end

function ShipRenderer:update(DT)    
end

function ShipRenderer:draw()
    local ships = self._ecsManager:getEntitiesWithTag("ship")
    
    if VIEW == 1 then
        CAMERA.x = ships[1].box2dBody:getX()
        CAMERA.y = ships[1].box2dBody:getY()
        CAMERA.rot = ships[1].box2dBody:getAngle()*-1
    end
    
    for a=1, #ships do
        local shipcenterx, shipcentery = ships[a].box2dBody:getWorldCenter()
        love.graphics.circle("fill", shipcenterx, shipcentery, 5)
        love.graphics.print("Ship Rotation: "..tostring(ships[a].box2dBody:getAngle()), 100, 100)
        
        for b=1, #ships[a].blockList do
            local block = ships[a].blockList[b]
            
            love.graphics.polygon('line', ships[a].box2dBody:getWorldPoints(block.box2dShape:getPoints()) )
        end
    end
end

game.systems.ShipRenderer = ShipRenderer