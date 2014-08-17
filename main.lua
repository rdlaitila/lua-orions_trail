-- Import middleclass dependency 
class = require('lib.middleclass')

-- Import Hump Objects
hump = {}
hump.Camera = require('lib.hump.camera')
hump.Gamestate = require('lib.hump.gamestate')

-- Import lecs Library
lecs = require('lib.lecs.lecs')

-- Load in other game files
require('game.game')
require('game.states.mainmenu')
require('game.states.shipbuilder')
require('game.states.shiptest')
require('game.states.shiptest2')
require('game.states.shiptest3')

function love.load()
    local width, height = love.window.getDesktopDimensions()
    love.window.setMode(width, height, {fullscreen=true})
    
    hump.Gamestate.registerEvents()
    hump.Gamestate.switch(game.states.Mainmenu)
end