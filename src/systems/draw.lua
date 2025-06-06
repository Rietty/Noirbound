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
        -- Do nothing for now.
    end
end

return DrawSystem