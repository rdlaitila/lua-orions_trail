local Box2dBody = Class("Box2dBody", Lecs.Component)

function Box2dBody:initialize(XPOS, YPOS, TYPE)
    Lecs.Component.initialize(self, "box2dbody") 

    self.body = love.physics.newBody( BOX2DWORLD, XPOS, YPOS, TYPE or "static" )
end

game.components.Box2dBody = Box2dBody