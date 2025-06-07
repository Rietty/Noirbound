--Noirbound: Game State
--[[
    This game state is a bit more complex than the others, since we need to handle level management as well as player input.
    There is an underlying ECS system to handle complex game logic, and we use STI for tilemaps so we have easier collision detection as required.
]] --

--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
--- @module "libs.external.sti"
local sti = require "libs.external.sti"
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

    -- Load the tilemap using STI.
    self.map = sti("assets/maps/level1.lua", { "box2d" })

    -- Create a physics world for collision detection.
    self.physicsWorld = love.physics.newWorld(0, 981)

    -- Enable Box2D physics for the map.
    -- This automatically creates a Box2D world and initializes it with the map's physics data.
    -- Layers marked as "collidable" in the map will be used for collision detection.
    self.map:box2d_init(self.physicsWorld)

    -- Create a new entity
    self.player = concord.entity(self.world)
    local spawn = self:getSpawnPoint()
    entities.player(self.player, spawn.x, spawn.y, 8, 8, self.physicsWorld)

    -- Add systems to the world.
    self.world:addSystems(
        systems.draw,
        systems.input,
        systems.physics,
        systems.state,
        systems.animation,
        systems.camera
    )

    for _, layer in ipairs(self.map.layers) do
        print(layer.name, layer.type, layer.physics and "has physics" or "no physics")
    end

    self.cameraSystem = self.world:getSystem(systems.camera) -- or store it however you manage systems

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

    ---@diagnostic disable-next-line: undefined-global
    print("Map plugins:", self.map.plugins and table.concat(vim.tbl_keys(self.map.plugins), ", ") or "none")

    -- Music:
    music.play("assets/sfx/bg1.wav", true, true)
end

-- Update per time unit.
function game:update(dt)
    music.update(dt)   
    self.physicsWorld:update(dt)
    self.world:emit("update", dt)
    self.map:update(dt)
end

-- Draw per frame.
function game:draw()
    -- Attach a camera.
    -- self.cameraSystem:get():attach()

    -- Set canvas
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear(0, 0, 0)

    -- Print on top (Escape to Exit!)
    love.graphics.setColor(1, 1, 1, 1) -- Reset color to white
    love.graphics.setFont(self.exitFont)
    love.graphics.print("Press Escape to Exit!",
        (config.virtualWidth - self.exitFont:getWidth("Press Escape to Exit!")) / 2, 4)

    -- Draw the map to the canvas.
    self.map:draw()

    -- ECS draws entities to current canvas
    -- This should happen after any other drawing of the world, so it doesn't get overwritten or cleared.
    self.world:emit("draw")    

    -- Scale + draw canvas to screen
    love.graphics.setCanvas()
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(self.canvas, self.drawOffsetX, self.drawOffsetY, 0, self.scale, self.scale)
    love.graphics.setBlendMode("alpha", "alphamultiply")

    -- Detach the camera.
    -- self.cameraSystem:get():detach()
end

function game:keypressed(key)
    if key == "escape" then
        gamestate.switch(credits)
    end
end

function game:getSpawnPoint() 
    local layer = self.map.layers["PlayerSpawn"]
    for _, obj in ipairs(layer.objects) do
        if obj.name == "Player" then
            return { x = obj.x, y = obj.y }
        end
    end
end

return game
