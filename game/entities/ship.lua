local Ship = Class("Ship", Lecs.Entity)

function Ship:initialize(X,Y,ROT)
    Lecs.Entity.initialize(self)
    
    self:addTag("ship")
    
    self.box2dBody = love.physics.newBody(G_BOX2DWORLD, X, Y, "dynamic")
    
    self.blockList = {}
end

function Ship:addShipBlock(...)
    local blocks = {...}
    
    for key, value in pairs(blocks) do
        local block = value       
        
        local blockx, blocky = self:getShipGridXYRelative(block.x, block.y)
        
        if block.box2dShapeType == "polygon" then
            -- TODO: Polygon block type
        elseif block.box2dShapeType == "rectangle" then
            block.box2dShape = love.physics.newRectangleShape(
                blockx,
                blocky,
                40, 
                40, 
                self.box2dBody:getAngle() + block.r
            )            
        end
        
        block.box2dFixture = love.physics.newFixture( self.box2dBody, block.box2dShape, 100 )
        
        table.insert(self.blockList, block)
    end
end

function Ship:getShipGridXYWorld(SHIPGRIDX, SHIPGRIDY, OFFSETX, OFFSETY)
    local shipx = self.box2dBody:getX()
    local shipy = self.box2dBody:getY()
    local shipr = self.box2dBody:getAngle()
    
    if OFFSETX == nil then OFFSETX = 0 end
    if OFFSETY == nil then OFFSETY = 0 end
    
    local blockwidth = 40
    local blockheight = 40
    
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
    
    local nx = shipx + ( math.cos(shipr) * (newgridx - shipx) - math.sin(shipr) * (newgridy - shipy) )
    local ny = shipy + ( math.sin(shipr) * (newgridx - shipx) + math.cos(shipr) * (newgridy - shipy) )
    
    return nx, ny
end

function Ship:getShipGridXYRelative(SHIPGRIDX, SHIPGRIDY)
    local shipx = 0
    local shipy = 0
    local shipr = self.box2dBody:getAngle()
    
    
    local blockwidth = 40
    local blockheight = 40
    
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
    
    local nx = shipx + ( math.cos(shipr) * (newgridx - shipx) - math.sin(shipr) * (newgridy - shipy) )
    local ny = shipy + ( math.sin(shipr) * (newgridx - shipx) + math.cos(shipr) * (newgridy - shipy) )
    
    return nx, ny
end

function Ship:thrustAhead()
    local thrust_force = self.box2dBody:getMass() * 10
    local thrust_x = math.cos(self.box2dBody:getAngle())*thrust_force
    local thrust_y = math.sin(self.box2dBody:getAngle())*thrust_force        
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustStern()
    local thrust_force = self.box2dBody:getMass() * 10
    local thrust_x = -1*math.cos(self.box2dBody:getAngle())*thrust_force
    local thrust_y = -1*math.sin(self.box2dBody:getAngle())*thrust_force        
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustPort()
    local thrust_force = self.box2dBody:getMass() * 10
    local deg = math.deg(self.box2dBody:getAngle()) + 90
    local rad = math.rad(deg)
    local thrust_x = -1*math.cos(rad)*(thrust_force)
    local thrust_y = -1*math.sin(rad)*(thrust_force)
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustStarboard()
    local thrust_force = self.box2dBody:getMass() * 10
    local deg = math.deg(self.box2dBody:getAngle()) + 90
    local rad = math.rad(deg)
    local thrust_x = math.cos(rad)*(thrust_force)
    local thrust_y = math.sin(rad)*(thrust_force)   
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustYawLeft()
    local thrust_force = self.box2dBody:getMass() * 10
    self.box2dBody:applyAngularImpulse( -1*thrust_force )    
end

function Ship:thrustYawRight()
    local thrust_force = self.box2dBody:getMass() * 10
    self.box2dBody:applyAngularImpulse( thrust_force )
end

game.entities.Ship = Ship