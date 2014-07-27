local BlockGroupRenderer = class('BlockGroupRenderer', lecs.System)

function BlockGroupRenderer:initialize(PRIORITY)
    lecs.System.initialize(self, PRIORITY)
    
    self.debug = false
end

function BlockGroupRenderer:update(DT)     
end

function BlockGroupRenderer:draw()   
    G_CAMERA:attach()    
    
    local blockgroups = self._ecsManager:getEntitiesWithTag("blockgroup")
    
    if G_VIEW == 1 then
        G_CAMERA.x, G_CAMERA.y = blockgroups[1].box2dBody:getWorldCenter()  
    elseif G_VIEW == 2 then
        G_CAMERA.x, G_CAMERA.y = blockgroups[1].box2dBody:getWorldCenter()
        G_CAMERA.rot = math.rad(math.deg(blockgroups[1].box2dBody:getAngle()*-1) - 90)
    end
    
    for a=1, #blockgroups do
        if blockgroups[a].renderCanvasDirty then  
            love.graphics.setCanvas(blockgroups[a].renderCanvas)
             
            for b=1, #blockgroups[a].blockList do
                local canvasgridx, canvasgridy = blockgroups[a]:blockGrid2CanvasGrid(
                    blockgroups[a].blockList[b].blockGridX, 
                    blockgroups[a].blockList[b].blockGridY
                )
                
                love.graphics.draw(
                    blockgroups[a].blockList[b].sprite, 
                    canvasgridx*G_BLOCKWIDTH, 
                    canvasgridy*G_BLOCKHEIGHT, 
                    0, 
                    G_BLOCKWIDTH/blockgroups[a].blockList[b].sprite:getWidth(),
                    G_BLOCKHEIGHT/blockgroups[a].blockList[b].sprite:getHeight()
                )
            end            
            
            if self.debug then
                for b=1, #blockgroups[a].blockList do                
                    love.graphics.line(0, 0, blockgroups[a].renderCanvas:getWidth(), blockgroups[a].renderCanvas:getHeight())                
                    local left, top, right, bottom, totalwidth, totalheight = blockgroups[a]:getBlockGridBounds()                
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
            
            blockgroups[a].renderCanvasDirty = false
            love.graphics.setCanvas()
        else            
            local bounds = {blockgroups[a]:getBlockGridBounds()}            
            local canvasx, canvasy = blockgroups[a]:getBlockGridPixelCoords(
                "world", 
                bounds[1], 
                bounds[2], 
                -1*G_BLOCKWIDTH/2, 
                -1*G_BLOCKHEIGHT/2, 
                true
            )            
            love.graphics.draw(
                blockgroups[a].renderCanvas, 
                canvasx,
                canvasy,
                blockgroups[a].box2dBody:getAngle()
            )
            
            if self.debug then
                for b=1, #blockgroups[a].blockList do                
                    local blockpixelx, blockpixely = blockgroups[a]:getBlockGridPixelCoords(
                        "world", 
                        blockgroups[a].blockList[b].blockGridX, 
                        blockgroups[a].blockList[b].blockGridY,
                        0,
                        0,
                        true
                    )
                    
                    love.graphics.polygon('line', blockgroups[a].box2dBody:getWorldPoints(blockgroups[a].blockList[b].box2dShape:getPoints()))
                    
                    love.graphics.circle('line', blockpixelx, blockpixely, 5)
                end
                
                love.graphics.circle('fill', blockgroups[a].box2dBody:getX(), blockgroups[a].box2dBody:getY(), 5)
                
                local groupcenterx, groupcentery = blockgroups[a].box2dBody:getWorldCenter()
                love.graphics.circle('fill', groupcenterx, groupcentery, 10)
            end
        end
    end
    
    G_CAMERA:detach()
end

game.systems.BlockGroupRenderer = BlockGroupRenderer