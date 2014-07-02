local ShipBlock = Class("ShipBlock", Lecs.Entity)

ShipBlock.tileSetImage = love.graphics.newImage("game//assets//blocksprites//blockgroup01.png")
ShipBlock.tileSetBatch = love.graphics.newSpriteBatch(ShipBlock.tileSetImage, 65 * 65)
ShipBlock.tileSetQuads = {}

for a=1, 16 do
    for b=1, 16 do        
        local quad = love.graphics.newQuad( a*65, b*65, 65, 65, 65, 65)
        table.insert(ShipBlock.tileSetQuads, {quad} )
    end
end

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
    
    self.sprite = ShipBlock.tileSetQuads[1][1]
end

game.entities.ShipBlock = ShipBlock