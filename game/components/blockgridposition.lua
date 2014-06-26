local BlockGridPosition = Class("BlockGridPosition", Lecs.Component)

function BlockGridPosition:initialize(XPOS, YPOS)
    Lecs.Component.initialize(self, "blockgridposition") 
    
    self.x = XPOS or 0
    self.y = YPOS or 0    
end

game.components.BlockGridPosition = BlockGridPosition