local SpaceBackground = class('SpaceBackground', lecs.System)

SpaceBackground.sprite = love.graphics.newImage("game//assets//backgrounds//nebula01.png")

function SpaceBackground:initialize(PRIORITY)
    lecs.System.initialize(self, PRIORITY)
end

function SpaceBackground:update(DT)
end

function SpaceBackground:draw() 
    G_CAMERA:attach() 
    G_CAMERA:detach()
    
    love.graphics.draw(SpaceBackground.sprite, 0, 0)
end

game.systems.SpaceBackground = SpaceBackground