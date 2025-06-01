-- Noirbound: Main Entrypoint

-- Library imports:
local Gamestate = require "lib.hump.gamestate"

-- Game states:
local menu      = require "states.menu"
local game      = require "states.game"
local gameover  = require "states.gameover"
local prologue  = require "states.prologue"
local credits   = require "states.credits"

-- Initalize the game.
function love.load()
    -- Manage game states with hump.gamestate:
    Gamestate.registerEvents() -- Register love events with Gamestate
    Gamestate.switch(menu)     -- Start with the menu state
end

-- We don't need to use love.update or love.draw, as hump.gamestate will handle that for us.