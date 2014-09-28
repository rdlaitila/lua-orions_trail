local Shiptest3 = {}

function Shiptest3:enter()
    require('game.entities.blockgroup')
    require('game.entities.block')    
    require('game.entities.ship')    
    require('game.systems.camera')
    require('game.systems.blockgrouprenderer')
    require('game.systems.shiprenderer')
    require('game.systems.spacebackground')
    require('game.systems.physicscollisions')
    require('game.systems.starfield')
    
    -- Setup state globals
    G_BOX2DWORLD = love.physics.newWorld(0, 0, true)
    G_ECSMANAGER = lecs.Manager:new() 
    G_CAMERA = hump.Camera(love.graphics.getWidth()/2,love.graphics.getHeight()/2)
    G_VIEW = 0
    G_BLOCKWIDTH = 65
    G_BLOCKHEIGHT = 65
    G_BLOCKDIAGLENGTH = math.sqrt(math.pow(G_BLOCKWIDTH, 2) + math.pow(G_BLOCKHEIGHT,2))
    
    local ship = game.entities.Ship:new(100, 100, 0)    
    --[[ship:addBlock(game.entities.Block:new(), 0, 0)    
    ship:addBlock(game.entities.Block:new(), -1, 0)
    ship:addBlock(game.entities.Block:new(), 1, 0)
    ship:addBlock(game.entities.Block:new(), 0, 1)
    ship:addBlo10(game.entities.Block:new(), 0, -1)]]
    for a=1, 49 do
        for b=1, 49 do
            ship:addBlock(game.entities.Block:new(), a, b)
        end
    end
    
    G_ECSMANAGER:addEntity(ship)
    
    ship = game.entities.Ship:new(500, 500, 0)    
    ship:addBlock(game.entities.Block:new(), 0, 0)    
    G_ECSMANAGER:addEntity(ship)
    
    G_ECSMANAGER:addSystem(        
        game.systems.CameraSystem:new(0),
        game.systems.SpaceBackground:new(0),
        game.systems.Starfield:new(0),
        game.systems.PhysicsCollisions:new(1),
        game.systems.BlockGroupRenderer:new(2),
        game.systems.ShipRenderer:new(2)        
    )
end

function Shiptest3:update(DT)    
    local ship = G_ECSMANAGER:getEntitiesWithTag("ship")[1]
    
    if love.keyboard.isDown('q') then
        ship:thrustYawLeft()
    end
    
    if love.keyboard.isDown('e') then
        ship:thrustYawRight()
    end
    
    if love.keyboard.isDown("w") then        
        ship:thrustAhead()
        ship.isThrustingAhead = true
    else
        ship.isThrustingAhead = false
    end
    
    if love.keyboard.isDown("s") then
       ship:thrustStern()
       ship.isThrustingStern = true
    else
        ship.isThrustingStern = false
    end
    
    if love.keyboard.isDown("a") then
       ship:thrustPort() 
       ship.isThrustingPort = true
    else
        ship.isThrustingPort = false
    end
    
    if love.keyboard.isDown("d") then
       ship:thrustStarboard()
       ship.isThrustingStarboard = true
    else
        ship.isThrustingStarboard = false
    end
    
    G_BOX2DWORLD:update(DT)
    G_ECSMANAGER:update(DT)
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