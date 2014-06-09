game.states.Shiptest = {}
local shiptest = game.states.Shiptest

BLOCK_WIDTH = 30
BLOCK_HEIGHT = 30
BLOCK_SPACING = 20

ship1 = {
    
}

ship2 = {
    
}

shipHull = {
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}}
}

function shiptest:enter()   
    camera = Camera(love.graphics.getWidth()/2,love.graphics.getHeight()/2)
    
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    
    for a=1, #shipHull do
        for b=1, #shipHull[a] do
            print("blockx:" .. tostring(BLOCK_WIDTH*b/2))
            print("blocky:" .. tostring(BLOCK_HEIGHT*a/2))
            local blockBody = love.physics.newBody(world, BLOCK_WIDTH*b, BLOCK_HEIGHT*a, "dynamic")
            local blockShape = love.physics.newRectangleShape(BLOCK_WIDTH, BLOCK_HEIGHT)
            local blockFixture = love.physics.newFixture(blockBody, blockShape, 10000)
            
            blockBody:setUserData(shipHull[a][b])
            blockFixture:setUserData(shipHull[a][b])
            
            shipHull[a][b].body = blockBody
            shipHull[a][b].shape = blockShape
            shipHull[a][b].fixture = blockFixture
            shipHull[a][b].rgb = {255,255,255}
        end
    end
    
    for a=1, #shipHull do
        for b=1, #shipHull[a] do            
            if shipHull[a][b-1] ~= nil then --weld left
                love.physics.newWeldJoint(
                    shipHull[a][b].body,
                    shipHull[a][b-1].body,
                    0,
                    0,
                    false
                )
            end
            if shipHull[a][b+1] ~= nil then --weld right
                love.physics.newWeldJoint(
                    shipHull[a][b].body,
                    shipHull[a][b+1].body,
                    0,
                    0,
                    false
                )
            end
            if shipHull[a-1] ~= nil then --weld up
                if shipHull[a-1][b] ~= nil then
                    love.physics.newWeldJoint(
                        shipHull[a][b].body,
                        shipHull[a-1][b].body,
                        0,
                        0,
                        false
                    )
                end
            end
            if shipHull[a+1] ~= nil then --weld down
                if shipHull[a+1][b] ~= nil then
                    love.physics.newWeldJoint(
                        shipHull[a][b].body,
                        shipHull[a+1][b].body,
                        0,
                        0,
                        false
                    )
                end
            end
        end
    end
    
    ball = {}
    ball.body = love.physics.newBody(world, love.graphics.getWidth()/2, 100, "dynamic")
    ball.shape = love.physics.newCircleShape(20)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1000)
    ball.rgb = {255,255,255}
end

function shiptest:update(dt)
    world:update(dt)
    if love.keyboard.isDown("up") then camera.y = camera.y + 5 end
    if love.keyboard.isDown("down") then camera.y = camera.y - 5 end
    if love.keyboard.isDown("left") then camera.x = camera.x + 5 end
    if love.keyboard.isDown("right") then camera.x = camera.x - 5 end
    
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
    Secs.update(dt)
end

function shiptest:draw()
    camera:attach()
    
    for a=1, #shipHull do 
        for b=1, #shipHull[a] do
            love.graphics.setColor(shipHull[a][b].rgb)
            love.graphics.polygon("line", shipHull[a][b].body:getWorldPoints(shipHull[a][b].shape:getPoints()) )
        end
    end
    
    love.graphics.setColor(ball.rgb)
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
    camera:detach()
end

function shiptest:keypressed(KEY, ISREPEAT)
    if key == "p" then
       ball.body:applyForce(0, 100)
    end
end

function shiptest:mousepressed( x, y, mb )
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
        F1UD.rgb = {100,100,100}
    elseif oneishullblock == false and twoishullblock == true then
        F2UD.rgb = {100,100,100}
    end    
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end