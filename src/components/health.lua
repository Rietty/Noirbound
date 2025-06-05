-- Noirbound: Health Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("health", function (self, current, max)
    self.max = max or 100
    self.current = math.min(current or self.max, self.max) 
end) 

return component
