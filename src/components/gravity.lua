-- Noirbound: Gravity Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("gravity", function (self, strength)
    self.strength = strength or 981 -- Default strength is 981, which is approximately Earth's gravity in pixels per second squared.
end) 

return component
