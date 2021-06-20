
meteoros = {}

function criarMeteoro()
    meteoro = {
        x = math.random(LARGURA_TELA),
        y = -100,
        largura = 36,
        altura = 74,    
        peso = math.random(1,1.2),
        deslocamento_horizontal = math.random(0, 0.1),
        deslocamento_horizontal_inv = math.random(-0.1, 0)
    }
    table.insert(meteoros, meteoro)
end

function moveMeteoros()
    for k,meteoro in pairs(meteoros) do
        meteoro.y = meteoro.y + meteoro.peso
        meteoro.x = meteoro.x + meteoro.deslocamento_horizontal + meteoro.deslocamento_horizontal_inv
    end
end

function removeMeteoros()
    for i = #meteoros, 1, -1 do
        if meteoros[i].y > ALTURA_TELA then
            table.remove(meteoros,i)
        end
    end
end