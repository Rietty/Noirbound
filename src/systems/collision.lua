-- Noirbound: Collision System
-- This system is responsible for handling collision detection related to the game world.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

local CollisionSystem = concord.system({ pool = { "velocity", "friction", "grounded" } })

function CollisionSystem:update(dt)
    for _, e in ipairs(self.pool) do
        if e.positions.y >= 300 then
            e.positions.y = 300
            e.velocity.vec.y = 0
            e.grounded.value = true
        else
            e.grounded.value = false
        end
    end
end

return CollisionSystem
