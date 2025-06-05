-- Noirbound: Direction Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local vector = require "libs.external.brine.vector"

local component = concord.component("direction", function (self, x, y)
    self.vec = vector(x or 0, y or 0) -- Unit vector by default, so it'll be 0 to 1.
end) 

return component
