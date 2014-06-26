local BlockSprite = Class("BlockSprite", Lecs.Component)

function BlockSprite:initialize(ASSET_FILE)
    Lecs.Component.initialize(self, "sprite") 

    self.spriteImage = love.graphics.newImage(ASSET_FILE)
end

game.components.BlockSprite = BlockSprite