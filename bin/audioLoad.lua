function audioCache()
    
    jet_sound = love.audio.newSource("audios/jet_sound.wav", "stream")
    jet_sound:setLooping(true)
    jet_sound:setVolume(0.01)
    jet_sound:play()

    background_sound = love.audio.newSource("audios/Hair-Trigger.mp3", "stream")
    background_sound:setLooping(true)
    background_sound:setVolume(0.04)
    background_sound:play()

    shot_sound = love.audio.newSource("audios/laserBlast.mp3", "stream")
    explosion_nave = love.audio.newSource("audios/explosion.mp3", "stream")
    game_over = love.audio.newSource("audios/game_over.mp3", "stream")

end