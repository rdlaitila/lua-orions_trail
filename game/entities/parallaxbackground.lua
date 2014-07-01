local ParallaxBackground = Class("ParallaxBackground", Lecs.Entity)

function ParallaxBackground:initialize()
    Lecs.Entity.initialize(self)
    
    self:addTag("parallax_background")
end

function ParallaxBackground:addLayer(LAYER_COMPONENT)
end

function ParallaxBackground:removeLayer(LAYER_COMPONENT)
end

game.entities.ParallaxBackground = ParallaxBackground