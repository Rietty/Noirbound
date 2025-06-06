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
        -- Move based off the direction and such.
        local position = e:get("position").vec
        local velocity = e:get("velocity").vec
        local direction = e:get("direction").vec

        local speed = e:get("speed").value

        velocity.x, velocity.y = vector.split(velocity + direction * speed * dt)
        position.x, position.y = vector.split(position + velocity * dt)

        -- Ensure the entity stays within the bounds of the screen.
        if position.x < 0 then
            position.x = 0
        elseif position.x > width - e:get("size").width then
            position.x = width - e:get("size").width
        end
        if position.y < 0 then
            position.y = 0
        elseif position.y > height - e:get("size").height then
            position.y = height - e:get("size").height
        end
    end
end

return MoveSystem