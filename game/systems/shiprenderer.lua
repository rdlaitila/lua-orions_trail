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
            love.graphics.setCanvas(ships[a].renderCanvas)           
            
            if self.debug then
                local shipcenterx, shipcentery = ships[a].box2dBody:getWorldCenter()
                love.graphics.circle("fill", shipcenterx, shipcentery, 5)        
            end
            
            -- DO BLOCK DRAWS
            local bottomygrid = 0
            for b=1, #ships[a].blockList do
                local block = ships[a].blockList[b]
                
                if block.y > bottomygrid then bottomygrid = block.y end
                
                local spritex, spritey = ships[a]:getShipGridXYWorld(block.x, block.y, -1*G_BLOCKWIDTH/2, -1*G_BLOCKHEIGHT/2)
                love.graphics.draw(                
                    block.sprite, 
                    spritex, 
                    spritey, 
                    ships[a].box2dBody:getAngle(), 
                    G_BLOCKWIDTH/block.sprite:getWidth(), 
                    G_BLOCKHEIGHT/block.sprite:getHeight()
                )
                
                if self.debug then
                    love.graphics.polygon('line', ships[a].box2dBody:getWorldPoints(block.box2dShape:getPoints()) )
                    
                    local pointx, pointy = ships[a]:getShipGridXYWorld(block.x, block.y)
                    love.graphics.circle("fill", pointx, pointy, 10)
                end
            end
            
            ships[a].renderCanvasDirty = false
            love.graphics.setCanvas()           
        else
            love.graphics.rectangle(
                "line", 
                ships[a].box2dBody:getX() - ships[a].renderCanvasLeft,
                ships[a].box2dBody:getY() - ships[a].renderCanvasTop,
                ships[a].renderCanvas:getWidth(),
                ships[a].renderCanvas:getHeight()
            )
            love.graphics.draw(
                ships[a].renderCanvas, 
                ships[a].box2dBody:getX() - ships[a].renderCanvasLeft, 
                ships[a].box2dBody:getY() - ships[a].renderCanvasTop,
                ships[a].box2dBody:getAngle()
            )
        end
    end
    
    G_CAMERA:detach()
end

game.systems.ShipRenderer = ShipRenderer