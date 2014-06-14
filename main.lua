-- Load in libs
require('lib.trycatch')
Camera      = require('lib.hump.camera')
Gamestate   = require('lib.hump.gamestate')
Secs        = require('lib.secs')
Ecs         = require('lib.ecs')

-- Load in other game files
require('game.game')
require('game.components.cameracontrolled')
require('game.components.position')
require('game.components.text')
require('game.entities.textentity')
require('game.states.mainmenu')
require('game.states.shiptest')
require('game.states.shiptest2')
require('game.systems.renderer_textentities')
require('game.types.textentities')


function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(game.states.Shiptest2)
end

function love.update(DT)    
end

function love.draw()    
end
