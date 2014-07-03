-- Load in libs
require('lib.tableutils')
require('lib.stringutils')

Class       = require('lib.middleclass')
Camera      = require('lib.hump.camera')
Gamestate   = require('lib.hump.gamestate')
Lecs        = require('lib.lecs.lecs')
lovebird    = require('lib.lovebird')

-- Load in other game files
require('game.game')
require('game.states.mainmenu')
require('game.states.shipbuilder')
require('game.states.shiptest')
require('game.states.shiptest2')
require('game.states.shiptest3')

function love.load()
    --local width, height = love.window.getDesktopDimensions()
    --love.window.setMode(width, height, {fullscreen=true})
    
    Gamestate.registerEvents()
    Gamestate.switch(game.states.Mainmenu)
end