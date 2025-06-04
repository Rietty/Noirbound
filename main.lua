-- Noirbound: Main Entrypoint

-- Disable requirement to include "src" when importing game states, components, etc.
love.filesystem.setRequirePath(love.filesystem.getRequirePath() .. ";src/?.lua")

-- Library imports:
local gamestate = require "libs.external.hump.gamestate"

-- Game states: 
-- The game will have multiple states, such as menu, gameplay, and game over.
-- We only need to import stats which we will be using or swapping to.
local menu      = require "states.menu"

-- Initalize the game.
function love.load()
    -- Manage game states with hump.gamestate:
    gamestate.registerEvents() -- Register love events with Gamestate
    gamestate.switch(menu)     -- Start with the menu state
end

-- We don't need to use love.update or love.draw, as hump.gamestate will handle that for us.I