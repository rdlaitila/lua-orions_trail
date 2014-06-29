local Shiptest3 = {}

function Shiptest3:enter()
    require('game.components.position')
    require('game.components.box2dbody')
    require('game.components.blockentitylist')
    require('game.components.blocktype')
    require('game.components.blockgridposition')
    require('game.components.blocksprite')
    require('game.entities.ship')
    require('game.entities.shipblock')
    require('game.systems.coresystem')
    require('game.systems.entitydebug')
    require('game.systems.shiprenderer')
    
    -- Setup state globals
    BOX2DWORLD = love.physics.newWorld(0, 0, true)
    ECSMANAGER = Lecs.Manager:new() 
    CAMERA = Camera(love.graphics.getWidth()/2,love.graphics.getHeight()/2)
    VIEW = 0
    
    local ship = game.entities.Ship:new(200, 200, 0)
    ship:addShipBlock(
        game.entities.ShipBlock:new("HULL_BLOCK", 0, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", 1, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", -1, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", 0, 1),
        game.entities.ShipBlock:new("HULL_BLOCK", 0, -1),
        game.entities.ShipBlock:new("HULL_BLOCK", 1, 1),
        game.entities.ShipBlock:new("HULL_BLOCK", 1, -1),
        game.entities.ShipBlock:new("HULL_BLOCK", 2, 1),
        game.entities.ShipBlock:new("HULL_BLOCK", 2, -1)
    )
    
    local ship2 = game.entities.Ship:new(500, 200, 0)
    ship2:addShipBlock(
        game.entities.ShipBlock:new("HULL_BLOCK", 0, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", 1, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", -1, 0),
        game.entities.ShipBlock:new("HULL_BLOCK", 0, 1),
        game.entities.ShipBlock:new("HULL_BLOCK", 0, -1)
    )
    
    ECSMANAGER:addEntity(
        ship,
        ship2
    )
    
    ECSMANAGER:addSystem(
        game.systems.EntityDebug:new(0),
        game.systems.ShipRenderer:new(0)
    )
end

function Shiptest3:update(DT)
    BOX2DWORLD:update(DT)
    ECSMANAGER:update(DT)
    
    local THRUST_FORCE = 1000
    
    local body = ECSMANAGER:getEntitiesWithTag("ship")[1].box2dBody 
    
    if love.keyboard.isDown('r') then
        body:applyForce( THRUST_FORCE, THRUST_FORCE, 250, 250 )
        --body:setAngle(body:getAngle() + (10*DT))
    end
    
    if love.keyboard.isDown("a") then
        body:applyForce(-1*THRUST_FORCE, 0)
    end
    if love.keyboard.isDown("d") then
         body:applyForce(THRUST_FORCE, 0)
    end
    if love.keyboard.isDown("w") then
         body:applyForce(0, -1*THRUST_FORCE)
    end
    if love.keyboard.isDown("s") then
         body:applyForce(0, THRUST_FORCE)
    end
    
    if love.keyboard.isDown("down") then 
        CAMERA.y = CAMERA.y + 3
    end
    if love.keyboard.isDown("up") then 
        CAMERA.y = CAMERA.y - 3
    end
    if love.keyboard.isDown("right") then 
        CAMERA.x = CAMERA.x + 3
    end
    if love.keyboard.isDown("left") then 
        CAMERA.x = CAMERA.x - 3
    end
end

function Shiptest3:draw()
    
    CAMERA:attach()
    ECSMANAGER:draw(DT)
    CAMERA:detach()
end

function Shiptest3:mousepressed( x, y, mb )
   if mb == "wu" then
      CAMERA.scale = CAMERA.scale - 0.2
      
   end

   if mb == "wd" then
      CAMERA.scale = CAMERA.scale + 0.2
   end
end

function Shiptest3:keypressed(KEY, ISREPEAT)
    if KEY == "v" then
        if VIEW == 1 then
            VIEW = 0
        else
            VIEW = 1
        end
    end
end

game.states.Shiptest3 = Shiptest3