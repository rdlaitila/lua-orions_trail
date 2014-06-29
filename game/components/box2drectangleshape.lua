local Box2dRectangleShape = Class("Box2dRectangleShape", Lecs.Component)

function Box2dRectangleShape:initialize(X, Y, WIDTH, HEIGHT)
    local points = ...
    Lecs.Component.initialize(self, "box2dpolygonshape") 

    self.shape = love.physics.newRectanglePoint(points)
end

game.components.Box2dRectangleShape = Box2dRectangleShape