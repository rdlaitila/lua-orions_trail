local Box2dPolygonShape = Class("Box2dPolygonShape", Lecs.Component)

function Box2dPolygonShape:initialize(...)
    local points = ...
    Lecs.Component.initialize(self, "box2dpolygonshape") 

    self.shape = love.physics.newPolygonShape(points)
end

game.components.Box2dPolygonShape = Box2dPolygonShape