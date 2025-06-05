-- Noirbound: Character Entity
-- A character entity in Noirbound represents a player or enemy with some very basic components.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

function character(e, x, y)
    e
    :give("position", x, y)
    :give("velocity", 0, 0)
    :give("health", 6)
    :give("size", 8, 8)
end