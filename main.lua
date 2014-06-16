-- Load in libs
Camera      = require('lib.hump.camera')
Gamestate   = require('lib.hump.gamestate')
Ecs         = require('lib.ecs.ecs')

-- Load in other game files
require('game.game')
require('game.components.cameracontrolled')
require('game.components.position')
require('game.components.rotation')
require('game.entities.block')
require('game.states.mainmenu')
require('game.states.shipbuilder')
require('game.states.shiptest')
require('game.states.shiptest2')

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(game.states.Mainmenu)
end

function love.update(DT)    
end

function love.draw()    
end
