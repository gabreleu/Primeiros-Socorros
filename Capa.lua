local composer = require("composer")

local scene = composer.newScene()

-- Variável global para controle do som entre as cenas
local somLigado = false
local somChannel

-- create()
function scene:create(event)
    local sceneGroup = self.view

    -- Carrega a imagem da Capa
    local imgCapa = display.newImageRect(sceneGroup, "assets/images/Capa.png", display.contentWidth, display.contentHeight)
    imgCapa.x = display.contentCenterX
    imgCapa.y = display.contentCenterY

    -- Botão para ir para a Page02
    local btnAvancar = display.newImageRect(sceneGroup, "assets/images/btnAvancar.png", 141, 50)
    btnAvancar.x = 662
    btnAvancar.y = 963

    function btnAvancar.handle(event)
        composer.gotoScene("Page01", { effect = "fromRight", time = 1000 })
    end

    btnAvancar:addEventListener("tap", btnAvancar.handle)

    -- Botão para ligar e desligar o som
    local button = display.newImageRect(sceneGroup, "assets/images/btnSoundOff.png", 136, 70) -- Começa com som desligado
    button.x = 670
    button.y = 65

    -- Carrega o som da capa
    local somCapa = audio.loadSound("assets/images/sounds/capa.mp3")

    -- Função para ligar e desligar o som
    local function toggleSound()
        if somLigado then
            -- Desliga o som
            somLigado = false
            button.fill = { type = "image", filename = "assets/images/btnSoundOff.png" } -- Atualiza para som desligado
            if somChannel then
                audio.pause(somChannel)
            end
        else
            -- Liga o som
            somLigado = true
            button.fill = { type = "image", filename = "assets/images/btnSoundOn.png" } -- Atualiza para som ligado
            somChannel = audio.play(somCapa, { loops = -1 }) -- Toca em loop
        end
    end

    button:addEventListener("tap", toggleSound)

    -- Salva o botão na cena para manipular no evento "hide"
    self.soundButton = button
end

-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Preparações para mostrar a cena
    elseif (phase == "did") then
        -- Cena está totalmente visível
    end
end

-- hide()
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Antes de esconder a cena
    elseif (phase == "did") then
        -- Quando a cena está oculta
        if somLigado then
            -- Desliga o som automaticamente
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
    end
end

-- Scene event function listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
