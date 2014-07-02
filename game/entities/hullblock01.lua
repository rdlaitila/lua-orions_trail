local Hullblock01 = Class("Hullblock01", game.entities.ShipBlock)

function Hullblock01:initialize(BLOCK_TYPE, GRIDPOS_X, GRIDPOS_Y, GRIDPOS_R, SHAPE_TYPE)
    game.entities.ShipBlock.initialize(self, BLOCK_TYPE, GRIDPOS_X, GRIDPOS_Y, GRIDPOS_R, SHAPE_TYPE)
    
    self:addTag("block")
    
    self.type = BLOCK_TYPE
    
    self.x = GRIDPOS_X
    
    self.y = GRIDPOS_Y    
    
    self.box2dMesh = {
        {0, 0},
        {G_BLOCKWIDTH, 0},
        {G_BLOCKWIDTH, G_BLOCKHEIGHT},
        {0, G_BLOCKHEIGHT}
    }
    
    self.box2dShape = nil
    
    self.box2dFixture = nil
    
    self.box2dFixtureDensity = 500
    
    self.sprite = game.entities.ShipBlock.tileSetQuads[1][1]
end

game.entities.Hullblock01 = Hullblock01