-- Noirbound: Move System
-- This system is responsible for moving entities based on position and velocity components.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local vector = require "libs.external.brine.vector"

local MoveSystem = concord.system({ pool = { "position", "velocity" } })

function MoveSystem:update(dt)
    for _, e in ipairs(self.pool) do
        local vel = e.velocity.vec
        local pos = e.position.vec
        local dir = e.direction.vec
        local speed = e.speed.value

        vel.x, vel.y = vector.split(vel + dir * speed * dt)
        pos.x, pos.y = vector.split(pos + vel * dt)
    end
end

return MoveSystem