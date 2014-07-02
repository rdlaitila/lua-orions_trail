local Hullblock01 = Class("Hullblock01", game.entities.ShipBlock)

Hullblock01.sprite = love.graphics.newImage("game//assets//blocksprites/ship_hull_1.jpg")

function Hullblock01:initialize(BLOCK_TYPE, GRIDPOS_X, GRIDPOS_Y, GRIDPOS_R, SHAPE_TYPE)
    Lecs.Entity.initialize(self)
    
    self:addTag("block")
    
    self.type = BLOCK_TYPE
    
    self.x = GRIDPOS_X
    
    self.y = GRIDPOS_Y    
    
    self.box2dMesh = {
        {0, 0},
        {40, 0},
        {40, 40},
        {0, 40}
    }
    
    self.box2dShape = nil
    
    self.box2dFixture = nil
    
    self.box2dFixtureDensity = 100
    
    self.sprite = Hullblock01.sprite
end

game.entities.Hullblock01 = Hullblock01