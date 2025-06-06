-- Noirbound: Move System
-- This system is responsible for moving entities based on position and velocity components.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local vector = require "libs.external.brine.vector"

local MoveSystem = concord.system({ pool = { "direction", "speed", "velocity" } })

function MoveSystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- Move based off the direction and such.
        local direction = e.direction.vec
        local velocity = e.velocity.vec
        local speed = e.speed.value
        local mag = math.sqrt(direction.x^2 + direction.y^2)

        if mag > 0 then
            velocity.x = (direction.x / mag) * speed
        else
            velocity.x = 0
        end
    end
end

return MoveSystem