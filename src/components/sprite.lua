-- Noirbound: Sprite Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("sprite", function(self, image)
    self.image = image
end)

return component