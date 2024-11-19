local composer = require("composer")

local scene = composer.newScene()

-- create()
function scene:create(event)
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Carrega a imagem da Page02_2
    local imgCapa = display.newImageRect(sceneGroup, "assets/images/Page02_2.png", display.contentWidth, display.contentHeight)
    imgCapa.x = display.contentCenterX
    imgCapa.y = display.contentCenterY

    local imgHurt = display.newImageRect(sceneGroup, "assets/images/hurt.png", 196, 196)
    imgHurt.x = 395
    imgHurt.y = 800

    -- Função para alterar a imagem para "normal.png" ao clicar
    local function alterarImagem()
        imgHurt.fill = { type="image", filename="assets/images/normal.png" }  -- Troca a imagem de hurt para normal
    end

    -- Adiciona o evento de toque na imagem "hurt.png"
    imgHurt:addEventListener("tap", alterarImagem)

    -- Botão para voltar para a Page02_1
    local btnVoltar = display.newImageRect(sceneGroup, "assets/images/btnVoltar.png", 141, 50)
    btnVoltar.x = 100
    btnVoltar.y = 963

    function btnVoltar.handle(event)
        composer.gotoScene("Page02_1", {effect = "fromLeft", time = 1000})
    end

    btnVoltar:addEventListener('tap', btnVoltar.handle)

    -- Botão para ir para a Page03
    local btnAvancar = display.newImageRect(sceneGroup, "assets/images/btnAvancar.png", 141, 50)
    btnAvancar.x = 662
    btnAvancar.y = 963

    function btnAvancar.handle(event)
        composer.gotoScene("Page03", {effect = "fromRight", time = 1000})
    end

    btnAvancar:addEventListener('tap', btnAvancar.handle)

    -- Botão para ligar e desligar o som
    local button = display.newImageRect(sceneGroup, "assets/images/btnSoundOff.png", 136, 70)  -- Começa com som desligado
    button.x = 670
    button.y = 65

    -- Variável para controlar o estado do som
    local somLigado = false  -- Começa com som desligado

    -- Carrega o som da capa
    local somCapa = audio.loadSound("assets/sounds/Page02_2.mp3")

    -- Variável para controlar o canal de som
    local somChannel

    -- Função para ligar e desligar o som
    local function toggleSound()
        if somLigado then
            -- Desliga o som
            somLigado = false
            button.fill = { type="image", filename="assets/images/btnSoundOff.png" }  -- Muda a imagem para som desligado
            if somChannel then
                audio.pause(somChannel)
            end
        else
            -- Liga o som
            somLigado = true
            button.fill = { type="image", filename="assets/images/btnSoundOn.png" }  -- Muda a imagem para som ligado
            somChannel = audio.play(somCapa, { loops = -1 })  -- Toca em loop
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
-- -----------------------------------------------------
 return scene