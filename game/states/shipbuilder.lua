local Shipbuilder = {}

local ecsManager = lecs.Manager:new()

local GRID_STEPX = 40
local GRID_STEPY = 40

local camera = nil

local background = {}
background.image = love.graphics.newImage("game//assets//backgrounds//nebula03.png")
background.renderX = 0
background.renderY = 0

function Shipbuilder:enter()
    require('game.entities.ship')
    camera = Camera(love.graphics.getWidth()/2,love.graphics.getHeight()/2)
    
    local ship = game.entities.Ship:new()

    ecsManager:addEntity(ship)
    
end

function Shipbuilder:update(dt)    
    if love.keyboard.isDown("down") then 
        camera.y = camera.y + 3 
        background.renderY = background.renderY - .1
    end
    if love.keyboard.isDown("up") then 
        camera.y = camera.y - 3 
        background.renderY = background.renderY + .1
    end
    if love.keyboard.isDown("right") then 
        camera.x = camera.x + 3 
        background.renderX = background.renderX - .1
    end
    if love.keyboard.isDown("left") then 
        camera.x = camera.x - 3 
        background.renderX = background.renderX + .1
    end
    
    if love.keyboard.isDown("=") then 
        camera.scale = camera.scale + .3 
    end
    if love.keyboard.isDown("-") then 
        camera.scale = camera.scale - .3 
    end
end

function Shipbuilder:draw()
    love.graphics.draw( background.image, background.renderX, background.renderY)
    
    
    local stepsx = love.graphics.getWidth() / GRID_STEPX * camera.scale
    local stepsy = love.graphics.getHeight() / GRID_STEPY * camera.scale
    local lwidth = love.graphics.getWidth()
    local lheight = love.graphics.getHeight()
    local halfwinheight = love.window.getHeight() / 2
    local halfwinwidth = love.window.getWidth() / 2
    
    camera:attach()        
    
    love.graphics.setColor(220, 220, 220)
    
    for a=(0-halfwinwidth), (stepsx+halfwinwidth) do
        local stepx = a*GRID_STEPX
        love.graphics.line(stepx, camera.y - halfwinheight*(camera.scale * 100), stepx, camera.y+halfwinheight*(camera.scale * 100))        
    end
    
    for a=(0-halfwinheight), (stepsy+halfwinheight) do
        local stepy = a*GRID_STEPY
        love.graphics.line(camera.x-halfwinwidth*(camera.scale * 100), stepy , camera.x+halfwinwidth*(camera.scale * 100), stepy)
    end
    
    x,y = camera:worldCoords(love.mouse.getPosition())
    
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill", x, y, GRID_STEPX, GRID_STEPY)
    
    love.graphics.circle("fill", love.graphics.getWidth()/2, love.graphics.getHeight()/2, 5)
    
    camera:detach()
    
    love.graphics.print(tostring(camera.scale, 0, 0))
end

function Shipbuilder:keypressed(KEY, ISREPEAT)
    if KEY == "escape" then
        Gamestate.switch(game.states.Mainmenu)
    end
end

function Shipbuilder:mousepressed( x, y, mb )
   if mb == "wu" then
      camera.scale = camera.scale - 0.2
      
   end

   if mb == "wd" then
      camera.scale = camera.scale + 0.2
   end
end

game.states.Shipbuilder = Shipbuilder