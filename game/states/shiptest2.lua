game.states.Shiptest2 = {}
local shiptest2 = game.states.Shiptest2

--BLOCK_WIDTH = 40
--BLOCK_HEIGHT = 40
BLOCK_WIDTH = 10
BLOCK_HEIGHT = 10
BLOCK_SPACING = 20
BLOCK_JOINTS = 5

function newHullBlock()
    local self = {}
    
    self.bt = 1
    self.shape = nil
    self.fixture = nil
    self.isDestroyed = nil
    self.rgb = {255,255,255}
    self.health = 255
    
    return self
end

ship1 = {
    shipBody = nil,    
    shipHullBlocks = {    
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
        {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}}
    }
}

function shiptest2:enter()   
    camera = Camera(love.graphics.getWidth()/2,love.graphics.getHeight()/2)
    
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    
    ship1.shipBody = love.physics.newBody(world, 0, 0, "dynamic")
    for a=1, #ship1.shipHullBlocks do
        for b=1, #ship1.shipHullBlocks[a] do                        
            local blockShape = love.physics.newRectangleShape(BLOCK_WIDTH*b, BLOCK_HEIGHT*a, BLOCK_WIDTH, BLOCK_HEIGHT, 0)
            local blockFixture = love.physics.newFixture(ship1.shipBody, blockShape, 20000)           
            
            blockFixture:setUserData(ship1.shipHullBlocks[a][b])            
            
            ship1.shipHullBlocks[a][b].shape = blockShape
            ship1.shipHullBlocks[a][b].fixture = blockFixture            
            ship1.shipHullBlocks[a][b].rgb = {255,255,255}
            ship1.shipHullBlocks[a][b].health = 255
            ship1.shipHullBlocks[a][b].isDestroyed = false
        end
    end    
    
    ball = {}
    ball.body = love.physics.newBody(world, love.graphics.getWidth()/2, 100, "dynamic")
    ball.shape = love.physics.newCircleShape(20)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1000)
    ball.rgb = {255,255,255}
end

function shiptest2:update(dt)    
    world:update(dt)
    
    if love.keyboard.isDown("down") then camera.y = camera.y + 5 end
    if love.keyboard.isDown("up") then camera.y = camera.y - 5 end
    if love.keyboard.isDown("right") then camera.x = camera.x + 5 end
    if love.keyboard.isDown("left") then camera.x = camera.x - 5 end
    if love.keyboard.isDown("=") then camera.scale = camera.scale + .5 end
    if love.keyboard.isDown("-") then camera.scale = camera.scale - .5 end
    
    --here we are going to create some keyboard events
  if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
    ball.body:applyForce(40000, 0)
  elseif love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
    ball.body:applyForce(-40000, 0)
  elseif love.keyboard.isDown("w") then --press the up arrow key to set the ball in the air
    ball.body:applyForce(0, -40000)
    elseif love.keyboard.isDown("s") then --press the up arrow key to set the ball in the air
    ball.body:applyForce(0, 40000)
  end
    
    if love.keyboard.isDown("p") then
        ball.body:applyForce(-99999999, 0)
    end
    
    if love.keyboard.isDown("r") then
        ball.body:setX(love.graphics.getWidth()/2, 200)
    end
    Secs.update(dt)
end

function shiptest2:draw()
    camera:attach()
    
    
    for a=1, #ship1.shipHullBlocks do 
        for b=1, #ship1.shipHullBlocks[a] do
            
            if ship1.shipHullBlocks[a][b].health > 0 and ship1.shipHullBlocks[a][b].isDestroyed == false then
                love.graphics.setColor(ship1.shipHullBlocks[a][b].rgb)
                pcall(function()
                    love.graphics.polygon("line", ship1.shipBody:getWorldPoints(ship1.shipHullBlocks[a][b].shape:getPoints()) )
                end)                
            end
        end
    end
    
    love.graphics.setColor(ball.rgb)
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
    camera:detach()
end

function shiptest2:keypressed(KEY, ISREPEAT)    
    if KEY == "escape" then
        Gamestate.switch(game.states.Mainmenu)
    end
end

function shiptest2:mousepressed( x, y, mb )
   if mb == "wu" then
        if camera.scale >= 0 then
            camera.scale = camera.scale + .5            
        end
   end

   if mb == "wd" then
        if camera.scale > .5 then
            camera.scale = camera.scale - .5
        end
   end
end


function beginContact(FIXTURE1, FIXTURE2, CONTACT)        
    local F1UD = FIXTURE1:getUserData()
    local F2UD = FIXTURE2:getUserData()
    
    local oneishullblock = false
    local twoishullblock = false
    
    if F1UD ~= nil then
        if F1UD.bt ~= nil then
            if F1UD.bt == 1 then
                oneishullblock = true
            end
        end
    end
    
    if F2UD ~= nil then
        if F2UD.bt ~= nil then
            if F2UD.bt == 1 then
                twoishullblock = true
            end
        end
    end
    
    if oneishullblock and twoishullblock then
        return
    elseif oneishullblock == true and twoishullblock == false then
        local mass = FIXTURE2:getBody():getMass()
        local velocityX, velocityY = FIXTURE2:getBody():getLinearVelocity()
        local velocity = (velocityX+velocityY)/2
        local force = (mass * velocity)
        
        if force < 0 then
            force = force * -1
        end
        
        F1UD.health = F1UD.health - force
        F1UD.rgb = {F1UD.health,F1UD.health,F1UD.health}
        
        if F1UD.health < 0 or force > 15000 then
            F1UD.fixture:destroy()            
        end
    elseif oneishullblock == false and twoishullblock == true then        
        local mass = FIXTURE1:getBody():getMass()
        local velocityX, velocityY = FIXTURE1:getBody():getLinearVelocity()
        local velocity = (velocityX+velocityY)
        local force = (mass * velocity)
        
        if force < 0 then
            force = force * -1
        end
        
        F2UD.health = F2UD.health - force
        F2UD.rgb = {F2UD.health,F2UD.health,F2UD.health}
        
        if F2UD.health < 0 or force > 15000 then
            F2UD.fixture:destroy()           
        end
    end
end

function endContact(a, b, coll)
end

function preSolve(FIXTURE1, FIXTURE2, CONTACT)
    
end

function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end