local Blocktype = Class("Blocktype", Lecs.Component)

Blocktype.NO_BLOCK = 0
Blocktype.HULL_BLOCK = 1
Blocktype.SYSTEM_BLOCK = 2
Blocktype.INTERIOR_BLOCK = 3

function Blocktype:initialize(BLOCK_TYPE)
    Lecs.Component.initialize(self, "blocktype")   

    self.type = BLOCK_TYPE or Blocktype.NO_BLOCK
end

game.components.Blocktype = Blocktype