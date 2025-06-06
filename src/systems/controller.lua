-- Noirbound: Controller System
-- This system is responsible for handling input and updating any controllable entities with an updated direction vector or state.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

local ControllerSystem = concord.system({ pool = { "controllable", "direction", "interactor" } })

function ControllerSystem:moveLeft()
    for _, e in ipairs(self.pool) do
        local direction = e:get("direction")
        direction.vec.x = -1
    end
end

function ControllerSystem:moveRight()
    for _, e in ipairs(self.pool) do
        local direction = e:get("direction")
        direction.vec.x = 1
    end
end

function ControllerSystem:moveUp()
    for _, e in ipairs(self.pool) do
        local direction = e:get("direction")
        direction.vec.y = -1
    end
end

function ControllerSystem:moveDown()
    for _, e in ipairs(self.pool) do
        local direction = e:get("direction")
        direction.vec.y = 1
    end
end

return ControllerSystem