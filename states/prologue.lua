local gamestate = require "lib.external.hump.gamestate"
local credits = require "states.credits"
local music = require "lib.internal.audio.bg"
local textbox = require "lib.internal.text.dynamic"

local prologue = {}

local highlights = {
    chaos     = { 1, 0.2, 0.2 },
    broke     = { 0.2, 1, 0.2 },
    colour    = { 1, 0.5, 0 },
    colours   = { 1, 0.5, 0 },
    burn      = { 1, 0.2, 0.2 },
    snap      = { 1, 0.2, 0.2 },
    axel      = { 0.5, 0.7, 1 },
    corrupted = { 1, 0.2, 0.2 },
    snaps     = { 1, 0.2, 0.2 },
    noirbound = { 0.8, 0.2, 1 },
    glory     = { 0.5, 0.7, 1 },
}

function prologue:enter()
    -- Font:
    local font = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 16)
    love.graphics.setFont(font)
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Textbox:
    local text = "One man wakes to a world twisted by colour and chaos.\n\n" ..
        "Truth is black and white, but something broke and now the colours burn.\n\n" ..
        "Memories are fracturing and only axel remembers what everyone else forgets.\n\n" ..
        "Artifacts once kept the balance but they've been corrupted.\n\n" ..
        "Find them, fix them, before the last threads of reality snap and it's too late.\n\n" ..
        "You are now noirbound.\n\n"
    self.textbox = textbox.new(text, font, 0.05, highlights)

    -- Music:
    music.play("assets/sfx/bg5.wav", true, true)
end

function prologue:update(dt)
    -- Music:
    music.update(dt)
    -- textbox:
    self.textbox:update(dt)
end

function prologue:draw()
    love.graphics.clear(0, 0, 0)
    self.textbox:draw()
end

function prologue:keypressed(key)
    if key == "space" then
        if not self.textbox.finished then
            self.textbox:skip()
        else
            gamestate.switch(credits)
        end
    end
end

return prologue
