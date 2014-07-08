local Block = Class("Block", Lecs.Entity)

Block.sprite = love.graphics.newImage("game//assets//blocksprites//hullblock01.png")

function Block:initialize()
    Lecs.Entity.initialize(self)
    
    self:addTag("block")
    
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
    
    self.sprite = Block.sprite
    
    self.drawEnabled = false
end

game.entities.Block = Block