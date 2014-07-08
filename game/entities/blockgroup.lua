local BlockGroup = Class("BlockGroup", Lecs.Entity)

function BlockGroup:initialize(X,Y,ROT)
    Lecs.Entity.initialize(self)
    
    self:addTag("ship")
    
    self.box2dBody = love.physics.newBody(G_BOX2DWORLD, X, Y, "dynamic")
    
    self.blockList = {}
    
    self.thrustMultiplier = 20
    
    self.renderCanvas = love.graphics.newCanvas()
    
    self.renderCanvasDirty = true
end

function BlockGroup:addBlock(BLOCK, XGRIDPOS, YGRIDPOS)    
    local meshPoints = {}
        
    for a=1, #BLOCK.box2dMesh do
        local pointx = BLOCK.box2dMesh[a][1]
        local pointy = BLOCK.box2dMesh[a][2]
        
        --local newx, newy = self:getShipGridXYRelative(XGRIDPOS, YGRIDPOS)
        local newx, newy = self:getBlockGridPixelCoords("relative", XGRIDPOS, YGRIDPOS)
        
        table.insert(meshPoints, newx+pointx)
        table.insert(meshPoints, newy+pointy)
    end
        
    BLOCK.box2dShape = love.physics.newPolygonShape(unpack(meshPoints))         
      
    BLOCK.box2dFixture = love.physics.newFixture( self.box2dBody, BLOCK.box2dShape, BLOCK.box2dFixtureDensity )
    
    BLOCK.blockGridX = XGRIDPOS
    
    BLOCK.blockGridY = YGRIDPOS
    
    table.insert(self.blockList, BLOCK)
end

function BlockGroup:getBlockFromGrid(GRIDX, GRIDY)
    for a=1, #self.blockList do
        if self.blockList[a].blockGridX == GRIDX and self.blockList[a].blockGridY == GRIDY then
            return self.blockList[a]
        end
    end
    
    return nil
end

function BlockGroup:blockGrid2CanvasGrid(GRIDX, GRIDY)
    local left, top, right, bottom, totalwidth, totalheight = self:getBlockGridBounds()
    local canvasgridx = (totalwidth/2 + GRIDX)
    local canvasgridy = (totalheight/2 + GRIDY)
    
    if canvasgridx < 0 then canvasgridx = -1*canvasgridx end
    if canvasgridy < 0 then canvasgridy = -1*canvasgridy end
    
    return canvasgridx-1, canvasgridy-1
end

function BlockGroup:getBlockGridBounds()
    local lowx = 0
    local lowy = 0
    local highx = 0
    local highy = 0
    local totalwidth = 0
    local totalheight = 0
    
    for index, value in pairs(self.blockList) do
        if value.blockGridX < lowx then 
            lowx = value.blockGridX 
        elseif value.blockGridX > highx then
            highx = value.blockGridX
        elseif value.blockGridY < lowy then
            lowy = value.blockGridY
        elseif value.blockGridY > highy then
            highy = value.blockGridY
        end
    end
    
    for a=lowx, highx do totalwidth = totalwidth + 1 end
    for a=lowy, highy do totalheight = totalheight + 1 end
    
    return lowx, lowy, highx, highy, totalwidth, totalheight
end

function BlockGroup:computeRenderCanvas()
    local left, top, right, bottom = self:getBlockGridBounds()
    
    local totalwidth = 0
    local totalheight = 0
    
    for a=left, right do totalwidth = totalwidth + 1 end
    for a=top, bottom do totalheight = totalheight + 1 end
    
    local canvaswidth = (totalwidth * G_BLOCKWIDTH)
    local canvasheight = (totalheight * G_BLOCKHEIGHT)
    
    self.renderCanvas = love.graphics.newCanvas(canvaswidth, canvasheight)
    self.renderCanvasDirty = true
end

function BlockGroup:getBlockGridPixelCoords(TYPE, GRIDX, GRIDY, OFFSETX, OFFSETY, APPLY_ROTATION)
    local gridx, gridy = 0
    local gridr = self.box2dBody:getAngle()
    
    if TYPE == "relative" then
        gridx = 0
        gridy = 0
    elseif TYPE == "world" then
        gridx = self.box2dBody:getX()
        gridy = self.box2dBody:getY()
    end
    
    if OFFSETX == nil then OFFSETX = 0 end
    if OFFSETY == nil then OFFSETY = 0 end
    
    local blockwidth = G_BLOCKWIDTH
    local blockheight = G_BLOCKHEIGHT
    
    local newgridx = 0
    if GRIDX == 0 then
        newgridx = gridx + OFFSETX
    else
        newgridx = gridx + (blockwidth*GRIDX) + OFFSETX
    end
    
    local newgridy = 0
    if GRIDY == 0 then
        newgridy = gridy + OFFSETY
    else
        newgridy = gridy + (blockheight*GRIDY) + OFFSETY
    end 
    
    if APPLY_ROTATION == true then
        local nx = gridx + ( math.cos(gridr) * (newgridx - gridx) - math.sin(gridr) * (newgridy - gridy) )
        local ny = gridy + ( math.sin(gridr) * (newgridx - gridx) + math.cos(gridr) * (newgridy - gridy) )    
        return nx, ny
    else
        return newgridx, newgridy
    end    
end

function BlockGroup:thrustAhead()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local thrust_x = math.cos(self.box2dBody:getAngle())*thrust_force
    local thrust_y = math.sin(self.box2dBody:getAngle())*thrust_force        
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function BlockGroup:thrustStern()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local thrust_x = -1*math.cos(self.box2dBody:getAngle())*thrust_force
    local thrust_y = -1*math.sin(self.box2dBody:getAngle())*thrust_force        
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function BlockGroup:thrustPort()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local deg = math.deg(self.box2dBody:getAngle()) + 90
    local rad = math.rad(deg)
    local thrust_x = -1*math.cos(rad)*(thrust_force)
    local thrust_y = -1*math.sin(rad)*(thrust_force)
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function BlockGroup:thrustStarboard()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local deg = math.deg(self.box2dBody:getAngle()) + 90
    local rad = math.rad(deg)
    local thrust_x = math.cos(rad)*(thrust_force)
    local thrust_y = math.sin(rad)*(thrust_force)   
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function BlockGroup:thrustYawLeft()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    self.box2dBody:applyAngularImpulse( -1*(thrust_force*4) )    
end

function BlockGroup:thrustYawRight()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    self.box2dBody:applyAngularImpulse( (thrust_force*4) )
end

game.entities.BlockGroup = BlockGroup