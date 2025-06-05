-- Noirbound: Acceleration Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local vector = require "libs.external.brine.vector"

local component = concord.component("acceleration", function (self, x, y)
    self.vec = vector(x or 0, y or 0)
end) 

return component
