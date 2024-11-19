local composer = require("composer")
local scene = composer.newScene()

-- create()
function scene:create(event)
    local sceneGroup = self.view

    -- Carrega a imagem da Page04
    local imgCapa = display.newImageRect(sceneGroup, "assets/images/Page04.png", display.contentWidth, display.contentHeight)
    imgCapa.x = display.contentCenterX
    imgCapa.y = display.contentCenterY

    -- Adiciona a imagem "paciente.png"
    local imgPaciente = display.newImageRect(sceneGroup, "assets/images/paciente.png", 252, 252)
    imgPaciente.x = 380
    imgPaciente.y = 790

    -- Adiciona a imagem "ajudante.png"
    local imgAjudante = display.newImageRect(sceneGroup, "assets/images/ajudante.png", 252, 252)
    imgAjudante.x = 380
    imgAjudante.y = 780

    -- Adiciona a imagem "status1.png"
    local imgStatus = display.newImageRect(sceneGroup, "assets/images/status1.png", 300, 15)
    imgStatus.x = 380
    imgStatus.y = 684

    -- Adiciona os botões 
    local botao1 = display.newImageRect(sceneGroup, "assets/images/botao.png", 80, 80)
    botao1.x = 175
    botao1.y = 770

    local botao2 = display.newImageRect(sceneGroup, "assets/images/botao.png", 80, 80)
    botao2.x = 540
    botao2.y = 770

    -- Contadores de toques para cada botão
local contadorBotao1 = 0
local contadorBotao2 = 0

-- Função para atualizar a barra de status com base no contador total
local function atualizarStatus()
    local totalToques = contadorBotao1 + contadorBotao2

    if totalToques == 2 then
        imgStatus.fill = { type = "image", filename = "assets/images/status2.png" }
    elseif totalToques == 4 then
        imgStatus.fill = { type = "image", filename = "assets/images/status3.png" }
    end
end

-- Função para tratar os toques no botão 1
local function handleBotao1(event)
    contadorBotao1 = contadorBotao1 + 1
    atualizarStatus()
end

-- Função para tratar os toques no botão 2
local function handleBotao2(event)
    contadorBotao2 = contadorBotao2 + 1
    atualizarStatus()
end

-- Adiciona os ouvintes de evento aos botões
botao1:addEventListener("tap", handleBotao1)
botao2:addEventListener("tap", handleBotao2)

    -- Botão para voltar para a Page03
    local btnVoltar = display.newImageRect(sceneGroup, "assets/images/btnVoltar.png", 141, 50)
    btnVoltar.x = 100
    btnVoltar.y = 963

    function btnVoltar.handle(event)
        composer.gotoScene("Page03", { effect = "fromLeft", time = 1000 })
    end

    btnVoltar:addEventListener("tap", btnVoltar.handle)

    -- Botão para ir para a Page05
    local btnAvancar = display.newImageRect(sceneGroup, "assets/images/btnAvancar.png", 141, 50)
    btnAvancar.x = 662
    btnAvancar.y = 963

    function btnAvancar.handle(event)
        composer.gotoScene("Page05", { effect = "fromRight", time = 1000 })
    end

    btnAvancar:addEventListener("tap", btnAvancar.handle)

    -- Botão para ligar e desligar o som
    local button = display.newImageRect(sceneGroup, "assets/images/btnSoundOff.png", 136, 70) -- Começa com som desligado
    button.x = 670
    button.y = 65

    -- Variável para controlar o estado do som
    local somLigado = false  -- Começa com som desligado

    -- Carrega o som da Page06
    local somPage06 = audio.loadSound("assets/sounds/page04.mp3")

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
            somChannel = audio.play(somPage06, { loops = -1 })  -- Toca em loop
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
