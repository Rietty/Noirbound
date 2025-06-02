--[[
MIT License

Copyright (c) 2019 MineGame159

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]--

local spritesheet = {}
spritesheet._mt = {
    __index = spritesheet
}

function spritesheet:new(filename)
    local instance = {}
    setmetatable(instance, spritesheet._mt)

    local config = love.filesystem.load(filename)()
    instance.image = love.graphics.newImage(config.image)
    instance.quads = {}

    for i, v in pairs(config.sprites) do
        instance.quads[i] = love.graphics.newQuad(v.x or 0, v.y or 0, v.w or 0, v.h or 0, instance.image:getDimensions())
    end

    return instance
end

function spritesheet:draw(name, x, y, r, sx, sy, ox, oy)
    love.graphics.draw(self.image, self.quads[name] or nil, x or 0, y or 0, r or 0, sx or 1, sy or 1, ox or 0, oy or 0)
end

return spritesheet
