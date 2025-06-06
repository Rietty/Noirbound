-- Noirbound: Friction System
-- This system is responsible for calculating friction on entities with a velocity and that are grounded.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

local FrictionSystem = concord.system({ pool = { "velocity", "friction", "grounded" } })

function FrictionSystem:update(dt)
    for _, e in ipairs(self.pool) do
        if not e.grounded.value then
            do break end
        end

        local vx = e.velocity.vec.x
        local sign = vx > 0 and 1 or (vx < 0 and -1 or 0)
        local decay = e.friction.amount * dt

        if math.abs(vx) <= decay then
            vx = 0
        else
            vx = vx - sign * decay
        end
    end
end

return FrictionSystem
