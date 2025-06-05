--Noirbound: Game State
--[[
    This game state is a bit more complex than the others, since we need to handle level management as well as player input.
    There is an underlying ECS system to handle complex game logic, and we use STI for tilemaps so we have easier collision detection as required.
]] --

--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

-- Required for GameState management.
local game = {}

-- Load all entity assemblage functions so we can create entities.
concord.utils.loadNamespace("src/entities")

-- Load all systems into the namespace.
local systems = {}
concord.utils.loadNamespace("src/systems", systems)

-- Load systems, world and other stuff required for the game state.
function game:enter()
    -- Create a new world for the game state.
    self.world = concord.world()

    -- Create a new entity
    self.player = concord.entity(self.world)
    self.player:assemble(character, 50, 50)

    -- Add systems to the world.
    self.world:addSystems(
        systems.draw,
        systems.move
    )
end

-- Update per time unit.
function game:update(dt)
    self.world:emit("update", dt)
end

-- Draw per frame.
function game:draw()
    self.world:emit("draw")
end

return game