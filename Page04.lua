local composer = require("composer")

local scene = composer.newScene()

-- create()
function scene:create(event)
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    --Carrega a imagem da Page04
    local imgCapa = display.newImageRect(sceneGroup, "assets/images/Page04.png", display.contentWidth, display.contentHeight)
    imgCapa.x = display.contentCenterX
    imgCapa.y = display.contentCenterY

-------

    --Botão para voltar para a Page03
    local btnVoltar = display.newImageRect(sceneGroup, "assets/images/btnVoltar.png", 141, 50)
    btnVoltar.x = 100
    btnVoltar.y = 963

    function btnVoltar.handle(event)
        composer.gotoScene("Page03", {effect = "fromLeft", time = 1000})
    end

    btnVoltar:addEventListener('tap', btnVoltar.handle)

------- 


    --Botão para ir para a Page05
    local btnAvancar = display.newImageRect(sceneGroup, "assets/images/btnAvancar.png", 141, 50)
    btnAvancar.x = 662
    btnAvancar.y = 963

    function btnAvancar.handle(event)
        composer.gotoScene("Page05", {effect = "fromRight", time = 1000})
    end

    btnAvancar:addEventListener('tap', btnAvancar.handle)

---------

    --Botão para ligar e desligar o som
    local button = display.newImageRect(sceneGroup, "assets/images/btnSoundOn.png", 50, 50)
    button.x = 708
    button.y = 50

    --Variável para controlar o estado do som
    local somLigado = true  --Começa com som ligado

    --Função para ligar e desligar o som
    local function toggleSound()
        if somLigado then
            --Desliga o som
            somLigado = false
            button.fill = { type="image", filename="assets/images/btnSoundOff.png" }  --Muda a imagem para som desligado
        else
            --Liga o som
            somLigado = true
            button.fill = { type="image", filename="assets/images/btnSoundOn.png" }  --Muda a imagem para som ligado
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
