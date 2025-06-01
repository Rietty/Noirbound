-- Noirbound: Prologue State
local Gamestate = require "lib.hump.gamestate"
local game = require "states.game"
local utf8 = require "utf8"

local prologue = {}


-- Highlighted words and their colors:
local highlightedWords = {
    ["chaos"]     = { 1, 0.2, 0.2 }, -- red
    ["broke"]     = { 0.2, 1, 0.2 }, -- green
    ["colour"]    = { 1, 0.5, 0 },   -- orange
    ["colours"]   = { 1, 0.5, 0 },   -- orange
    ["burn"]      = { 1, 0.2, 0.2 }, -- red
    ["axel"]      = { 0.5, 0.7, 1 }, -- blue
    ["corrupted"] = { 1, 0.2, 0.2 }, -- red
    ["snaps"]     = { 1, 0.2, 0.2 }, -- red
    ["noirbound"] = { 0.8, 0.2, 1 }, -- purple
    ["glory"]     = { 0.5, 0.7, 1 }, -- blue
}

-- Custom functions:
local function splitAndColorizeLine(line, font, x, y)
    local segments = {}
    local currentX = x

    for word in line:gmatch("%S+") do
        local color = highlightedWords[word:gsub("[%p%c]", "")] or { 1, 1, 1 }
        table.insert(segments, { text = word, x = currentX, y = y, color = color })
        currentX = currentX + font:getWidth(word .. " ")
    end

    return segments
end

local function utf8sub(str, start, stop)
    stop = stop or start
    local byteStart = utf8.offset(str, start)
    local byteEnd = utf8.offset(str, stop + 1) and utf8.offset(str, stop + 1) - 1 or #str
    return str:sub(byteStart, byteEnd)
end

-- Loading assets and initializing the prologue state:
function prologue:enter()
    -- Font management:
    local font = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 14)
    love.graphics.setFont(font)

    -- Dialogue text setup:
    self.fullText = "In a city twisted by colour and chaos one man wakes to a world he no longer recognizes.\n\n" ..
        "The truth is always black and white, but something broke and now the colours burn into everything.\n\n" ..
        "Memories are fracturing as reality bends and axel remembers what everyone else forgets.\n\n" ..
        "Four tablets of legend once kept the balance but they've been corrupted, and the world spirals.\n\n" ..
        "Find them, reset them, before the last threads of the world snap and it's too late.\n\n" ..
        "You are now noirbound, restore the world to it's former colourless glory.\n\n"
    self.currentText = ""
    self.charIndex = 0
    self.timer = 0
    self.speed = 0.05
    self.finished = false

    -- Audio management:
    self.backgroundMusic = love.audio.newSource("assets/sfx/bg1.wav", "static")
    self.backgroundMusic:setLooping(true)
    self.backgroundMusic:setVolume(1.0)
    self.backgroundMusic:play()
end

function prologue:update(dt)
    if not self.finished then
        self.timer = self.timer + dt
        while self.timer >= self.speed and self.charIndex < #self.fullText do
            self.charIndex = self.charIndex + 1
            self.currentText = utf8sub(self.fullText, 1, self.charIndex)
            self.timer = self.timer - self.speed
        end
        if self.charIndex >= #self.fullText then
            self.finished = true
        end
    end
end

function prologue:draw()
    love.graphics.clear(0, 0, 0)
    local font = love.graphics.getFont()
    local wrapWidth = love.graphics.getWidth() - 100

    local _, wrappedText = font:getWrap(self.currentText, wrapWidth)
    local textHeight = #wrappedText * font:getHeight()
    local centerY = (love.graphics.getHeight() - textHeight) / 2

    for i, line in ipairs(wrappedText) do
        local lineWidth = font:getWidth(line)
        local baseX = (love.graphics.getWidth() - lineWidth) / 2
        local y = centerY + (i - 1) * font:getHeight()

        local segments = splitAndColorizeLine(line, font, baseX, y)
        for _, seg in ipairs(segments) do
            love.graphics.setColor(seg.color)
            love.graphics.print(seg.text .. " ", seg.x, seg.y)
        end
    end

    if self.finished then
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Press Space to continue...", 0, love.graphics.getHeight() - 60, love.graphics.getWidth(),
            "center")
    end
end

function prologue:keypressed(key)
    if key == 'space' then
        if not self.finished then
            self.charIndex = #self.fullText
            self.currentText = self.fullText
            self.finished = true
        else
            Gamestate.switch(game)
        end
    end
end

function prologue:leave()
    if self.music and self.music:isPlaying() then
        self.music:stop()
    end
end

return prologue
