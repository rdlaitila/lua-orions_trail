local ShipRenderer = Class('ShipRenderer', Lecs.System)

local BLOCK_WIDTH = 40
local BLOCK_HEIGHT = 40

function ShipRenderer:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
end

function ShipRenderer:update(DT)    
end

function ShipRenderer:draw()
    local ships = self._ecsManager:getEntitiesWithTag("ship")
    
    for a=1, #ships do
        local shipPosition = ships[a]:getComponent("position")
        local shipBlocks = ships[a]:getComponent("blockentitylist").list
        
        --draw grid centers 10 times in each direction
        
        
        
        
        love.graphics.print(#shipBlocks, 600, 600)
        
        love.graphics.circle("line", shipPosition.x, shipPosition.y, 5)
        
        for b=1, #shipBlocks do
            local blockx = (shipPosition.x) + (BLOCK_WIDTH) * shipBlocks[b]:getComponent("blockgridposition").x
            local blocky = (shipPosition.y) + (BLOCK_HEIGHT) * shipBlocks[b]:getComponent("blockgridposition").y
            love.graphics.rectangle("line", blockx, blocky, BLOCK_WIDTH, BLOCK_HEIGHT)
            love.graphics.print(b, blockx, blocky)
        end
    end
end

game.systems.ShipRenderer = ShipRenderer