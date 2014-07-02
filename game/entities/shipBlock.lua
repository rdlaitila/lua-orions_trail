local ShipBlock = Class("ShipBlock", Lecs.Entity)

ShipBlock.sprite = love.graphics.newImage("game//assets//blocksprites/ship_hull_1.jpg")

function ShipBlock:initialize(BLOCK_TYPE, GRIDPOS_X, GRIDPOS_Y, GRIDPOS_R, SHAPE_TYPE)
    Lecs.Entity.initialize(self)
    
    self:addTag("block")
    
    self.type = BLOCK_TYPE
    
    self.x = GRIDPOS_X
    
    self.y = GRIDPOS_Y    
    
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
end

game.entities.ShipBlock = ShipBlock