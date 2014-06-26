local Shiptest3 = {}

function Shiptest3:enter()
    require('game.components.position')
    require('game.components.blockentitylist')
    require('game.components.blocktype')
    require('game.components.blockgridposition')
    require('game.components.blocksprite')
    require('game.entities.box2dworld')
    require('game.entities.ship')
    require('game.entities.block')
    require('game.systems.coresystem')
    require('game.systems.entitydebug')
    
    self.ecsManager = Lecs.Manager:new()
    
    self.ecsManager:addEntity(
        game.entities.Box2dWorld:new(),
        game.entities.Ship:new()
    )
    
    local block1 = game.entities.Block:new(game.components.Blocktype.HULL_BLOCK, 0, 0)
    self.ecsManager:addEntity(block1)
    
    local ship = self.ecsManager:getEntitiesWithTag("ship")[1]
    
    ship:getComponent("blockentitylist"):addBlock(block1)
    
    self.ecsManager:addSystem(
        game.systems.Coresystem:new(0),
        game.systems.EntityDebug:new(0)
    )
end

function Shiptest3:update(DT)
    self.ecsManager:update(DT)
end

function Shiptest3:draw()
    self.ecsManager:draw(DT)
end

game.states.Shiptest3 = Shiptest3