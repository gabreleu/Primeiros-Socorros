local composer = require("composer")
local scene = composer.newScene()

-- Variáveis globais para controle de som entre as cenas
local somLigado = false
local somChannel

-- create()
function scene:create(event)
    local sceneGroup = self.view

    -- Carrega a imagem da Page05
    local imgCapa = display.newImageRect(sceneGroup, "assets/images/Page05.png", display.contentWidth, display.contentHeight)
    imgCapa.x = display.contentCenterX
    imgCapa.y = display.contentCenterY

    -- Adiciona a imagem ajudante.png
    local p1 = display.newImageRect(sceneGroup, "assets/images/ajudante.png", 250, 250)
    p1.x = 400
    p1.y = 800

    -- Adiciona a imagem paciente.png
    local p2 = display.newImageRect(sceneGroup, "assets/images/paciente.png", 250, 250)
    p2.x = 400
    p2.y = 820

    -- Botão de som
    local button = display.newImageRect(sceneGroup, "assets/images/btnSoundOff.png", 136, 70)
    button.x = 670
    button.y = 65

    -- Carrega o som para a cena atual
    local somPage05 = audio.loadSound("assets/images/sounds/page05.mp3")

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
            somChannel = audio.play(somPage05, { loops = -1 })
        end
    end

    button:addEventListener("tap", toggleSound)
    self.soundButton = button

    -- Botões de navegação
    local btnVoltar = display.newImageRect(sceneGroup, "assets/images/btnVoltar.png", 141, 50)
    btnVoltar.x = 100
    btnVoltar.y = 963
    function btnVoltar.handle(event)
        composer.gotoScene("Page04", { effect = "fromLeft", time = 1000 })
    end
    btnVoltar:addEventListener("tap", btnVoltar.handle)

    local btnAvancar = display.newImageRect(sceneGroup, "assets/images/btnAvancar.png", 141, 50)
    btnAvancar.x = 662
    btnAvancar.y = 963
    function btnAvancar.handle(event)
        composer.gotoScene("Page06", { effect = "fromRight", time = 1000 })
    end
    btnAvancar:addEventListener("tap", btnAvancar.handle)
end

-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Preparações antes de mostrar a cena
    elseif (phase == "did") then
        -- Quando a cena está totalmente visível
    end
end

-- hide()
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Antes de esconder a cena
    elseif (phase == "did") then
        -- Quando a cena está oculta, desliga o som
        if somLigado then
            somLigado = false
            self.soundButton.fill = { type = "image", filename = "assets/images/btnSoundOff.png" }
            if somChannel then
                audio.pause(somChannel)
            end
        end
    end
end

-- destroy()
function scene:destroy(event)
    local sceneGroup = self.view

    -- Libera recursos carregados
    if somChannel then
        audio.dispose(somChannel)
        somChannel = nil
    end
end

-- Scene event function listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
