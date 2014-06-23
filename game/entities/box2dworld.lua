local Box2dWorld = Class("Box2dWorld", Lecs.Entity)

function Box2dWorld:initialize(XGRAVITY, YGRAVITY, SLEEP)
    Lecs.Entity.initialize(self)
    
    self:addTag("box2dworld")
end

game.entities.Box2dWorld = Box2dWorld