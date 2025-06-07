-- Noirbound: Physics Component
-- This component is used to store the physics body, shape, and fixture for an entity, We are using Box2D for physics, so there's no need for a lot of other data.

---@module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"

local component = concord.component("physics", function(self, body, shape, fixture)
    self.body = body
    self.shape = shape
    self.fixture = fixture
end)

return component