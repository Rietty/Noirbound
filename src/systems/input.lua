-- Noirbound: Input System
-- This system is responsible for handling input and emitting a world event to allow for other systems to respond to said input.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

local InputSystem = concord.system({ pool = { "direction", "controllable" } })

function InputSystem:update(dt)
    for _, e in ipairs(self.pool) do
        local body = e.physics.body
        local vx, vy = body:getLinearVelocity()
        local speed = e.speed.value

        local dx = 0
        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
            dx = dx - 1
            e.facing.value = "left"
        end
        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
            dx = dx + 1
            e.facing.value = "right"
        end

        body:setLinearVelocity(dx * speed, vy)
        
        if love.keyboard.isDown("up") or love.keyboard.isDown("w") or love.keyboard.isDown("space") then
            local contacts = body:getContacts()
            local grounded = false
            for i = 1, #contacts do
                if contacts[i].isTouching() then
                    grounded = true
                    break
                end
            end
            if grounded then
                body:applyLinearImpulse(0, -150)
            end
        end
    end
end

return InputSystem
