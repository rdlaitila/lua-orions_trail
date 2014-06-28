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
    require('game.systems.shiprenderer')
    
    self.ecsManager = Lecs.Manager:new()
    
    self.ecsManager:addEntity(
        game.entities.Box2dWorld:new(),
        game.entities.Ship:new(500,500,0)
    )
    
    local block1 = game.entities.Block:new(game.components.Blocktype.HULL_BLOCK, 0, 0)
    local block2 = game.entities.Block:new(game.components.Blocktype.HULL_BLOCK, 1, 0)
    local block3 = game.entities.Block:new(game.components.Blocktype.HULL_BLOCK, -1, 0)
    local block4 = game.entities.Block:new(game.components.Blocktype.HULL_BLOCK, 0, -1)
    local block5 = game.entities.Block:new(game.components.Blocktype.HULL_BLOCK, 0, 1)
    local block6 = game.entities.Block:new(game.components.Blocktype.HULL_BLOCK, 1, 1)
    self.ecsManager:addEntity(
        block1,
        block2,
        block3,
        block4,
        block5,
        block6
    )    
    local ship = self.ecsManager:getEntitiesWithTag("ship")[1]    
    ship:getComponent("blockentitylist"):addBlock(block1)
    ship:getComponent("blockentitylist"):addBlock(block2)
    ship:getComponent("blockentitylist"):addBlock(block3)
    ship:getComponent("blockentitylist"):addBlock(block4)
    ship:getComponent("blockentitylist"):addBlock(block5)
    ship:getComponent("blockentitylist"):addBlock(block6)
    
    self.ecsManager:addSystem(
        game.systems.Coresystem:new(0),
        game.systems.EntityDebug:new(0),
        game.systems.ShipRenderer:new(0)
    )
end

function Shiptest3:update(DT)
    self.ecsManager:update(DT)
    
    if love.keyboard.isDown("left") then
        local pos = self.ecsManager:getEntitiesWithTag("ship")[1]:getComponent("position")
        pos.x = pos.x - 100*DT        
    end
    if love.keyboard.isDown("right") then
        local pos = self.ecsManager:getEntitiesWithTag("ship")[1]:getComponent("position")
        pos.x = pos.x + 100*DT
    end
    if love.keyboard.isDown("up") then
        local pos = self.ecsManager:getEntitiesWithTag("ship")[1]:getComponent("position")
        pos.y = pos.y - 100*DT 
    end
    if love.keyboard.isDown("down") then
        local pos = self.ecsManager:getEntitiesWithTag("ship")[1]:getComponent("position")
        pos.y = pos.y + 100*DT 
    end
end

function Shiptest3:draw()
    self.ecsManager:draw(DT)
end

game.states.Shiptest3 = Shiptest3