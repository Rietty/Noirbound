-- Noirbound: Facing Component
-- Where the entity is facing, such as "left" or "right".
-- This is used for animations and other visual effects.
-- It is not used for physics or movement, as that is handled by the direction component.

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("facing", function (self, value)
    self.value = value or "right" -- Default facing direction is "right".
end) 

return component
