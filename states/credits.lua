local gamestate = require "lib.external.hump.gamestate"
local music = require "lib.internal.audio.bg"
local textbox = require "lib.internal.text.dynamic"

local credits = {}

local highlights = {
    Credits   = { 1, 0.2, 0.2 },
    Assets    = { 0.2, 1, 0.2 },
    Testers   = { 1, 0.5, 0 },
    Developer = { 0.5, 0.7, 1 },
    And   = { 0.8, 0.2, 1 }
}

function credits:enter()
    -- Font:
    local font = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 16)
    love.graphics.setFont(font)
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Textbox:
    local text = "Credits:\n\n" ..
        "Developer:\n" ..
        "Rietty Lavoie\n\n" ..
        "Assets:\n" ..
        "VEXED\n" ..
        "1144ghost\n\n" ..
        "Testers:\n" ..
        "Andy\n" ..
        "Jon\n" ..
        "Vincent\n\n" ..
        "And:\n" ..
        "You!\n\n"
    self.textbox = textbox.new(text, font, 0.05, highlights)

    -- Music:
    music.play("assets/sfx/bg5.wav", true, true)
end

function credits:update(dt)
    -- Music:
    music.update(dt)
    -- Textbox:
    self.textbox:update(dt)
end

function credits:draw()
    love.graphics.clear(0, 0, 0)
    self.textbox:draw(true)
end

function credits:keypressed(key)
    if key == "space" then
        if not self.textbox.finished then
            self.textbox:skip()
        else
            love.event.quit()
        end
    end
end

return credits
