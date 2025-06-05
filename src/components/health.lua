-- Noirbound: Health Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("health", function (c, hp)
    c.hp = hp or 0
end) 

return component