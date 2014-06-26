local Position = Class("Position", Lecs.Component)

function Position:initialize(XPOS, YPOS, RPOS)
    Lecs.Component.initialize(self, "position") 

    self.x = XPOS or 0
    self.y = YPOS or 0
    self.r = RPOS or 0
end

game.components.Position = Position