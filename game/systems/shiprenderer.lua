local ShipRenderer = Class('ShipRenderer', Lecs.System)

function ShipRenderer:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
    
    self.debug = false
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
             
            for b=1, #ships[a].blockList do
                local canvasgridx, canvasgridy = ships[a]:blockGrid2CanvasGrid(ships[a].blockList[b].blockGridX, ships[a].blockList[b].blockGridY)
                love.graphics.draw(
                    ships[a].blockList[b].sprite, 
                    canvasgridx*G_BLOCKWIDTH, 
                    canvasgridy*G_BLOCKHEIGHT, 
                    0, 
                    1,
                    1,
                    -1*G_BLOCKWIDTH/2,
                    -1*G_BLOCKHEIGHT/2
                )
            end            
            
            for b=1, #ships[a].blockList do
               
                
                if self.debug then
                    love.graphics.line(0, 0, ships[a].renderCanvas:getWidth(), ships[a].renderCanvas:getHeight())                
                    local left, top, right, bottom, totalwidth, totalheight = ships[a]:getBlockGridBounds()                
                    for b=0, totalwidth do
                        for c=0, totalheight do
                            local x = b*G_BLOCKWIDTH
                            local y = c*G_BLOCKHEIGHT
                            love.graphics.print(
                                (x .. ":" .. y),
                                x,
                                y
                            )
                        end
                    end
                end
            end
            
            ships[a].renderCanvasDirty = false
            love.graphics.setCanvas()
        else           
            local bounds = {ships[a]:getBlockGridBounds()}
            local canvasx, canvasy = ships[a]:getBlockGridPixelCoords("world", bounds[1], bounds[2], -1*G_BLOCKWIDTH/2, -1*G_BLOCKHEIGHT/2, true)            
            love.graphics.draw(
                ships[a].renderCanvas, 
                canvasx,
                canvasy,
                ships[a].box2dBody:getAngle()
            )
            
            if self.debug then
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
    end
    
    G_CAMERA:detach()
end

game.systems.ShipRenderer = ShipRenderer