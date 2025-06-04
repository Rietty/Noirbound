--Noirbound: Game State
--[[
    This game state is a bit more complex than the others, since we need to handle level management as well as player input.
    There is an underlying ECS system to handle complex game logic, and we use STI for tilemaps so we have easier collision detection as required.
]] --

local gamestate = require "lib.external.hump.gamestate"
local gameover = require "states.gameover"
local credits = require "states.credits"
local sti = require "lib.external.sti"

--- @module "lib.external.concord.concord"
local concord = require "concord"

local game = {}
local currentLevel = 1
local totalLevels = 6

-- Loading a level is same as changing it. We just initalize everything required.
function game:loadLevel(level)
    -- Need a new "world" for each level, with it's own associated map in STI.
    self.map = sti("assets/maps/level" .. level .. ".lua", { "bump" }) -- Load the map with collision detection.
    self:initEntities(level)
end

function game:initEntities(level)
end

function game:enter()
end

function game:update(dt)
end

function game:draw()
end

return game
