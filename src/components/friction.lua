-- Noirbound: Friction Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("friction", function (self, amount)
    self.amount = amount or 981 -- We'll make it same as gravity for now.
end) 

return component