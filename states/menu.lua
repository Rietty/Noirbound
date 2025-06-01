-- Noirbound: Menu State
local Gamestate = require "lib.hump.gamestate"
local prologue = require "states.prologue"

local menu = {}

-- Loading assets and initializing the menu state:
function menu:enter()
    -- Font management:
    self.titleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 72)
    self.subtitleFont = love.graphics.newFont("assets/fonts/Direct_Message.ttf", 24)

    -- Audio management:
    self.backgroundMusic = love.audio.newSource("assets/sfx/bg5.wav", "static")
    self.backgroundMusic:setLooping(true)
    self.backgroundMusic:setVolume(1.0)
    self.backgroundMusic:play()

    -- UI asset loading:
    self.ui_frames = love.graphics.newImage("assets/ui/frames-and-banners.png")
    self.ui_inputs = love.graphics.newImage("assets/ui/inputs.png")
    self.ui_outputs = love.graphics.newImage("assets/ui/outputs.png")

    -- Creating quads for UI elements:
    self.ui_corners = {
        top_left = love.graphics.newQuad(0, 0, 16, 16, self.ui_frames:getDimensions()),
        top_right = love.graphics.newQuad(16, 0, 16, 16, self.ui_frames:getDimensions()),
        bottom_left = love.graphics.newQuad(0, 16, 16, 16, self.ui_frames:getDimensions()),
        bottom_right = love.graphics.newQuad(16, 16, 16, 16, self.ui_frames:getDimensions())
    }
end

function menu:draw()
    love.graphics.clear(0, 0, 0) -- Clear the screen with black
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.titleFont)
    love.graphics.printf("NOIRBOUND", 0, 0, love.graphics.getWidth(), "center")
    love.graphics.setFont(self.subtitleFont)
    love.graphics.printf("Press Enter to start", 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "center")
end

-- Key press handling to jump to the prologue:
function menu:keypressed(key)
    if key == "return" then
        Gamestate.switch(prologue)
    end
end

function menu:leave()
    -- Stop the background music when leaving the menu state
    if self.backgroundMusic and self.backgroundMusic:isPlaying() then
        self.backgroundMusic:stop()
    end
end

return menu
