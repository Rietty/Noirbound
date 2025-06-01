-- Noirbound: Menu State
local gamestate = require "lib.hump.gamestate"
local prologue = require "states.prologue"
local music = require "lib.audio.bg"

local menu = {}

-- Loading assets and initializing the menu state:
function menu:enter()
    -- Font management:
    self.titleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 72)
    self.subtitleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 24)

    -- Background music setup:
    music.play("assets/sfx/bg5.wav", true, true)
end

function menu:update(dt)
    -- Update the background music:
    music.update(dt)
end

function menu:draw()
    love.graphics.clear(0, 0, 0) -- Clear the screen with black
    love.graphics.setColor(1, 1, 1)
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
