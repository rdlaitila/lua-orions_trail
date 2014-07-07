local ShipBlock = Class("ShipBlock", Lecs.Entity)

ShipBlock.sprite = love.graphics.newImage("game//assets//blocksprites//hullblock01.png")

function ShipBlock:initialize(BLOCK_TYPE)
    Lecs.Entity.initialize(self)
    
    self:addTag("block")
    
    self.type = BLOCK_TYPE 
    
    self.box2dMesh = {
        {10, 0},
        {30, 0},
        {40, 40},
        {0, 40}
    }
    
    self.box2dShape = nil
    
    self.box2dFixture = nil
    
    self.box2dFixtureDensity = 100
    
    self.sprite = ShipBlock.sprite
    
    self.drawEnabled = false
end

game.entities.ShipBlock = ShipBlock