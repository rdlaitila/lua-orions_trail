local Block = class("Block", lecs.Entity)

Block.sprite = love.graphics.newImage("game//assets//blocksprites//hullblock01.png")

function Block:initialize()
    lecs.Entity.initialize(self)
    
    self:addTag("block")
    
    local halfblockwidth = G_BLOCKWIDTH/2
    local halfblockheight = G_BLOCKHEIGHT/2
    
    self.box2dMesh = {
        {-halfblockwidth, -halfblockheight},
        {halfblockwidth, -halfblockheight},
        {halfblockwidth, halfblockheight},
        {-halfblockwidth, halfblockheight}
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