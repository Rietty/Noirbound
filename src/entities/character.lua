-- Noirbound: Character Entity
-- A character entity in Noirbound represents a player or enemy with some very basic components.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

-- The below function creates a character entity which contains the default components every character should have.
-- A character entity is a player or an enemy in the game, or even a non-playable character (NPC).
return function(entity, x, y)
    entity:give("position", x, y)
    :give("direction", 0, 0)
    :give("state")
    :give("health")
    :give("state")
end