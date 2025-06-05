-- Noirbound: Origin Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local vector = require "libs.external.brine.vector"

local component = concord.component("origin", function (self, x, y)
    self.vec = vector(x or 0, y or 0) -- Default to (0, 0) if no values are provided.
end) 

return component
