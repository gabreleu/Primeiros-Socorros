local composer = require("composer")

local scene = composer.newScene()

-- Variáveis globais para controle de som entre as cenas
local somLigado = false
local somChannel

-- create()
function scene:create(event)
    local sceneGroup = self.view

    -- Carrega a imagem da Page05
    local imgCapa = display.newImageRect(sceneGroup, "assets/images/Page04.png", display.contentWidth, display.contentHeight)
    imgCapa.x = display.contentCenterX
    imgCapa.y = display.contentCenterY

    -- Adiciona a imagem "injury.png" na cena
    local imgInjury = display.newImageRect(sceneGroup, "assets/images/injury.png", 240, 240)
    imgInjury.x = 200
    imgInjury.y = 750

    -- Adiciona a imagem "sabao.png" na cena
    local imgSabao = display.newImageRect(sceneGroup, "assets/images/sabao.png", 106, 106)
    imgSabao.x = 525
    imgSabao.y = 680

    -- Adiciona a imagem "curativo.png" na cena
    local imgCurativo = display.newImageRect(sceneGroup, "assets/images/curativo.png", 106, 106)
    imgCurativo.x = 534
    imgCurativo.y = 802

    -- Variáveis para verificar se ambos os itens foram usados
    local sabaoUsado = false
    local curativoUsado = false

    -- Função para verificar se ambos os itens foram usados
    local function checkHealing()
        if sabaoUsado and curativoUsado then
            -- Remove a imagem de "injury.png" e coloca "curado.png" na nova posição
            imgInjury.fill = { type = "image", filename = "assets/images/curado.png" }
            imgInjury.x = 400  -- Define a nova posição x
            imgInjury.y = 780  -- Define a nova posição y
        end
    end

    -- Função para arrastar o sabão
    local function dragSabao(event)
        if (event.phase == "began") then
            display.currentStage:setFocus(event.target)
            event.target.isFocus = true
            event.target.startMoveX = event.target.x
            event.target.startMoveY = event.target.y
        elseif (event.phase == "moved") then
            if event.target.isFocus then
                event.target.x = event.x
                event.target.y = event.y
            end
        elseif (event.phase == "ended" or event.phase == "cancelled") then
            if event.target.isFocus then
                display.currentStage:setFocus(nil)
                event.target.isFocus = false
                -- Verifica se o sabão está em cima da "injury.png"
                if (math.abs(event.target.x - imgInjury.x) < 50 and math.abs(event.target.y - imgInjury.y) < 50) then
                    event.target:removeSelf()
                    sabaoUsado = true
                    checkHealing()  -- Verifica se ambos os itens foram usados
                else
                    event.target.x = event.target.startMoveX
                    event.target.y = event.target.startMoveY
                end
            end
        end
        return true
    end

    -- Função para arrastar o curativo
    local function dragCurativo(event)
        if (event.phase == "began") then
            display.currentStage:setFocus(event.target)
            event.target.isFocus = true
            event.target.startMoveX = event.target.x
            event.target.startMoveY = event.target.y
        elseif (event.phase == "moved") then
            if event.target.isFocus then
                event.target.x = event.x
                event.target.y = event.y
            end
        elseif (event.phase == "ended" or event.phase == "cancelled") then
            if event.target.isFocus then
                display.currentStage:setFocus(nil)
                event.target.isFocus = false
                -- Verifica se o curativo está em cima da "injury.png"
                if (math.abs(event.target.x - imgInjury.x) < 50 and math.abs(event.target.y - imgInjury.y) < 50) then
                    event.target:removeSelf()
                    curativoUsado = true
                    checkHealing()  -- Verifica se ambos os itens foram usados
                else
                    event.target.x = event.target.startMoveX
                    event.target.y = event.target.startMoveY
                end
            end
        end
        return true
    end

    -- Adiciona listeners de toque para arrastar as imagens
    imgSabao:addEventListener("touch", dragSabao)
    imgCurativo:addEventListener("touch", dragCurativo)

    -- Botão para voltar para a Page04
    local btnVoltar = display.newImageRect(sceneGroup, "assets/images/btnVoltar.png", 141, 50)
    btnVoltar.x = 100
    btnVoltar.y = 963

    function btnVoltar.handle(event)
        composer.gotoScene("Page03", {effect = "fromLeft", time = 1000})
    end

    btnVoltar:addEventListener('tap', btnVoltar.handle)

    -- Botão para ir para a Page06
    local btnAvancar = display.newImageRect(sceneGroup, "assets/images/btnAvancar.png", 141, 50)
    btnAvancar.x = 662
    btnAvancar.y = 963

    function btnAvancar.handle(event)
        composer.gotoScene("Page05", {effect = "fromRight", time = 1000})
    end

    btnAvancar:addEventListener('tap', btnAvancar.handle)

    -- Botão para ligar e desligar o som
    local button = display.newImageRect(sceneGroup, "assets/images/btnSoundOff.png", 136, 70)  -- Começa com som desligado
    button.x = 670
    button.y = 65

    -- Carrega o som da página 03
    local somCapa = audio.loadSound("assets/images/sounds/page04.mp3")

    
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
self.soundButton = button
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
        -- Quando a cena está oculta
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
