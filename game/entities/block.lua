local Block = Class("Block", Lecs.Entity)

function Block:initialize(BLOCK_TYPE, GRIDPOS_X, GRIDPOS_Y)
    Lecs.Entity.initialize(self)
    
    self:addTag("block")
    
    if BLOCK_TYPE == game.components.Blocktype.NO_BLOCK then
        --TODO: fail code
    elseif BLOCK_TYPE == game.components.Blocktype.HULL_BLOCK then
        self:addComponent(
            game.components.Blocktype:new(BLOCK_TYPE),
            game.components.BlockSprite:new("game//assets//blocksprites//ship_hull_1.jpg")
        )
    elseif BLOCK_TYPE == game.components.Blocktype.SYSTEM_BLOCK then
        self:addComponent(
            game.components.Blocktype:new(BLOCK_TYPE),
            game.components.BlockSprite:new("assetfile")
        )
    elseif BLOCK_TYPE == game.components.Blocktype.INTERIOR_BLOCK then
        self:addComponent(
            game.components.Blocktype:new(BLOCK_TYPE),
            game.components.BlockSprite:new("assetfile")
        )
    end
    
    self:addComponent(
        game.components.BlockGridPosition:new(GRIDPOS_X, GRIDPOS_Y)
    )
end

game.entities.Block = Block