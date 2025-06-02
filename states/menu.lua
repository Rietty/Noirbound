-- Noirbound: Menu State
local gamestate = require "lib.external.hump.gamestate"
local prologue = require "states.prologue"
local music = require "lib.internal.audio.bg"
local grid = require "lib.internal.utils.grid"
local sprites = require "lib.external.shard.spritesheet"

local menu = {}

function menu:enter()
    -- Font:
    self.titleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 72)
    self.subtitleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 24)
    self.fontAscent = self.titleFont:getAscent()
    self.fontHeightPadding = 6

    -- Music:
    music.play("assets/sfx/bg5.wav", true, true)

    -- Grid:
    self.gridSize = 32
    self.gameWidth = love.graphics.getWidth()
    self.gameHeight = love.graphics.getHeight()

    -- Load sprites:
    self.frames = sprites:new("assets/sprites/ui/frames.lua")
end

function menu:update(dt)
    -- Music:
    music.update(dt)
end

function menu:draw()
    -- Set the background color:
    love.graphics.clear(0, 0, 0)

    -- Draw the grid:
    -- grid:draw(self.gridSize)

    -- Draw title text:
    love.graphics.setColor(1, 1, 1) -- Reset color to white

    love.graphics.setFont(self.titleFont)
    love.graphics.print("NOIRBOUND", self.gridSize * 2.5, self.gridSize * 1.5 + self.gridSize - self.fontAscent - self.fontHeightPadding)

    -- Draw the border lines using the correct frames:
    for x = 32, self.gameWidth - 48, 8 do
        self.frames:draw("border_solid_top", x, 32, 0, 2, 2)
        self.frames:draw("border_solid_bottom", x, 112, 0, 2, 2)
    end

    for y = 32, 112, 8 do
        self.frames:draw("border_solid_left", 32, y, 0, 2, 2)
        self.frames:draw("border_solid_right", self.gameWidth - 48, y, 0, 2, 2)
    end

    -- Draw the UI frames and outlines:
    self.frames:draw("corner_box_top_left", 32, 32, 0, 2, 2)
    self.frames:draw("corner_box_top_right", self.gameWidth - 48, 32, 0, 2, 2)
    self.frames:draw("corner_box_bottom_left", 32, 112, 0, 2, 2)
    self.frames:draw("corner_box_bottom_right", self.gameWidth - 48, 112, 0, 2, 2)
end

function menu:keypressed(key)
    if key == "return" then
        gamestate.switch(prologue)
    end
end

return menu
