local Box2dFixture = Class("Box2dFixture", Lecs.Component)

function Box2dFixture:initialize(BODY, SHAPE, DENSITY)
    Lecs.Component.initialize(self, "position") 

    self.fixture = love.physics.newFixture(BODY, SHAPE, DENSITY)
end

game.components.Box2dFixture = Box2dFixture