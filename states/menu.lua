-- Noirbound: Menu State
local gamestate = require "lib.external.hump.gamestate"
local prologue = require "states.prologue"
local music = require "lib.internal.audio.bg"
local grid = require "lib.internal.utils.grid"

local menu = {}

function menu:enter()
    -- Font:
    self.titleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 72)
    self.subtitleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 24)

    -- Music:
    music.play("assets/sfx/bg5.wav", true, true)
end

function menu:update(dt)
    -- Music:
    music.update(dt)
end

function menu:draw()
    -- Set the background color:
    love.graphics.clear(0, 0, 0)

    -- Draw the grid:
    local gridSize = 32
    grid:draw(gridSize)

    -- Draw menu text:
    love.graphics.setColor(1, 1, 1) -- Reset color to white
    love.graphics.setFont(self.titleFont)
    love.graphics.printf("NOIRBOUND", 0, 0, love.graphics.getWidth(), "center")
    love.graphics.setFont(self.subtitleFont)
    love.graphics.printf("Press Enter to start", 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "center")
end

function menu:keypressed(key)
    if key == "return" then
        gamestate.switch(prologue)
    end
end

return menu
