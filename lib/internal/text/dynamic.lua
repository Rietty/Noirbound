-- Noirbound: Dynamic Textbox Module
-- This module provides a dynamic textbox that displays text character by character,
-- with support for highlighting specific words and wrapping text to fit the screen.

local utf8 = require "utf8"

local textbox = {}
textbox.__index = textbox

function textbox.new(text, font, speed, highlight)
    local self = setmetatable({}, textbox)
    self.fullText = text
    self.font = font or love.graphics.getFont()
    self.speed = speed or 0.05
    self.highlightedWords = highlight or {}
    self.currentText = ""
    self.charIndex = 0
    self.timer = 0
    self.finished = false
    return self
end

local function utf8sub(str, start, stop)
    stop = stop or start
    local byteStart = utf8.offset(str, start)
    local byteEnd = utf8.offset(str, stop + 1) and utf8.offset(str, stop + 1) - 1 or #str
    return str:sub(byteStart, byteEnd)
end

local function splitAndColorizeLine(line, font, x, y, highlight)
    local segments, currentX = {}, x
    for word in line:gmatch("%S+") do
        local clean = word:gsub("[%p%c]", "")
        local color = highlight[clean] or { 1, 1, 1 }
        table.insert(segments, { text = word, x = currentX, y = y, color = color })
        currentX = currentX + font:getWidth(word .. " ")
    end
    return segments
end

function textbox:update(dt)
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

function textbox:draw(exit, centerY)
    local wrapWidth = love.graphics.getWidth() - 100
    local _, wrapped = self.font:getWrap(self.currentText, wrapWidth)
    local textHeight = #wrapped * self.font:getHeight()
    centerY = centerY or (love.graphics.getHeight() - textHeight) / 2

    for i, line in ipairs(wrapped) do
        local x = (love.graphics.getWidth() - self.font:getWidth(line)) / 2
        local y = centerY + (i - 1) * self.font:getHeight()
        local segs = splitAndColorizeLine(line, self.font, x, y, self.highlightedWords)
        for _, s in ipairs(segs) do
            love.graphics.setColor(s.color)
            love.graphics.print(s.text .. " ", s.x, s.y)
        end
    end

    if self.finished then
        love.graphics.setColor(1, 1, 1)
        if exit then
            love.graphics.printf("Press Space to exit...", 0, love.graphics.getHeight() - 60, love.graphics.getWidth(),
                "center")
        else
            love.graphics.printf("Press Space to continue...", 0, love.graphics.getHeight() - 60, love.graphics.getWidth(),
                "center")
        end
    end
end

function textbox:skip()
    self.charIndex = #self.fullText
    self.currentText = self.fullText
    self.finished = true
end

return textbox
