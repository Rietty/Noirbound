-- Noirbound: Physics System
-- This system is responsible for applying physics to entities based on position and velocity components.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local PhysicsSystem = concord.system({ pool = { "position", "velocity" } })

function PhysicsSystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- Move based off the direction and such.
        local position = e.position.vec
        local velocity = e.velocity.vec

        -- Update position based on velocity.
        position.x = position.x + velocity.x * dt
        position.y = position.y + velocity.y * dt
    end
end

return PhysicsSystem