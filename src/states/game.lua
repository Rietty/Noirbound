--Noirbound: Game State
--[[
    This game state is a bit more complex than the others, since we need to handle level management as well as player input.
    There is an underlying ECS system to handle complex game logic, and we use STI for tilemaps so we have easier collision detection as required.
]] --

--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local config = require "config"
local music = require "libs.internal.audio.bg"
local gamestate = require "libs.external.hump.gamestate"
local credits = require "states.credits"

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
    entities.player(self.player, 0, 0, 8, 8)

    -- Add systems to the world.
    self.world:addSystems(
        systems.draw,
        systems.collision,
        systems.friction,
        systems.gravity,
        systems.input,
        systems.physics,
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

    -- Set the default font:
    self.exitFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 6)

    -- Music:
    music.play("assets/sfx/bg1.wav", true, true)
end

-- Update per time unit.
function game:update(dt)
    -- Update music:
    music.update(dt)
    -- Update the world with the delta time.
    self.world:emit("update", dt)
end

-- Draw per frame.
function game:draw()
    -- Set canvas
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear(0, 0, 0)

    -- Draw a single "ground line" for the player to stand on.
    love.graphics.setColor(0, 1, 0, 1) -- Set color to green
    love.graphics.rectangle("fill", 0, config.virtualHeight - 1, config.virtualWidth, 1)

    -- Print on top (Escape to Exit!)
    love.graphics.setColor(1, 1, 1, 1) -- Reset color to white
    love.graphics.setFont(self.exitFont)
    love.graphics.print("Press Escape to Exit!", (config.virtualWidth - self.exitFont:getWidth("Press Escape to Exit!")) / 2, 4)

    -- ECS draws entities to current canvas
    -- This should happen after any other drawing of the world, so it doesn't get overwritten or cleared.
    self.world:emit("draw")

    -- Scale + draw canvas to screen
    love.graphics.setCanvas()
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(self.canvas, self.drawOffsetX, self.drawOffsetY, 0, self.scale, self.scale)
    love.graphics.setBlendMode("alpha", "alphamultiply")
end

function game:keypressed(key)
    if key == "escape" then
        gamestate.switch(credits)
    end
end

return game