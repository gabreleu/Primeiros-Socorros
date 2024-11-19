local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Carrega a imagem da Page06
    local imgCapa = display.newImageRect(sceneGroup, "assets/images/Page06.png", display.contentWidth, display.contentHeight)
    imgCapa.x = display.contentCenterX
    imgCapa.y = display.contentCenterY

    -- Adiciona a imagem "desmaiado.png"
    local imgEstado = display.newImageRect(sceneGroup, "assets/images/desmaiado.png", 200, 200)
    imgEstado.x = 350
    imgEstado.y = 800

    -- Variável de estado para controlar a imagem que será exibida
    local estadoAtual = "desmaiado"  -- Pode ser 'desmaiado', 'tonto' ou 'recuperado'

    -- Função para trocar a imagem com base no estado
    local function trocarEstado()
        if estadoAtual == "desmaiado" then
            imgEstado:removeSelf()  -- Remove a imagem atual
            imgEstado = display.newImageRect(sceneGroup, "assets/images/tonto.png", 200, 200)
            imgEstado.x = 380
            imgEstado.y = 830
            estadoAtual = "tonto"
        elseif estadoAtual == "tonto" then
            imgEstado:removeSelf()
            imgEstado = display.newImageRect(sceneGroup, "assets/images/recuperado.png", 200, 200)
            imgEstado.x = 380
            imgEstado.y = 830
            estadoAtual = "recuperado"
        else
            imgEstado:removeSelf()
            imgEstado = display.newImageRect(sceneGroup, "assets/images/desmaiado.png", 200, 200)
            imgEstado.x = 380
            imgEstado.y = 830
            estadoAtual = "desmaiado"
        end
    end

    -- Detecta o movimento do acelerômetro
    local function onShake(event)
        if event.isShake then
            trocarEstado()
        end
    end

    -- Inicia o listener para o acelerômetro
    Runtime:addEventListener("accelerometer", onShake)

    -- Botão para voltar para a Page05
    local btnVoltar = display.newImageRect(sceneGroup, "assets/images/btnVoltar.png", 141, 50)
    btnVoltar.x = 100
    btnVoltar.y = 963
    function btnVoltar.handle(event)
        composer.gotoScene("Page05", {effect = "fromLeft", time = 1000})
    end
    btnVoltar:addEventListener('tap', btnVoltar.handle)

    -- Botão para ir para a ContraCapa
    local btnAvancar = display.newImageRect(sceneGroup, "assets/images/btnAvancar.png", 141, 50)
    btnAvancar.x = 662
    btnAvancar.y = 963
    function btnAvancar.handle(event)
        composer.gotoScene("ContraCapa", {effect = "fromRight", time = 1000})
    end
    btnAvancar:addEventListener('tap', btnAvancar.handle)

    -- Função para ligar e desligar o som
    local button = display.newImageRect(sceneGroup, "assets/images/btnSoundOn.png", 136, 70)
    button.x = 670
    button.y = 65
    local somLigado = true

    -- Carrega o som da Page08
    local somPage08 = audio.loadSound("assets/sounds/page06.mp3")

    -- Variável para controlar o canal de som
    local somChannel

    -- Função para ligar e desligar o som
    local function toggleSound()
        if somLigado then
            somLigado = false
            button.fill = { type="image", filename="assets/images/btnSoundOff.png" }
            if somChannel then
                audio.pause(somChannel)
            end
        else
            somLigado = true
            button.fill = { type="image", filename="assets/images/btnSoundOn.png" }
            somChannel = audio.play(somPage08, { loops = -1 })  -- Toca em loop
        end
    end
    button:addEventListener("tap", toggleSound)
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
