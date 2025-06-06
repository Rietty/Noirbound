-- Noirbound: Animation Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local states = require "constants.character"

local component = concord.component("animation", function (self, animations, default)
    self.animations = animations or {}
    self.current = default or states.IDLE
end) 

return component
