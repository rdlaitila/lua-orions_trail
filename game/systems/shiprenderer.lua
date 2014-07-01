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
        local shipcenterx, shipcentery = ships[a].box2dBody:getWorldCenter()
        love.graphics.circle("fill", shipcenterx, shipcentery, 5)
        love.graphics.print("Ship Rotation: "..tostring(ships[a].box2dBody:getAngle()), 100, 100)
        
        -- DO BLOCK DRAWS
        local bottomygrid = 0
        for b=1, #ships[a].blockList do
            local block = ships[a].blockList[b]
            
            if block.y > bottomygrid then bottomygrid = block.y end
            
            local spritex, spritey = ships[a]:getShipGridXYWorld(block.x, block.y, -20, -20)
            love.graphics.draw(block.sprite, spritex, spritey, ships[a].box2dBody:getAngle(), 40/block.sprite:getWidth(), 40/block.sprite:getHeight())
            
            love.graphics.polygon('line', ships[a].box2dBody:getWorldPoints(block.box2dShape:getPoints()) )
            
            local pointx, pointy = ships[a]:getShipGridXYWorld(block.x, block.y)
            love.graphics.circle("fill", pointx, pointy, 10)
        end
        
        local text1x, text1y = ships[a]:getShipGridXYWorld(0, bottomygrid+1)
        love.graphics.print("R: "..tostring(ships[a].box2dBody:getAngle()), text1x, text1y, ships[a].box2dBody:getAngle())
        local text2x, text2y = ships[a]:getShipGridXYWorld(0, bottomygrid+1, 0, 15)
        love.graphics.print("X: "..tostring(ships[a].box2dBody:getX()), text2x, text2y, ships[a].box2dBody:getAngle())
        local text3x, text3y = ships[a]:getShipGridXYWorld(0, bottomygrid+1, 0, 30)
        love.graphics.print("Y: "..tostring(ships[a].box2dBody:getY()), text3x, text3y, ships[a].box2dBody:getAngle())
        local text4x, text4y = ships[a]:getShipGridXYWorld(0, bottomygrid+1, 0, 45)
        love.graphics.print("M: "..tostring(ships[a].box2dBody:getMass()), text4x, text4y, ships[a].box2dBody:getAngle())
        
        local vx, vy = ships[a].box2dBody:getLinearVelocity()
        
        local text5x, text5y = ships[a]:getShipGridXYWorld(0, bottomygrid+1, 0, 60)
        love.graphics.print("XV: "..tostring(vx), text5x, text5y, ships[a].box2dBody:getAngle())
        local text6x, text6y = ships[a]:getShipGridXYWorld(0, bottomygrid+1, 0, 75)
        love.graphics.print("XY: "..tostring(vy), text6x, text6y, ships[a].box2dBody:getAngle())
    end
end

game.systems.ShipRenderer = ShipRenderer