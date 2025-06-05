-- Noirbound: Draw System
-- This system is responsible for drawing entities at a specific position on the screen.
-- It also accounts for any animation frames and draws those as well.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local DrawSystem = concord.system({ pool = { "position", "size" } })

function DrawSystem:draw()
    for _, e in ipairs(self.pool) do
        love.graphics.setColor(1, 1, 1) -- Reset color to white
        love.graphics.circle("fill", e.position.x, e.position.y, e.size.w / 2)
    end
end

return DrawSystem