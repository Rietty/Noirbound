-- Noirbound: Velocity Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("velocity", function (c, x, y)
    c.x = x or 0
    c.y = y or 0
end) 

return component