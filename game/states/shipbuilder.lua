game.states.Shipbuilder = {}
local shipbuilder = game.states.Shipbuilder

local GRID_STEPX = 10
local GRID_STEPY = 10

local background = {}
background.image = love.graphics.newImage("game//assets//backgrounds//nebula03.png")
background.renderX = 0
background.renderY = 0

function shipbuilder:enter()
    camera = Camera(love.graphics.getWidth()/2,love.graphics.getHeight()/2)
end

function shipbuilder:update(dt)
    if love.keyboard.isDown("up") then 
        camera.y = camera.y + 3 
        background.renderY = background.renderY + .1
    end
    if love.keyboard.isDown("down") then 
        camera.y = camera.y - 3 
        background.renderY = background.renderY - .1
    end
    if love.keyboard.isDown("left") then 
            camera.x = camera.x + 3 
            background.renderX = background.renderX + .1
    end
    if love.keyboard.isDown("right") then 
            camera.x = camera.x - 3 
            background.renderX = background.renderX - .1
    end
    
    if love.keyboard.isDown("=") then 
        camera.scale = camera.scale + .3 
    end
    if love.keyboard.isDown("-") then 
        camera.scale = camera.scale - .3 
    end
end

function shipbuilder:draw()
    love.graphics.draw( background.image, background.renderX, background.renderY)
    
    camera:attach()    
    
    love.graphics.rectangle("fill", 0, 0, 100, 200)
    
    camera:detach()
end

function shipbuilder:keypressed(KEY, ISREPEAT)
    if KEY == "escape" then
        Gamestate.switch(game.states.Mainmenu)
    end
end