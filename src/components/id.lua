-- Noirbound: ID Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("id", function (self, id)
    assert(id ~= nil, "ID must be assigned")
    self.value = id
end) 

return component