local Shipbuilder = {}

local background = {}
background.image = love.graphics.newImage("game//assets//backgrounds//nebula03.png")
background.renderX = 0
background.renderY = 0

function Shipbuilder:enter()
    require('game.entities.block')
    require('game.entities.blockgroup')
    require('game.entities.ship')
    
    G_BOX2DWORLD = love.physics.newWorld(0, 0, true)
    G_ECSMANAGER = lecs.Manager:new()
    G_CAMERA = hump.Camera(love.graphics.getWidth()/2,love.graphics.getHeight()/2)
    G_VIEW = 0
    G_BLOCKWIDTH = 65
    G_BLOCKHEIGHT = 65
    G_BLOCKDIAGLENGTH = math.sqrt(math.pow(G_BLOCKWIDTH, 2) + math.pow(G_BLOCKHEIGHT,2))
    G_MAXBLOCKSTEPX = 50
    G_MAXBLOCKSTEPY = 50
    
    local ship = game.entities.Ship:new(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
    G_ECSMANAGER:addEntity(ship)    
end

function Shipbuilder:update(dt)    
    if love.keyboard.isDown("down") then 
        G_CAMERA.y = G_CAMERA.y + 10 * G_CAMERA.scale
        background.renderY = background.renderY - .1
    end
    if love.keyboard.isDown("up") then 
        G_CAMERA.y = G_CAMERA.y - 10 * G_CAMERA.scale
        background.renderY = background.renderY + .1
    end
    if love.keyboard.isDown("right") then 
        G_CAMERA.x = G_CAMERA.x + 10 * G_CAMERA.scale
        background.renderX = background.renderX - .1
    end
    if love.keyboard.isDown("left") then 
        G_CAMERA.x = G_CAMERA.x - 10 * G_CAMERA.scale
        background.renderX = background.renderX + .1
    end
    
    if love.keyboard.isDown("=") then 
        G_CAMERA.scale = G_CAMERA.scale + .3 
    end
    if love.keyboard.isDown("-") then 
        G_CAMERA.scale = G_CAMERA.scale - .3 
    end
end

function Shipbuilder:draw()
    local ships = G_ECSMANAGER:getEntitiesWithTag('ship')
    love.graphics.draw( background.image, background.renderX, background.renderY)    
    
    local stepsx = love.graphics.getWidth() / G_BLOCKWIDTH * G_CAMERA.scale
    local stepsy = love.graphics.getHeight() / G_BLOCKHEIGHT * G_CAMERA.scale
    local lwidth = love.graphics.getWidth()
    local lheight = love.graphics.getHeight()
    local halfwinheight = love.window.getHeight() / 2
    local halfwinwidth = love.window.getWidth() / 2
    
    G_CAMERA:attach()        
    
    love.graphics.setColor(220, 220, 220)
    
    local meangridx = math.floor(G_MAXBLOCKSTEPX / 2)
    local meangridy = math.floor(G_MAXBLOCKSTEPY / 2)
    local halfblockwidth = G_BLOCKWIDTH / 2
    local halfblockheight = G_BLOCKHEIGHT /2    
    for a=-meangridx, meangridx do 
        for b=-meangridy, meangridy do            
            local x, y = ships[1]:getBlockGridPixelCoords("world", a, b)
            love.graphics.circle("line", x, y, 5)
        end        
    end
    
    x,y = G_CAMERA:worldCoords(love.mouse.getPosition())
    
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill", x, y, G_BLOCKWIDTH, G_BLOCKHEIGHT)
    
    love.graphics.circle("fill", love.graphics.getWidth()/2, love.graphics.getHeight()/2, 5)
    
    G_CAMERA:detach()
    
    --[[
    -- PRINT TOP MENU
    --]]    
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 100)
end

function Shipbuilder:keypressed(KEY, ISREPEAT)
    if KEY == "escape" then
        hump.Gamestate.switch(game.states.Mainmenu)
    end
end

function Shipbuilder:mousepressed( x, y, mb )
   if mb == "wu" then
      G_CAMERA.scale = G_CAMERA.scale - 0.2      
   end

   if mb == "wd" then
      G_CAMERA.scale = G_CAMERA.scale + 0.2
   end
end

game.states.Shipbuilder = Shipbuilder