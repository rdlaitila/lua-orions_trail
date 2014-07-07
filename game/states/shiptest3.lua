local Shiptest3 = {}

function Shiptest3:enter()
    require('game.entities.ship')
    require('game.entities.shipblock')
    require('game.entities.hullblock01')
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
    
    local ship = game.entities.Ship:new(200, 200, 0)    
    for a=1, 5 do
        for b=1, 5 do
            ship:addShipBlock(game.entities.Hullblock01:new("HULL_BLOCK"), a, b)
        end
    end
    ship:normalizeBlockGrid()    
    ship:computeRenderCanvas()
    G_ECSMANAGER:addEntity(ship)
    
    --[[ship:addShipBlock(
        game.entities.Hullblock01:new("HULL_BLOCK", 0, 0),
        game.entities.Hullblock01:new("HULL_BLOCK", 1, 0),
        game.entities.Hullblock01:new("HULL_BLOCK", -1, 0),
        game.entities.Hullblock01:new("HULL_BLOCK", 0, 1),
        game.entities.Hullblock01:new("HULL_BLOCK", 0, -1),
        game.entities.Hullblock01:new("HULL_BLOCK", -1, 1),
        game.entities.Hullblock01:new("HULL_BLOCK", -1, -1),
        game.entities.Hullblock01:new("HULL_BLOCK", -2, 1),
        game.entities.Hullblock01:new("HULL_BLOCK", -2, -1)
    )]]
    
    --[[local ship2 = game.entities.Ship:new(500, 200, 0)
    ship2:addShipBlock(
        game.entities.ShipBlock:new("HULL_BLOCK", 0, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", 1, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", -1, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", 0, 1),
        game.entities.ShipBlock:new("HULL_BLOCK", 0, -1)
    )]]
    
    
    
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