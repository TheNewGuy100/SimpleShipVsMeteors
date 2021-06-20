LARGURA_TELA = 640
ALTURA_TELA = 942
MAX_METEOROS = 12
METEOROS_DESTRUIDOS = 0
VICTORY_TRIGGER = 100

end_game = false
VENCEDOR = false

require("bin.audioLoad")
require("bin.nave")
require("bin.meteoros")

function temColisao(x1,y1,l1,a1,x2,y2,l2,a2)
    return  x2 < x1 + l1 and
            x1 < x2 + l2 and
            y1 < y2 + a2 and
            y2 < y1 + a1
end

function checaObjetivo()
    if METEOROS_DESTRUIDOS >= VICTORY_TRIGGER then
        VENCEDOR = true
    end
end

function checaColisoes()
    
    checaColisaoNave()
    checaColisaoTiro()
    
end

function moveBackground()
    background_position_y = background_position_y + 0.5
    if background_position_y > love.graphics.getHeight() then
        background_position_y = background_position_y - love.graphics.getHeight()
    end
end

function love.load()

    math.randomseed(os.time())

    love.window.setMode( LARGURA_TELA, ALTURA_TELA, {resizable = false})
    love.window.setTitle("14 Bis vs Meteoros")

    background = love.graphics.newImage("models/background.png")
    background = love.graphics.newImage("models/background.png")
    game_over_img = love.graphics.newImage("models/retro-pixel-game-over.png")
    victory = love.graphics.newImage("models/Trophy.png")

    font_test = love.graphics.newImageFont("models/Resource-Imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")

    love.graphics.setFont(font_test)

    meteor_img = love.graphics.newImage("models/meteor2.png")
    shot_img = love.graphics.newImage("models/shot.png")
    nave.image = love.graphics.newImage(nave.src)

    audioCache()
    x, y, w, h = 20, 20, 60, 20

    background_position_x = 0
    background_position_y = 0
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
    if not end_game and victory ~= true then

        moveBackground()
        moveTiros()

        checaColisoes()
        checaObjetivo()

        if love.keyboard.isDown('w','a','s','d') then
            move_nave()
        end

        removeMeteoros()
        if #meteoros < MAX_METEOROS then
            criarMeteoro()
        end

        moveMeteoros()

    end
end

function love.keypressed(tecla)
    if tecla == "escape" then
        love.event.quit()
    elseif tecla == "space" then
        daTiro()
    end
end

function love.draw()
    
    love.graphics.draw(background, 0, background_position_y) 
    love.graphics.draw(background, 0, background_position_y - background:getHeight())

    love.graphics.print("FPS: " ..love.timer.getFPS() .. '\nMem(kB): ' .. math.floor(collectgarbage("count")), 10, 10)
    love.graphics.print("Meteoros restantes: "..VICTORY_TRIGGER-METEOROS_DESTRUIDOS, LARGURA_TELA/2 - 195, ALTURA_TELA/2+400, 0,2,2)
    
    love.graphics.draw(nave.image, nave.x, nave.y, 0, nave.sizeX, nave.sizeY, 20, 0)
    
    
    
    for k,meteoro in pairs(meteoros) do
        love.graphics.draw(meteor_img, meteoro.x, meteoro.y, 0, 0.3,0.3, 15, 10)
    end
    for k,tiro in pairs(nave.tiros) do
        love.graphics.draw(shot_img, tiro.x, tiro.y, 80.13, 0.3,0.3)
    end

    if end_game == true then
        love.graphics.draw(game_over_img, LARGURA_TELA/2 - game_over_img:getWidth()*1.5/2, ALTURA_TELA/2 - game_over_img:getHeight()*1.5/2, 0, 1.5, 1.5)
    end

    if VENCEDOR == true then
        love.graphics.draw(victory, LARGURA_TELA/2 - victory:getWidth()*0.3/2, ALTURA_TELA/2 - victory:getHeight()*0.3/2, 0, 0.3, 0.3)
    end
end