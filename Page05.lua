local composer = require("composer")
local scene = composer.newScene()

local physics = require("physics") -- Inclui o módulo de física
physics.start()
physics.setGravity(0, 8) -- Define a gravidade para a queda das gotas

-- Contador de colisões bem-sucedidas
local colisaoCount = 0 -- Contador inicia em 0
local maxColisoes = 5 -- Número de colisões necessárias para trocar as imagens

-- create()
function scene:create(event)
    local sceneGroup = self.view

    -- Carrega a imagem da Page05
    local imgCapa = display.newImageRect(sceneGroup, "assets/images/Page05.png", display.contentWidth, display.contentHeight)
    imgCapa.x = display.contentCenterX
    imgCapa.y = display.contentCenterY

    -- Adiciona queimadura.png
    local imgQueimadura = display.newImageRect(sceneGroup, "assets/images/queimadura.png", 180, 180)
    imgQueimadura.x = 390
    imgQueimadura.y = 900
    physics.addBody(imgQueimadura, "static", {radius = 10}) -- Define a queimadura como um objeto estático

    -- Adiciona agua.png
    local imgAgua = display.newImageRect(sceneGroup, "assets/images/agua.png", 105, 105)
    imgAgua.x = 390
    imgAgua.y = 750

    -- Função para criar gotas
    local function criarGota()
        local gota = display.newImageRect(sceneGroup, "assets/images/gota.png", 35, 35)
        gota.x = imgAgua.x -- Gotas começam na posição da água
        gota.y = imgAgua.y
        physics.addBody(gota, "dynamic", {radius = 1, bounce = 0.2})
        gota.type = "gota" -- Define o tipo para identificação
        return gota
    end

    -- Substituir imagens para saudavel.png
    local function substituirImagens()
        -- Remove imagens antigas
        display.remove(imgQueimadura)
        display.remove(imgAgua)

        -- Adiciona saudavel.png no lugar
        local imgSaudavel = display.newImageRect(sceneGroup, "assets/images/saudavel.png", 180, 180)
        imgSaudavel.x = 390
        imgSaudavel.y = 850
    end

    -- Função para detectar colisões
    local function onCollision(event)
        if event.phase == "began" then
            local obj1 = event.object1
            local obj2 = event.object2

            -- Verifica se a colisão é entre uma gota e a queimadura
            if (obj1 == imgQueimadura and obj2.type == "gota") or (obj2 == imgQueimadura and obj1.type == "gota") then
                -- Remove a gota na colisão
                if obj1.type == "gota" then
                    display.remove(obj1)
                else
                    display.remove(obj2)
                end

                -- Incrementa o contador de colisões
                colisaoCount = colisaoCount + 1
                print("Colisões: " .. colisaoCount)

                -- Verifica se atingiu o número máximo de colisões
                if colisaoCount == maxColisoes then
                    substituirImagens()
                end
            end
        end
    end

    -- Adiciona evento de colisão global
    Runtime:addEventListener("collision", onCollision)

    local function dispararGotas()
        local gota = criarGota()
    end

    -- Adiciona ouvinte de toque na água
    imgAgua:addEventListener("tap", dispararGotas)

    -- Botão para voltar para a Page04
    local btnVoltar = display.newImageRect(sceneGroup, "assets/images/btnVoltar.png", 141, 50)
    btnVoltar.x = 100
    btnVoltar.y = 963

    function btnVoltar.handle(event)
        composer.gotoScene("Page04", {effect = "fromLeft", time = 1000})
    end

    btnVoltar:addEventListener('tap', btnVoltar.handle)

    -- Botão para ir para a Page06
    local btnAvancar = display.newImageRect(sceneGroup, "assets/images/btnAvancar.png", 141, 50)
    btnAvancar.x = 662
    btnAvancar.y = 963

    function btnAvancar.handle(event)
        composer.gotoScene("Page06", {effect = "fromRight", time = 1000})
    end

    btnAvancar:addEventListener('tap', btnAvancar.handle)

    -- Botão para ligar e desligar o som
    local button = display.newImageRect(sceneGroup, "assets/images/btnSoundOff.png", 136, 70) -- Começa com som desligado
    button.x = 670
    button.y = 65

    -- Variável para controlar o estado do som
    local somLigado = false  -- Começa com som desligado

    -- Carrega o som da Page07
    local somPage07 = audio.loadSound("assets/sounds/page05.mp3")

    -- Variável para controlar o canal de som
    local somChannel

    -- Função para ligar e desligar o som
    local function toggleSound()
        if somLigado then
            -- Desliga o som
            somLigado = false
            button.fill = { type = "image", filename = "assets/images/btnSoundOff.png" }
            if somChannel then
                audio.pause(somChannel)
            end
        else
            -- Liga o som
            somLigado = true
            button.fill = { type = "image", filename = "assets/images/btnSoundOn.png" }
            somChannel = audio.play(somPage07, { loops = -1 })  -- Toca em loop
        end
    end

    button:addEventListener("tap", toggleSound)
end

-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then

    end
end

-- hide()
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then

    end
end

-- destroy()
function scene:destroy(event)
    local sceneGroup = self.view
    
    sceneGroup:removeSelf()
    sceneGroup = nil
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene
