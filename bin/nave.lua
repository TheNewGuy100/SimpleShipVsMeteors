nave = {
    src = "models/jet.png",
    largura =  69,
    altura =   120,
    sizeX = 1,
    sizeY = 1,
    x = LARGURA_TELA / 2 - 69/2,
    y = ALTURA_TELA - 300,
    tiros = {}
}

function destroiNave()
    
    nave.x = nave.x - 80
    nave.y = nave.y - 80
    nave.sizeX = nave.sizeX -0.7
    nave.sizeY = nave.sizeY -0.7
    nave.src = "models/explosao.png"

    jet_sound:stop()
    background_sound:stop()

    nave.image = love.graphics.newImage(nave.src)
    explosion_nave:setVolume(0.2)
    explosion_nave:play()
    game_over:setVolume(0.2)
    game_over:play()


end

function daTiro()
    if not end_game then
        local tiro = {
            x = nave.x+22.5,
            y = nave.y+22,
            largura = 16,
            altura = 16
        }
        table.insert(nave.tiros, tiro)

        
        shot_sound:stop()
        shot_sound:setVolume(0.1)
        shot_sound:play()
    end
end

function checaColisaoNave()
    for k, meteoro in pairs(meteoros) do
        if temColisao(meteoro.x, meteoro.y, meteoro.largura, meteoro.altura, nave.x, nave.y, nave.largura, nave.altura) then
            destroiNave()
            end_game = true
        end
    end
end

function checaColisaoTiro()
    for i = #nave.tiros, 1, -1 do
        for j = #meteoros, 1, -1 do
            if temColisao(nave.tiros[i].x, nave.tiros[i].y,nave.tiros[i].largura, nave.tiros[i].altura, meteoros[j].x, meteoros[j].y, meteoros[j].largura, meteoros[j].altura) then
                METEOROS_DESTRUIDOS = METEOROS_DESTRUIDOS + 1
                table.remove(nave.tiros, i)
                table.remove(meteoros, j)
                break
            end
        end
    end
end

function moveTiros()
    for i = #nave.tiros, 1, -1 do
        if nave.tiros[i].y > 0 then
            nave.tiros[i].y = nave.tiros[i].y - 1
        else
            table.remove(nave.tiros,i)
        end
    end
end

function move_nave()
    
    if love.keyboard.isDown('w') then
        if nave.y <= ALTURA_TELA and nave.y >= ALTURA_TELA - ALTURA_TELA then
            nave.y = nave.y - 1
        else
            nave.y = nave.y + 10
        end
    end

    if love.keyboard.isDown('w') and love.keyboard.isDown('lshift') then
        if nave.y <= ALTURA_TELA and nave.y >= ALTURA_TELA - ALTURA_TELA then
            nave.y = nave.y - 1
        else
            nave.y = nave.y + 10
        end
    end

    if love.keyboard.isDown('s') then
        if nave.y <= ALTURA_TELA-260 and nave.y >= ALTURA_TELA - ALTURA_TELA then
            nave.y = nave.y + 1
        else
            nave.y = nave.y - 10
        end
    end

    if love.keyboard.isDown('s') and love.keyboard.isDown('lshift') then
        if nave.y <= ALTURA_TELA-260 and nave.y >= ALTURA_TELA - ALTURA_TELA then
            nave.y = nave.y + 1
        else
            nave.y = nave.y - 10
        end
    end

    if love.keyboard.isDown('a') then
        if nave.x <= LARGURA_TELA and nave.x >= LARGURA_TELA - LARGURA_TELA then
            nave.x = nave.x - 1
        else
            nave.x = nave.x + 10
        end
    end

    if love.keyboard.isDown('a') and love.keyboard.isDown('lshift') then
        if nave.x <= LARGURA_TELA and nave.x >= LARGURA_TELA - LARGURA_TELA then
            nave.x = nave.x - 1
        else
            nave.x = nave.x + 10
        end
    end

    if love.keyboard.isDown('d') then
        if nave.x <= LARGURA_TELA-70 and nave.x >= LARGURA_TELA - LARGURA_TELA then
            nave.x = nave.x + 1
        else
            nave.x = nave.x - 10
        end
    end

    if love.keyboard.isDown('d') and love.keyboard.isDown('lshift') then
        if nave.x <= LARGURA_TELA-70 and nave.x >= LARGURA_TELA - LARGURA_TELA then
            nave.x = nave.x + 1
        else
            nave.x = nave.x - 10
        end
    end
end