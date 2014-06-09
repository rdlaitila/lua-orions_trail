game.states.Shiptest = {}
local shiptest = game.states.Shiptest

ship = {
    
}

shipHull = {
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}},
    {{bt=1},{bt=1},{bt=1},{bt=1},{bt=1}}
}


objects = {}

function shiptest:enter()   
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, true)
end

function shiptest:update(dt)
    if love.keyboard.isDown("up") then camera.y = camera.y + 5 end
    if love.keyboard.isDown("down") then camera.y = camera.y - 5 end
    if love.keyboard.isDown("left") then camera.x = camera.x + 5 end
    if love.keyboard.isDown("right") then camera.x = camera.x - 5 end
    
    Secs.update(dt)
end

function shiptest:draw()
    Secs.draw()
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
