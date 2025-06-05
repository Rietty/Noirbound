-- Noirbound: Move System
-- This system is responsible for moving entities based on position and velocity components.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local MoveSystem = concord.system({ pool = { "position", "velocity" } })

function MoveSystem:update(dt)
    for _, e in ipairs(self.pool) do
        e.position.x = e.position.x + e.velocity.x * dt
        e.position.y = e.position.y + e.velocity.y * dt
    end
end

return MoveSystem