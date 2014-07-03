local Ship = Class("Ship", Lecs.Entity)

function Ship:initialize(X,Y,ROT)
    Lecs.Entity.initialize(self)
    
    self:addTag("ship")
    
    self.box2dBody = love.physics.newBody(G_BOX2DWORLD, X, Y, "dynamic")
    
    self.blockList = {}
    
    self.thrustMultiplier = 20
    
    self.renderCanvas = love.graphics.newCanvas(10000, 10000)
    
    self.renderCanvasDirty = true
end

function Ship:addShipBlock(...)
    local blocks = {...}
    
    for index in pairs(blocks) do  
        local block = blocks[index]
        
        local meshPoints = {}
        
        for a=1, #block.box2dMesh do
            local pointx = block.box2dMesh[a][1] - (G_BLOCKWIDTH/2)
            local pointy = block.box2dMesh[a][2] - (G_BLOCKHEIGHT/2)
            
            local newx, newy = self:getShipGridXYRelative(block.x, block.y)
            
            table.insert(meshPoints, newx+pointx)
            table.insert(meshPoints, newy+pointy)
        end
        
        block.box2dShape = love.physics.newPolygonShape(unpack(meshPoints))         
        
        block.box2dFixture = love.physics.newFixture( self.box2dBody, block.box2dShape, block.box2dFixtureDensity )
        
        table.insert(self.blockList, blocks[index])        
    end
end

function Ship:computeRenderCanvas()
    self.renderCanvas = love.graphics.newCanvas(self:getShipGridMaxWidth()*G_BLOCKWIDTH, self:getShipGridMaxHeight()*G_BLOCKHEIGHT)
    self.renderCanvasLeft = self:getShipGridMaxLeft() * G_BLOCKWIDTH
    self.renderCanvasTop = self:getShipGridMaxTop() * G_BLOCKHEIGHT
    self.renderCanvasDirty = true
end

function Ship:getShipGridMaxLeft()
    local left = 0
    for a=1, #self.blockList do
        if self.blockList[a].x < left then
            left = self.blockList[a].x
        end
    end
    return left
end

function Ship:getShipGridMaxRight()
    local right = 0
    for a=1, #self.blockList do
        if self.blockList[a].x > right then
            right = self.blockList[a].x
        end
    end
    return right
end

function Ship:getShipGridMaxTop()
    local top = 0
    for a=1, #self.blockList do
        if self.blockList[a].y < top then
            top = self.blockList[a].y
        end
    end
    return top
end

function Ship:getShipGridMaxBottom()
    local bottom = 0
    for a=1, #self.blockList do
        if self.blockList[a].y > bottom then
            bottom = self.blockList[a].y
        end
    end
    return bottom
end

function Ship:getShipGridMaxWidth()
    local negwidth = 0
    local poswidth = 0
    for a=1, #self.blockList do
        if self.blockList[a].x > poswidth then
            poswidth = self.blockList[a].x
        end
        
        if self.blockList[a].x < negwidth then
            negwidth = self.blockList[a].x
        end
    end
    return poswidth+(-1*negwidth)
end

function Ship:getShipGridMaxHeight()
    local negheight = 0
    local posheight = 0
    for a=1, #self.blockList do
        if self.blockList[a].y < negheight then
            negheight = self.blockList[a].y
        end
        
        if self.blockList[a].y > posheight then
            posheight = self.blockList[a].y
        end
    end
    return posheight+(-1*negheight)
end

function Ship:getShipGridXYWorld(SHIPGRIDX, SHIPGRIDY, OFFSETX, OFFSETY)
    local shipx = self.box2dBody:getX()
    local shipy = self.box2dBody:getY()
    local shipr = self.box2dBody:getAngle()
    
    if OFFSETX == nil then OFFSETX = 0 end
    if OFFSETY == nil then OFFSETY = 0 end
    
    local blockwidth = G_BLOCKWIDTH
    local blockheight = G_BLOCKHEIGHT
    
    local newgridx = 0
    if SHIPGRIDX == 0 then
        newgridx = shipx + OFFSETX
    else
        newgridx = shipx + (blockwidth*SHIPGRIDX) + OFFSETX
    end
    
    local newgridy = 0
    if SHIPGRIDY == 0 then
        newgridy = shipy + OFFSETY
    else
        newgridy = shipy + (blockheight*SHIPGRIDY) + OFFSETY
    end 
    
    return newgridx, newgridy
    
    -- NO LONGER ROTATE BY SHIP ANGLE, AS WE ROTATE THE CANVAS DURING DRAW
    --local nx = shipx + ( math.cos(shipr) * (newgridx - shipx) - math.sin(shipr) * (newgridy - shipy) )
    --local ny = shipy + ( math.sin(shipr) * (newgridx - shipx) + math.cos(shipr) * (newgridy - shipy) )
    
    --return nx, ny
end

function Ship:getShipGridXYRelative(SHIPGRIDX, SHIPGRIDY)
    local shipx = 0
    local shipy = 0
    local shipr = self.box2dBody:getAngle()
    
    
    local blockwidth = G_BLOCKWIDTH
    local blockheight = G_BLOCKHEIGHT
    
    local newgridx = 0
    if SHIPGRIDX == 0 then
        newgridx = shipx
    else
        newgridx = shipx + (blockwidth*SHIPGRIDX)
    end
    
    local newgridy = 0
    if SHIPGRIDY == 0 then
        newgridy = shipy
    else
        newgridy = shipy + (blockheight*SHIPGRIDY) 
    end 
    
    return newgridx, newgridy
    
    -- NO LONGER ROTATE BY SHIP ANGLE, AS WE ROTATE THE CANVAS DURING DRAW
    --local nx = shipx + ( math.cos(shipr) * (newgridx - shipx) - math.sin(shipr) * (newgridy - shipy) )
    --local ny = shipy + ( math.sin(shipr) * (newgridx - shipx) + math.cos(shipr) * (newgridy - shipy) )
    
    --return nx, ny
end

function Ship:thrustAhead()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local thrust_x = math.cos(self.box2dBody:getAngle())*thrust_force
    local thrust_y = math.sin(self.box2dBody:getAngle())*thrust_force        
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustStern()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local thrust_x = -1*math.cos(self.box2dBody:getAngle())*thrust_force
    local thrust_y = -1*math.sin(self.box2dBody:getAngle())*thrust_force        
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustPort()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local deg = math.deg(self.box2dBody:getAngle()) + 90
    local rad = math.rad(deg)
    local thrust_x = -1*math.cos(rad)*(thrust_force)
    local thrust_y = -1*math.sin(rad)*(thrust_force)
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustStarboard()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local deg = math.deg(self.box2dBody:getAngle()) + 90
    local rad = math.rad(deg)
    local thrust_x = math.cos(rad)*(thrust_force)
    local thrust_y = math.sin(rad)*(thrust_force)   
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustYawLeft()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    self.box2dBody:applyAngularImpulse( -1*thrust_force )    
end

function Ship:thrustYawRight()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    self.box2dBody:applyAngularImpulse( thrust_force )
end

game.entities.Ship = Ship