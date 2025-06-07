-- Noirbound: Input System
-- This system is responsible for handling input and emitting a world event to allow for other systems to respond to said input.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

local InputSystem = concord.system({ pool = { "direction", "grounded", "controllable" } })

function InputSystem:update(dt)
    for _, e in ipairs(self.pool) do
        local dx = 0
        
        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
            dx = dx - 1
            e.facing.value = "left"
        end
        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
            dx = dx + 1
            e.facing.value = "right"
        end
        
        e.direction.vec.x = dx
        e.direction.vec.y = 0

        if (love.keyboard.isDown("up") or love.keyboard.isDown("w") or love.keyboard.isDown("space")) and e.grounded.value then
            e.velocity.vec.y = -400
            e.grounded.value = false
        end

        if e:has("damager") then
            ---@diagnostic disable-next-line: param-type-mismatch
            if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then
                e.damager.value = true
            else
                e.damager.value = false
            end
        end
    end
end

return InputSystem
