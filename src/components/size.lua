-- Noirbound: Size Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("size", function (c, w, h)
    c.w = w or 0
    c.h = h or 0
end) 

return component