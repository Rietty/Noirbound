-- Noirbound: Gravity System
-- Adjusts vertical velocity of entities with the value of gravity.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

local GravitySystem = concord.system({ pool = { "velocity", "gravity" } })

function GravitySystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- Apply gravity to the vertical component of velocity.
        e.velocity.vec.y = e.velocity.vec.y + e.gravity.strength * dt
    end
end

return GravitySystem