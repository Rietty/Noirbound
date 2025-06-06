-- Noirbound: Animation System
-- This system is responsible for handling collision detection related to the game world.

-- Load all components via concord.
--- @module "libs.external.concord.concord"
local concord = require "libs.external.concord.concord"
concord.utils.loadNamespace("src/components")

local AnimationSystem = concord.system({ pool = { "animation", "state" } })

function AnimationSystem:update(dt)
    for _, e in ipairs(self.pool) do
        e.animation.current = e.state.state
        local anim = e.animation.animations[e.animation.current]
        if anim then
            anim:update(dt)
        end
    end
end

function AnimationSystem:draw()
    for _, e in ipairs(self.pool) do
        e.animation.current = e.state.state
        local image = e.sprite.image
        local anim = e.animation.animations[e.animation.current]

        local scaleX = (e.facing.value == "right") and 1 or -1
        local offsetX = (e.facing.value == "left") and e.size.width or 0

        if anim then
            anim:draw(image, math.floor(e.position.vec.x + offsetX), math.floor(e.position.vec.y), nil, scaleX, 1)
        end
    end
end

return AnimationSystem
