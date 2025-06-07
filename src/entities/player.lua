-- Noirbound: Player Entity
-- A player entity is a character entity that represents the player in the game.
-- There is only one player entity, and it has some extra components to allow for player-specific functionality.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local states = require "constants.character"
local anim8 = require "libs.external.animation.anim8"

local character = require "entities.character"

concord.utils.loadNamespace("src/components")

local image = love.graphics.newImage("assets/images/core/hero.png")
local grid = anim8.newGrid(8, 8, image:getWidth(), image:getHeight())

local animations = {
    idle = anim8.newAnimation(grid("1-2", 6), 0.2),
    jump = anim8.newAnimation(grid(1, 2), 0.2),
    walk = anim8.newAnimation(grid("1-2", 1), 0.2),
    attack = anim8.newAnimation(grid(4, 3), 0.2),
}

return function(entity, x, y, width, height, physicsWorld)
    local body = love.physics.newBody(physicsWorld, x, y, "dynamic")
    local shape = love.physics.newRectangleShape(width, height)
    local fixture = love.physics.newFixture(body, shape)
 
    entity:assemble(character, x, y)
    :give("animation")
    :give("persistent")
    :give("sprite", image)
    :give("controllable")
    :give("focus")
    :give("interactor")
    :give("speed", 100)
    :give("id", "AXEL")
    :give("animation", animations, states.idle)
    :give("facing", "right")
    :give("physics", body, shape, fixture)
    :give("size", width, height)
end