local C = require('Constants')
local composer = require("composer")

local scene = composer.newScene()

-- create()
function scene:create(event)
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Carrega a imagem da ContraCapa
    local imgContraCapa = display.newImageRect(sceneGroup, "assets/images/Contracapa.png", display.contentWidth, display.contentHeight)
    imgContraCapa.x = display.contentCenterX
    imgContraCapa.y = display.contentCenterY

    -- Botão para voltar para a Capa
    local btnVoltar = display.newImageRect(sceneGroup, "assets/images/btnVoltar.png", 141, 50)
    btnVoltar.x = 100
    btnVoltar.y = 963

    function btnVoltar.handle(event)
        composer.gotoScene("Page07", {effect = "fromLeft", time = 1000})
    end

    btnVoltar:addEventListener('tap', btnVoltar.handle)

    -- Botão para voltar para a Capa
    local btnInicio = display.newImageRect(sceneGroup, "assets/images/btnInicio.png", 141, 50)
    btnInicio.x = 662
    btnInicio.y = 963

    function btnInicio.handle(event)
        composer.gotoScene("Capa", {effect = "fromLeft", time = 1000})
    end

    btnInicio:addEventListener('tap', btnInicio.handle)

    -- Botão para ligar e desligar o som
    local soundButton = display.newImageRect(sceneGroup, "assets/images/btnSoundOff.png", 136, 70)  -- Começa com som desligado
    soundButton.x = 670
    soundButton.y = 65

    -- Variável para controlar o estado do som
    local somLigado = false  -- Começa com som desligado

    -- Carrega o som da contra capa
    local somCapa = audio.loadSound("assets/images/sounds/contracapa.mp3")

    -- Toca o som inicialmente (não toca até o usuário clicar no botão)
    local somChannel

    -- Função para ligar e desligar o som
    local function toggleSound()
        if somLigado then
            -- Desliga o som
            somLigado = false
            soundButton.fill = { type = "image", filename = "assets/images/btnSoundOff.png" }
            if somChannel then
                audio.pause(somChannel)
            end
        else
            -- Liga o som
            somLigado = true
            soundButton.fill = { type = "image", filename = "assets/images/btnSoundOn.png" }
            somChannel = audio.play(somCapa, { loops = -1 })  -- Toca em loop
        end
    end

    soundButton:addEventListener("tap", toggleSound)
end

-- hide()
function scene:hide(event)
    if event.phase == "will" then
        -- Aqui, ao sair da cena, o som será parado completamente
        if somChannel then
            audio.stop(somChannel)  -- Usar stop em vez de pause
            somLigado = false
            soundButton.fill = { type = "image", filename = "assets/images/btnSoundOff.png" }
        end
    end
end

-- destroy()
function scene:destroy(event)
    local sceneGroup = self.view

    -- Remover a cena
    sceneGroup:removeSelf()
    sceneGroup = nil

    -- Parar o som ao destruir a cena
    if somChannel then
        audio.stop(somChannel)  
    end
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
