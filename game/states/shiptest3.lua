local Shiptest3 = {}

function Shiptest3:enter()
    require('game.entities.box2dworld')
    require('game.entities.ship')
    require('game.systems.shipsystem')
    
    self.ecsManager = Lecs.Manager:new()
    
    self.ecsManager:addEntity(
        game.entities.Box2dWorld:new(),
        game.entities.Ship:new()
    )
    
    self.ecsManager:addSystem(
        game.systems.Shipsystem:new(0)
    )
end

function Shiptest3:update(DT)
    self.ecsManager:update(DT)
end

function Shiptest3:draw()
    self.ecsManager:draw(DT)
end

game.states.Shiptest3 = Shiptest3