-- Noirbound: BG Music Module
-- This module handles the background music for the game with correct cross-fading between game states.

local music = {
    current = nil,
    next = nil,
    currentPath = nil,
    nextPath = nil,
    targetVolume = 1.0,
    fadeSpeed = 0.7,
    volume = 0
}

function music.play(path, loop, fade)
    if music.currentPath == path then
        return
    end

    if music.current then
        music.next = love.audio.newSource(path, "stream")
        music.next:setLooping(loop or false)
        music.next:setVolume(0)
        music.next:play()
        music.nextPath = path
    else
        music.current = love.audio.newSource(path, "stream")
        music.current:setLooping(loop or false)
        music.current:setVolume(fade and 0 or music.targetVolume)
        music.current:play()
        music.currentPath = path
    end
end

function music.update(dt)
    if music.current and music.next then
        local cv = music.current:getVolume()
        local nv = music.next:getVolume()
        cv = math.max(0, cv - dt * music.fadeSpeed)
        nv = math.min(music.targetVolume, nv + dt * music.fadeSpeed)
        music.current:setVolume(cv)
        music.next:setVolume(nv)

        if cv <= 0 and nv >= music.targetVolume then
            music.current:stop()
            music.current = music.next
            music.currentPath = music.nextPath
            music.next = nil
            music.nextPath = nil
        end
    elseif music.current then
        local cv = music.current:getVolume()
        if cv < music.targetVolume then
            music.current:setVolume(math.min(music.targetVolume, cv + dt * music.fadeSpeed))
        end
    end
end

function music.stop()
    if music.current then music.current:stop() end
    if music.next then music.next:stop() end
    music.current, music.next = nil, nil
    music.currentPath, music.nextPath = nil, nil
end

return music
