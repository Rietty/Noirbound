-- Noirbound: State System
-- This system is responsible for managing the state of entities, such as their current action or animation state.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local states = require "constants.character"

local StateSystem = concord.system({ pool = { "state" } })

function StateSystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- -- If the entity has a state component, we can update it based on current flags.
        -- -- For example if we are in a "jumping" state, we can check by the "grounded" component.
        -- if not e.grounded.value then
        --     e.state.state = states.jump
        -- elseif e.velocity.vec.x ~= 0 then
        --     e.state.state = states.walk
        -- else
        --     e.state.state = states.idle
        -- end
    end
end

return StateSystem