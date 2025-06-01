-- Noirbound: Configuration File

function love.conf(t)
    t.window.title = "Noirbound"
    t.window.width = 800
    t.window.height = 600
    t.window.resizable = true
    t.window.vsync = true
    t.window.msaa = 4

    -- Enable modules
    t.modules.audio = true
    t.modules.event = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = false -- Disabled because not supported.
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = true
    t.modules.sound = true
    t.modules.system = true
    t.modules.timer = true
    t.modules.touch = false -- Disabled since game does not use touch input.
    t.modules.video = false -- Disabled since game does not use video playback.
end