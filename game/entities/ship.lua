local Ship = Class("Ship", Lecs.Entity)

function Ship:initialize()
    Lecs.Entity.initialize(self)
    
    self:addTag("ship")
    
    self.hullBlocks = {}
    self.systemBlocks = {}
    self.interiorBlocks = {}
end

game.entities.Ship = Ship