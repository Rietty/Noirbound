-- Noirbound: Physics System
-- This system is responsible for applying physics to entities based on position and velocity components.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local PhysicsSystem = concord.system({ pool = { "position", "physics" } })

function PhysicsSystem:update(dt)
    for _, e in ipairs(self.pool) do
        local body = e.physics.body
        local x, y = body:getPosition()
        e.position.vec.x = x
        e.position.vec.y = y

        -- Print debug information if needed
        -- print(string.format("Entity %s Position: (%.2f, %.2f)", e.id, x, y))
    end
end

return PhysicsSystem