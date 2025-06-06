-- Noirbound: Damager Component
-- Indicates if we are currently attacking something or not, and if we this component is on an entity, it will be used to determine if the entity is able to damage other entities.

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("damager", function (self, isAttacking)
    self.value = isAttacking or false -- Default to false if not specified.
end) 

return component
