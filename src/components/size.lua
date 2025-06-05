-- Noirbound: Size Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("size", function (self, width, height)
    self.width = width or 1
    self.height = height or 1
end) 

return component
