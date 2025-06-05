-- Noirbound: Move System
-- This system is responsible for moving entities based on position and velocity components.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local vector = require "libs.external.brine.vector"

local MoveSystem = concord.system({ pool = { "position", "velocity" } })

function MoveSystem:update(dt)
    local width, height = love.graphics.getWidth() / 4, love.graphics.getHeight() / 4

    for _, e in ipairs(self.pool) do
        -- Do nothing.
    end
end

return MoveSystem