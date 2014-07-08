local ShipBlock = Class("ShipBlock", Lecs.Entity)

ShipBlock.sprite = love.graphics.newImage("game//assets//blocksprites//hullblock01.png")

function ShipBlock:initialize(BLOCK_TYPE)
    Lecs.Entity.initialize(self)
    
    self:addTag("block")
    
    self.type = BLOCK_TYPE 
    
    self.box2dMesh = {
        {-32.5, -32.5},
        {32.5, -32.5},
        {32.5, 32.5},
        {-32.5, 32.5}
    }
    
    self.blockGridX = 0
    
    self.blockGridY = 0
    
    self.box2dShape = nil
    
    self.box2dFixture = nil
    
    self.box2dFixtureDensity = 100
    
    self.sprite = ShipBlock.sprite
    
    self.drawEnabled = false
end

game.entities.ShipBlock = ShipBlock