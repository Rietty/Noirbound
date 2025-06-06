-- Noirbound: Grounded Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("grounded", function (self, isGrounded)
    self.value = isGrounded or false -- Default to false if not specified.
end) 

return component
