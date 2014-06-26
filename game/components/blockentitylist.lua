local BlockEntityList = Class("BlockEntityList", Lecs.Component)

function BlockEntityList:initialize()
    Lecs.Component.initialize(self, "blockentitylist")  
    
    self.list = {}
end

function BlockEntityList:addBlock(BLOCK_ENTITY)
    table.insert(self.list, BLOCK_ENTITY)
end

game.components.BlockEntityList = BlockEntityList