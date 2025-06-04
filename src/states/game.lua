--Noirbound: Game State
--[[
    This game state is a bit more complex than the others, since we need to handle level management as well as player input.
    There is an underlying ECS system to handle complex game logic, and we use STI for tilemaps so we have easier collision detection as required.
]] --

local game = {}

function game:enter()
end

function game:update(dt)
end

function game:draw()
end

return game
