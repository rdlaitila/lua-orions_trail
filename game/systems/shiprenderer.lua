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
            
            for b=1, #ships[a].blockList do
                love.graphics.setCanvas(ships[a].renderCanvas)
                
                love.graphics.line(0, 0, ships[a].renderCanvas:getWidth(), ships[a].renderCanvas:getHeight())
                
                local spritepixelx, spritepixely = ships[a]:getBlockGridPixelCoords(
                    "relative", 
                    ships[a].blockList[b].blockGridX,
                    ships[a].blockList[b].blockGridY,
                    -1*G_BLOCKWIDTH/2,
                    -1*G_BLOCKHEIGHT/2
                )
                
                love.graphics.draw(
                    ships[a].blockList[b].sprite, 
                    math.abs(spritepixelx) - G_BLOCKWIDTH/2, 
                    math.abs(spritepixely) - G_BLOCKHEIGHT/2, 
                    0,
                    1,
                    1
                )
            end
            
            ships[a].renderCanvasDirty = false
            love.graphics.setCanvas()
        else           
            local bounds = {ships[a]:getBlockGridBounds()}
            local canvasx, canvasy = ships[a]:getBlockGridPixelCoords("world", bounds[1], bounds[2], -32.5, -32.5, true)
            --[[love.graphics.rectangle(
                "line", 
                canvasx - G_BLOCKWIDTH/2,
                canvasy - G_BLOCKHEIGHT/2,
                ships[a].renderCanvas:getWidth(),
                ships[a].renderCanvas:getHeight()
            )]]
            love.graphics.draw(
                ships[a].renderCanvas, 
                canvasx,
                canvasy,
                ships[a].box2dBody:getAngle()
            )
            
            for b=1, #ships[a].blockList do                
                local blockpixelx, blockpixely = ships[a]:getBlockGridPixelCoords(
                    "world", 
                    ships[a].blockList[b].blockGridX, 
                    ships[a].blockList[b].blockGridY,
                    0,
                    0,
                    true
                )
                
                love.graphics.polygon('line', ships[a].box2dBody:getWorldPoints(ships[a].blockList[b].box2dShape:getPoints()))
                
                love.graphics.circle('line', blockpixelx, blockpixely, 5)
            end
            
            love.graphics.circle('fill', ships[a].box2dBody:getX(), ships[a].box2dBody:getY(), 5)
        end
    end
    
    G_CAMERA:detach()
end

game.systems.ShipRenderer = ShipRenderer