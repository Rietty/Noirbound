-- Noirbound: Position Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("position", function (c, x, y)
    c.x = x or 0
    c.y = y or 0
end) 

return component