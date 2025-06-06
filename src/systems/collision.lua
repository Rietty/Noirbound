-- Noirbound: Collision System
-- This system is responsible for handling collision detection related to the game world.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

local CollisionSystem = concord.system({ pool = { "velocity", "friction", "grounded" } })

function CollisionSystem:update(dt)
    -- Floor collision at a specific y position (e.g., map floorY)
    local floorY = 151 -- Change this to your map's floor y-coordinate
    local minX, maxX = 0, 192 -- adjust based on your map width

    for _, e in ipairs(self.pool) do
        if e.position.vec.y >= floorY then
            e.position.vec.y = floorY
            e.velocity.vec.y = 0
            e.grounded.value = true
        else
            e.grounded.value = false
        end

        -- Clamp left/right boundaries
        if e.position.vec.x < minX then
            e.position.vec.x = minX
            e.velocity.vec.x = 0
        elseif e.position.vec.x > maxX then
            e.position.vec.x = maxX
            e.velocity.vec.x = 0
        end
    end
end

return CollisionSystem
