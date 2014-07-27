local BlockGroup = class("BlockGroup", lecs.Entity)

function BlockGroup:initialize(X,Y,ROT)
    lecs.Entity.initialize(self)
    
    self:addTag("blockgroup")
    
    self.box2dBody = love.physics.newBody(G_BOX2DWORLD, X, Y, "dynamic")
    
    self.blockList = {}
    
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
    
    local offsetx = 0
    local offsety = 0
    
    if left < 0 then
        offsetx = left*2
    elseif left > 0 then
        offsetx = -1*left
    end
    
    if top < 0 then
        offsety = top*2
    elseif top > 0 then
        offsety = -1*top
    end
        
    local canvasgridx = (GRIDX + offsetx)
    local canvasgridy = (GRIDY + offsety)
    
    return canvasgridx, canvasgridy
end

function BlockGroup:getBlockGridBounds()
    local lowx = nil
    local lowy = nil
    local highx = nil
    local highy = nil
    local totalwidth = 0
    local totalheight = 0
    
    for index, value in pairs(self.blockList) do
        if lowx == nil or highx == nil then
            lowx = value.blockGridX
            highx = value.blockGridX
        end
        if lowy == nil or highy == nil then
            lowy = value.blockGridY
            highy = value.blockGridY
        end        
        
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
    local left, top, right, bottom, width, height = self:getBlockGridBounds()
    
    local canvaswidth = (width * G_BLOCKWIDTH)
    local canvasheight = (height * G_BLOCKHEIGHT)
    
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

game.entities.BlockGroup = BlockGroup