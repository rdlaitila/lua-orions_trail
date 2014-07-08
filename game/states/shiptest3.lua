local Shiptest3 = {}

function Shiptest3:enter()
    require('game.entities.blockgroup')
    require('game.entities.block')    
    require('game.systems.coresystem')
    require('game.systems.camera')
    require('game.systems.entitydebug')
    require('game.systems.shiprenderer')
    require('game.systems.spacebackground')
    
    -- Setup state globals
    G_BOX2DWORLD = love.physics.newWorld(0, 0, true)
    G_ECSMANAGER = Lecs.Manager:new() 
    G_CAMERA = Camera(love.graphics.getWidth()/2,love.graphics.getHeight()/2)
    G_VIEW = 0
    G_BLOCKWIDTH = 65
    G_BLOCKHEIGHT = 65
    G_BLOCKDIAGLENGTH = math.sqrt(math.pow(G_BLOCKWIDTH, 2) + math.pow(G_BLOCKHEIGHT,2))
    
    local ship = game.entities.BlockGroup:new(100, 100, 0)    
    ship:addBlock(game.entities.Block:new(), 0, 0)    
    ship:addBlock(game.entities.Block:new(), -1, 0)
    ship:addBlock(game.entities.Block:new(), 1, 0)
    ship:addBlock(game.entities.Block:new(), 0, 1)
    ship:addBlock(game.entities.Block:new(), 0, -1)
    ship:computeRenderCanvas()
    G_ECSMANAGER:addEntity(ship)
    
    ship = game.entities.BlockGroup:new(500, 500, 0)    
    ship:addBlock(game.entities.Block:new(), 0, 0)
    ship:computeRenderCanvas()
    G_ECSMANAGER:addEntity(ship)
    
    G_ECSMANAGER:addSystem(        
        game.systems.SpaceBackground:new(0),
        game.systems.ShipRenderer:new(1),
        game.systems.CameraSystem:new(2)
    )
end

function Shiptest3:update(DT)    
    G_BOX2DWORLD:update(DT)
    G_ECSMANAGER:update(DT)
    
    local ship = G_ECSMANAGER:getEntitiesWithTag("ship")[1]
    
    if love.keyboard.isDown('q') then
        ship:thrustYawLeft()
    end
    
    if love.keyboard.isDown('e') then
        ship:thrustYawRight()
    end
    
    if love.keyboard.isDown("w") then        
        ship:thrustAhead()
    end
    
    if love.keyboard.isDown("s") then
       ship:thrustStern()
    end
    
    if love.keyboard.isDown("a") then
       ship:thrustPort() 
    end
    
    if love.keyboard.isDown("d") then
       ship:thrustStarboard()
    end
end

function Shiptest3:draw()        
    G_ECSMANAGER:draw()    
end

function Shiptest3:mousepressed(X, Y, MB)
    G_ECSMANAGER:mousepressed(X, Y, MB)
end

function Shiptest3:keypressed(KEY, ISREPEAT)
    G_ECSMANAGER:keypressed(KEY, ISREPEAT)
    if KEY == "v" then
        if G_VIEW == 0 then
            G_VIEW = 1
        elseif G_VIEW == 1 then
            G_VIEW = 2            
        elseif G_VIEW == 2 then
            G_VIEW = 0
            G_CAMERA.rot = 0
        end
    end
end

game.states.Shiptest3 = Shiptest3