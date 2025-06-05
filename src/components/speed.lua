-- Noirbound: Speed Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("speed", function (self, value)
    self.value = value or 0 -- Default speed is 0.
end) 

return component
