local Coresystem = Class('Coresystem', Lecs.System)

function Coresystem:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
end

function Coresystem:update(DT)    
end

function Coresystem:draw()        
end

game.systems.Coresystem = Coresystem