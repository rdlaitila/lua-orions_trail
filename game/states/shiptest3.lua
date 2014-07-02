local Shiptest3 = {}

function Shiptest3:enter()
    require('game.entities.ship')
    require('game.entities.shipblock')
    require('game.entities.hullblock01')
    require('game.systems.coresystem')
    require('game.systems.entitydebug')
    require('game.systems.shiprenderer')
    require('game.systems.spacebackground')
    
    -- Setup state globals
    G_BOX2DWORLD = love.physics.newWorld(0, 0, true)
    G_ECSMANAGER = Lecs.Manager:new() 
    G_CAMERA = Camera(love.graphics.getWidth()/2,love.graphics.getHeight()/2)
    G_VIEW = 0
    
    local ship = game.entities.Ship:new(200, 200, 0)
    ship:addShipBlock(
        game.entities.Hullblock01:new("HULL_BLOCK", 0, 0),
        game.entities.Hullblock01:new("HULL_BLOCK", 1, 0),
        game.entities.Hullblock01:new("HULL_BLOCK", -1, 0),
        game.entities.Hullblock01:new("HULL_BLOCK", 0, 1),
        game.entities.Hullblock01:new("HULL_BLOCK", 0, -1)
    )
    
    local ship2 = game.entities.Ship:new(500, 200, 0)
    ship2:addShipBlock(
        game.entities.ShipBlock:new("HULL_BLOCK", 0, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", 1, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", -1, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", 0, 1),
        game.entities.ShipBlock:new("HULL_BLOCK", 0, -1)
    )
    
    G_ECSMANAGER:addEntity(
        ship,
        ship2
    )
    
    G_ECSMANAGER:addSystem(        
        game.systems.SpaceBackground:new(0),
        game.systems.ShipRenderer:new(1)
    )
end

function Shiptest3:update(DT)
    lovebird.update()
    G_BOX2DWORLD:update(DT)
    G_ECSMANAGER:update(DT)
    
    local THRUST_FORCE = 10000
    
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
    
    if love.keyboard.isDown("down") then 
        G_CAMERA.y = G_CAMERA.y + 3
    end
    if love.keyboard.isDown("up") then 
        G_CAMERA.y = G_CAMERA.y - 3
    end
    if love.keyboard.isDown("right") then 
        G_CAMERA.x = G_CAMERA.x + 3
    end
    if love.keyboard.isDown("left") then 
        G_CAMERA.x = G_CAMERA.x - 3
    end
end

function Shiptest3:draw()
    
    G_CAMERA:attach()
    G_ECSMANAGER:draw(DT)
    G_CAMERA:detach()
end

function Shiptest3:mousepressed( x, y, mb )
   if mb == "wu" then
      G_CAMERA.scale = G_CAMERA.scale - 0.2
      
   end

   if mb == "wd" then
      G_CAMERA.scale = G_CAMERA.scale + 0.2
   end
end

function Shiptest3:keypressed(KEY, ISREPEAT)
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