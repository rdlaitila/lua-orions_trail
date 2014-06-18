local Position = Class("Position", Lecs.Component)

function Position:initialize(XPOS, YPOS, RPOS)
    Lecs.Component:initialize("position", {
        x=XPOS or 0, 
        y=YPOS or 0,
        r=RPOS or 0
    })   
end

game.components.Position = Position