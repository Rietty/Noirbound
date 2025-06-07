-- Noirbound: Camera System

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local Camera = require "libs.external.hump.camera"

local CameraSystem = concord.system({ pool = { "focus", "physics", "controllable" } })

function CameraSystem:update(dt)
    for _, e in ipairs(self.pool) do
    end
end

return CameraSystem
