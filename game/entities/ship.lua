local Ship = Class("Ship", Lecs.Entity)

function Ship:initialize(X,Y,ROT)
    Lecs.Entity.initialize(self)
    
    self:addTag("ship")
    
    self.box2dBody = love.physics.newBody(G_BOX2DWORLD, X, Y, "dynamic")
    
    self.blockList = {}
    
    self.thrustMultiplier = 20
    
    self.renderCanvas = love.graphics.newCanvas()
    
    self.renderCanvasDirty = true
end

function Ship:addShipBlock(BLOCK, XGRIDPOS, YGRIDPOS)
    
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
    
    --table.insert(self.blockGrid[XGRIDPOS][YGRIDPOS], BLOCK)
    table.insert(self.blockList, BLOCK)
end

function Ship:getBlockGridBounds()
    local lowx = 0
    local lowy = 0
    local highx = 0
    local highy = 0
    
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
    
    return lowx, lowy, highx, highy
end

function Ship:computeRenderCanvas()
    local left, top, right, bottom = self:getBlockGridBounds()
    
    local canvaswidth = math.abs(left) + math.abs(right) * G_BLOCKWIDTH
    local canvasheight = math.abs(top) + math.abs(bottom) * G_BLOCKHEIGHT
    
    self.renderCanvas = love.graphics.newCanvas(canvaswidth, canvasheight)
    self.renderCanvasDirty = true
end

function Ship:getBlockGridPixelCoords(TYPE, SHIPGRIDX, SHIPGRIDY, OFFSETX, OFFSETY)
    local shipx, shipy = 0
    if TYPE == "relative" then
        shipx = 0
        shipy = 0
    elseif TYPE == "world" then
        shipx = self.box2dBody:getX()
        shipy = self.box2dBody:getY()
    end
    
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