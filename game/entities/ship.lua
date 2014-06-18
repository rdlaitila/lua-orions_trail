local Ship = Class("Ship", Lecs.Entity)

function Ship:initialize(X, Y, R, WIDTH, HEIGHT)
    Lecs.Entity:initialize()
    
    self:addComponent(game.components.Position:new(X or 0, Y or 0, R or 0))
end

game.entities.Ship = Ship