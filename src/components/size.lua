-- Noirbound: Size Component
-- Holds the size of the entity, used for animation simplification and rendering.

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("size", function(self, width, height)
    self.width = width or 0
    self.height = height or 0
end)

return component