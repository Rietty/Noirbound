-- Noirbound: Menu State
local config = require "config"
local gamestate = require "lib.external.hump.gamestate"
local prologue = require "states.prologue"
local music = require "lib.internal.audio.bg"
local sti = require "lib.external.sti"

local menu = {}

function menu:enter()
    -- Create a canvas and set the filters required for such a thing, as well as calulating the scale factor:
    self.canvas = love.graphics.newCanvas(config.virtualWidth, config.virtualHeight)
    self.canvas:setFilter("nearest", "nearest")
    self.baseFontSize = 18

    -- Calculate the scale factor and load fonts based off scaling factor.
    self.scale = math.floor(
        math.min(
            love.graphics.getWidth() / config.virtualWidth,
            love.graphics.getHeight() / config.virtualHeight
        )
    )

    self.drawOffsetX = math.floor((love.graphics.getWidth() - config.virtualWidth * self.scale) / 2)
    self.drawOffsetY = math.floor((love.graphics.getHeight() - config.virtualHeight * self.scale) / 2)

    -- Font:
    self.titleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", self.baseFontSize)
    self.fontAscent = self.titleFont:getAscent()

    -- Music:
    music.play("assets/sfx/bg5.wav", true, true)

    -- Load the map:
    self.map = sti("assets/maps/menu.lua")
end

function menu:update(dt)
    self.map:update(dt)
end

function menu:draw()
    -- Preset the canvas as needed:
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear(0, 0, 0)
    
    -- Draw title text:
    love.graphics.setColor(1, 1, 1) -- Set text color to white.
    love.graphics.setFont(self.titleFont)
    love.graphics.print("NOIRBOUND", (config.virtualWidth / 2) - (self.titleFont:getWidth("NOIRBOUND") / 2),  - self.fontAscent / 2)

    -- Draw the map:
    self.map:draw()

    -- Process canvas stuff and draw to screen via scaling:
    love.graphics.setCanvas()
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(self.canvas, self.drawOffsetX, self.drawOffsetY, 0, self.scale, self.scale)
    love.graphics.setBlendMode("alpha", "alphamultiply")
end

function menu:keypressed(key)
    if key == "return" then
        gamestate.switch(prologue)
    end
end

return menu