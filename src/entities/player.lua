-- Noirbound: Player Entity
-- A player entity is a character entity that represents the player in the game.
-- There is only one player entity, and it has some extra components to allow for player-specific functionality.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
local character = require "entities.character"
concord.utils.loadNamespace("src/components")

return function(entity, x, y, width, height)
    entity:assemble(character, x, y)
    :give("animation")
    :give("friction")
    :give("persistent")
    :give("size", width, height)
    :give("sprite")
    :give("controllable")
    :give("interactor")
    :give("speed", 100)

end