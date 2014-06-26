local Sprite = Class("Sprite", Lecs.Component)

function Sprite:initialize(ASSET_FILE)
    Lecs.Component.initialize(self, "sprite") 

    self.spriteImage = love.graphics.newImage(ASSET_FILE)
end

game.components.Sprite = Sprite