-- Noirbound: Draw System
-- This system is responsible for drawing entities at a specific position on the screen.
-- It also accounts for any animation frames and draws those as well.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

local DrawSystem = concord.system({ pool = { "position", "size" } })

function DrawSystem:draw()
    for _, e in ipairs(self.pool) do
        love.graphics.setColor(1, 1, 1, 1) -- Reset color to white
        local position = e:get("position").vec
        local size = e:get("size")
        local x, y = position.x, position.y
        local width, height = size.width, size.height
        -- Draw a rectangle at the entity's position with its size.
        love.graphics.rectangle("fill", x, y, width, height)
    end
end

return DrawSystem