local ParallaxRenderer = Class('ParallaxRenderer', Lecs.System)

function ParallaxRenderer:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
end

function ParallaxRenderer:update(DT)    
end

function ParallaxRenderer:draw()        
end

game.systems.ParallaxRenderer = ParallaxRenderer