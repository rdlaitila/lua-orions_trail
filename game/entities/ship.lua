local Ship = Class("Ship", Lecs.Entity)

function Ship:initialize(X,Y,ROT)
    Lecs.Entity.initialize(self)
    
    self:addTag("ship")
    
    self:addComponent(
        game.components.Position:new(
            X or 0,
            Y or 0,
            ROT or 0
        ),
        game.components.BlockEntityList:new()        
    )
end

game.entities.Ship = Ship