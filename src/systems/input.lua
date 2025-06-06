-- Noirbound: Input System
-- This system is responsible for handling input and emitting a world event to allow for other systems to respond to said input.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

local InputSystem = concord.system({})

function InputSystem:update(dt)
    -- Check for key presses and emit events accordingly.
    if love.keyboard.isDown("left") then
        self:getWorld():emit("moveLeft")
    end
    if love.keyboard.isDown("right") then
        self:getWorld():emit("moveRight")
    end
    if love.keyboard.isDown("up") then
        self:getWorld():emit("moveUp")
    end
    if love.keyboard.isDown("down") then
        self:getWorld():emit("moveDown")
    end
end

return InputSystem