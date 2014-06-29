local ShipBlock = Class("ShipBlock", Lecs.Entity)

function ShipBlock:initialize(BLOCK_TYPE, GRIDPOS_X, GRIDPOS_Y, GRIDPOS_R, SHAPE_TYPE)
    Lecs.Entity.initialize(self)
    
    self:addTag("block")
    
    self.type = BLOCK_TYPE
    
    self.x = GRIDPOS_X
    
    self.y = GRIDPOS_Y    
    
    self.r = 0
    
    self.box2dShapeType = SHAPE_TYPE or "rectangle"
    
    self.box2dShape = nil
    
    self.box2dFixture = nil
    
    self.box2dFixtureDensity = 100
end

game.entities.ShipBlock = ShipBlock