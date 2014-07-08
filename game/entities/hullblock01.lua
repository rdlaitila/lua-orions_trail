local Hullblock01 = Class("Hullblock01", game.entities.ShipBlock)

function Hullblock01:initialize()
    game.entities.ShipBlock.initialize(self, "HULL_BLOCK")
    
    self:addTag("block")
    
    self.type = BLOCK_TYPE
    
    self.box2dMesh = {
        {0, 0},
        {G_BLOCKWIDTH, 0},
        {G_BLOCKWIDTH, G_BLOCKHEIGHT},
        {0, G_BLOCKHEIGHT}
    }
    
    self.box2dShape = nil
    
    self.box2dFixture = nil
    
    self.box2dFixtureDensity = 500
    
    self.sprite = game.entities.ShipBlock.sprite
end

game.entities.Hullblock01 = Hullblock01