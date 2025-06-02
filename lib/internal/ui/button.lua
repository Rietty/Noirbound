-- Noirbound: Button Class
local sprites = require "lib.external.shard.spritesheet"

local button = {}
button.__index = button

-- Button constructor:
function button:new(x, y, w, h, text, font, fontSize, sprites, callback)
    local self = setmetatable({}, button)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.text = text or ""
    self.font = font or love.graphics.newFont(fontSize or 12)
    self.sprites = sprites
    self.isPressed = false
    self.isHovered = false
    self.callback = callback or function() end
    return self
end

function button:isMouseOver(mx, my)
    return mx >= self.x and mx <= self.x + self.w and my >= self.y and my <= self.y + self.h
end

function button:update(dt)
    local mx, my = love.mouse.getPosition()
    self.isHovered = self:isMouseOver(mx, my)
end

function button:mousepressed(x, y, b)
    if b == 1 and self:isMouseOver(x, y) then
        self.isPressed = true
    end
end

function button:mousereleased(x, y, b)
    if b == 1 then
        if self.isPressed and self:isMouseOver(x, y) then
            self.callback()
        end
        self.isPressed = false
    end
end
 
function button:draw()
    -- Choose sprite set based on state, if isHovered, then use "button_hover", if isPressed, then use "button_pressed", otherwise use "button_normal" 
    local spriteSet = "button_normal"
    if self.isPressed then
        spriteSet = "button_normal"
    elseif self.isHovered and not self.isPressed then
        spriteSet = "button_hover"
    end
end

return button