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

game.entities.Ship = Ship