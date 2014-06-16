game.states.Mainmenu = {}
local mainmenu = game.states.Mainmenu

local engine = Ecs.Engine()

local background = {}
background.image = love.graphics.newImage("game//assets//backgrounds//nebula01.png")
background.renderX = 0
background.renderY = 0

function mainmenu:enter()
end

function mainmenu:update(dt)
end

function mainmenu:draw()
    love.graphics.draw( background.image, background.renderX, background.renderY)
    
    love.graphics.print("1.) Ship Builder", 0, 0)
    love.graphics.print("2.) Ship Test", 0, 15)
    love.graphics.print("3.) Ship Test 2", 0, 30)
end

function mainmenu:keypressed(KEY, ISREPEAT)
    if KEY == "1" then
        Gamestate.switch(game.states.Shipbuilder)
    elseif KEY == "2" then
        Gamestate.switch(game.states.Shiptest)
    elseif KEY == "3" then
        Gamestate.switch(game.states.Shiptest2)
    end
end

