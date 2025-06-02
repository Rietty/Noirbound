local gamestate = require "lib.external.hump.gamestate"
local credits = require "states.credits"
local music = require "lib.internal.audio.bg"
local textbox = require "lib.internal.text.dynamic"

local prologue = {}

local highlights = {
    chaos       = { 1, 0.2, 0.2 },
    broke       = { 0.2, 1, 0.2 },
    colour      = { 1, 0.5, 0 },
    colours     = { 1, 0.5, 0 },
    burn        = { 1, 0.2, 0.2 },
    destruction = { 1, 0.2, 0.2 },
    axel        = { 0.5, 0.7, 1 },
    corrupted   = { 1, 0.2, 0.2 },
    snaps       = { 1, 0.2, 0.2 },
    noirbound   = { 0.8, 0.2, 1 },
    glory       = { 0.5, 0.7, 1 },
}

function prologue:enter()
    -- Font:
    local font = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 14)
    love.graphics.setFont(font)

    -- Textbox:
    local text = "In a city twisted by colour and chaos one man wakes to a world he no longer recognizes.\n\n" ..
        "The truth is always black and white, but something broke and now the colours burn into everything.\n\n" ..
        "Memories are fracturing as reality bends and axel remembers what everyone else forgets.\n\n" ..
        "Four tablets of legend once kept the balance but they've been corrupted and the world spirals towards destruction.\n\n" ..
        "Find them, reset them, before the last threads of the world snap and it's too late.\n\n" ..
        "You are now noirbound, restore the world to it's former colourless glory.\n\n"
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
