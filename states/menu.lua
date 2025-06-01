-- Noirbound: Menu State
local gamestate = require "lib.external.hump.gamestate"
local prologue = require "states.prologue"
local music = require "lib.internal.audio.bg"
local sprites = require "lib.external.shard.spritesheet"

local menu = {}

function menu:enter()
    -- Font:
    self.titleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 72)
    self.subtitleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 24)

    -- Music:
    music.play("assets/sfx/bg5.wav", true, true)

    -- Sprites:
    self.frames = sprites:new("assets/sprites/ui/frames.lua")
end

function menu:update(dt)
    -- Music:
    music.update(dt)
end

function menu:draw()
    -- Draw menu text:
    love.graphics.clear(0, 0, 0)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.titleFont)
    love.graphics.printf("NOIRBOUND", 0, 0, love.graphics.getWidth(), "center")
    love.graphics.setFont(self.subtitleFont)
    love.graphics.printf("Press Enter to start", 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "center")

    self.frames:draw("border_corner_top_left", 0, 0, 0, 4, 4)
    self.frames:draw("border_corner_top_right", love.graphics.getWidth() / 2 - 16, 0, 0, 4, 4)
    self.frames:draw("border_corner_bottom_left", 0, love.graphics.getHeight() / 2 - 16, 0, 4, 4)
    self.frames:draw("border_corner_bottom_right", love.graphics.getWidth() / 2 - 16, love.graphics.getHeight() / 2 - 16, 0, 4, 4)
end

function menu:keypressed(key)
    if key == "return" then
        gamestate.switch(prologue)
    end
end

return menu
