-- Noirbound: State Component

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local states = require "constants.character"

local component = concord.component("state", function (self, initial)
    self.state = initial or states.idle
end) 

return component
