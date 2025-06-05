--Noirbound: Game State
--[[
    This game state is a bit more complex than the others, since we need to handle level management as well as player input.
    There is an underlying ECS system to handle complex game logic, and we use STI for tilemaps so we have easier collision detection as required.
]] --

--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local config = require "config"

-- Required for GameState management.
local game = {}

-- Load all entity assemblage functions so we can create entities.
local entities = {}
concord.utils.loadNamespace("src/entities", entities)

-- Load all systems into the namespace.
local systems = {}
concord.utils.loadNamespace("src/systems", systems)

-- Load systems, world and other stuff required for the game state.
function game:enter()
    -- Create a new world for the game state.
    self.world = concord.world()

    -- Create a new entity
    self.player = concord.entity(self.world)
    entities.player(self.player, 0, 0, 5, 5)

    -- Add systems to the world.
    self.world:addSystems(
        systems.draw,
        systems.move
    )

    -- Create a canvas and set the filters required for such a thing, as well as calulating the scale factor:
    self.canvas = love.graphics.newCanvas(config.virtualWidth, config.virtualHeight)
    self.canvas:setFilter("nearest", "nearest")

    -- Calculate the scale factor and load fonts based off scaling factor.
    self.scale = math.floor(
        math.min(
            love.graphics.getWidth() / config.virtualWidth,
            love.graphics.getHeight() / config.virtualHeight
        )
    )

    self.drawOffsetX = math.floor((love.graphics.getWidth() - config.virtualWidth * self.scale) / 2)
    self.drawOffsetY = math.floor((love.graphics.getHeight() - config.virtualHeight * self.scale) / 2)

end

-- Update per time unit.
function game:update(dt)
    self.world:emit("update", dt)
end

-- Draw per frame.
function game:draw()
    -- Set canvas
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear(0, 0, 0)

    -- ECS draws entities to current canvas
    self.world:emit("draw")

    -- Scale + draw canvas to screen
    love.graphics.setCanvas()
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(self.canvas, self.drawOffsetX, self.drawOffsetY, 0, self.scale, self.scale)
    love.graphics.setBlendMode("alpha", "alphamultiply")
end

return game