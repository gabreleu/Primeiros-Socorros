local composer = require("composer")
local scene = composer.newScene()

-- create()
function scene:create(event)
    local sceneGroup = self.view

    -- Carrega a imagem de fundo
    local imgCapa = display.newImageRect(sceneGroup, "assets/images/Page06.png", display.contentWidth, display.contentHeight)
    imgCapa.x = display.contentCenterX
    imgCapa.y = display.contentCenterY

    -- Adiciona queimadura.png
    local queimadura = display.newImageRect(sceneGroup, "assets/images/queimadura.png", 140, 140)
    queimadura.x = 350
    queimadura.y = 820

    -- Adiciona chorando.png
    local chorando = display.newImageRect(sceneGroup, "assets/images/chorando.png", 120, 120)
    chorando.x = 100
    chorando.y = 780

    -- Adiciona chuveiro.png
    local chuveiro = display.newImageRect(sceneGroup, "assets/images/chuveiro.png", 150, 70)
    chuveiro.x = 600
    chuveiro.y = 750

    -- Botões de navegação
    local btnVoltar = display.newImageRect(sceneGroup, "assets/images/btnVoltar.png", 141, 50)
    btnVoltar.x = 100
    btnVoltar.y = 963

    function btnVoltar.handle(event)
        composer.gotoScene("Page05", { effect = "fromLeft", time = 1000 })
    end
    btnVoltar:addEventListener("tap", btnVoltar.handle)

    local btnAvancar = display.newImageRect(sceneGroup, "assets/images/btnAvancar.png", 141, 50)
    btnAvancar.x = 662
    btnAvancar.y = 963

    function btnAvancar.handle(event)
        composer.gotoScene("Page07", { effect = "fromRight", time = 1000 })
    end
    btnAvancar:addEventListener("tap", btnAvancar.handle)

    -- Função para ligar e desligar o som
    local button = display.newImageRect(sceneGroup, "assets/images/btnSoundOff.png", 136, 70)
    button.x = 670
    button.y = 65
    local somLigado = false

    -- Carrega o som
    local somPage06 = audio.loadSound("assets/images/sounds/page06.mp3")

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

    -- Função para verificar colisão
    local function verificarColisao(obj1, obj2)
        local distancia = math.sqrt((obj1.x - obj2.x)^2 + (obj1.y - obj2.y)^2)
        local limite = (obj1.width / 2) + (obj2.width / 2)
        return distancia < limite
    end

    -- Variável para controlar as gotas
    local gotas = {}
    local timerGotas

    -- Função para criar gotas
    local function criarGota()
        local gota = display.newImageRect(sceneGroup, "assets/images/gota.png", 30, 30)
        gota.x = chuveiro.x + math.random(-50, 50)
        gota.y = chuveiro.y

        transition.to(gota, { y = queimadura.y + 50, time = 1500, onComplete = function()
            if verificarColisao(gota, queimadura) then
                queimadura.fill = { type = "image", filename = "assets/images/saudavel.png" }
                chorando.fill = { type = "image", filename = "assets/images/semchorar.png" }
            end
            display.remove(gota)
        end })

        table.insert(gotas, gota)
    end

    -- Função para iniciar ou parar as gotas
    local function controlarGotas(ativar)
        if ativar then
            if not timerGotas then
                timerGotas = timer.performWithDelay(300, criarGota, 0) -- Frequência maior
            end
        else
            if timerGotas then
                timer.cancel(timerGotas)
                timerGotas = nil
            end
            queimadura.fill = { type = "image", filename = "assets/images/queimadura.png" }
            chorando.fill = { type = "image", filename = "assets/images/chorando.png" }
        end
    end

    -- Movimentação de queimadura.png
    local function moverQueimadura(event)
        if event.phase == "began" then
            display.currentStage:setFocus(event.target)
            event.target.isFocus = true
            event.target.x0 = event.x - event.target.x
            event.target.y0 = event.y - event.target.y
        elseif event.phase == "moved" and event.target.isFocus then
            event.target.x = event.x - event.target.x0
            event.target.y = event.y - event.target.y0
        elseif event.phase == "ended" or event.phase == "cancelled" then
            display.currentStage:setFocus(nil)
            event.target.isFocus = false
        end
        return true
    end

    queimadura:addEventListener("touch", moverQueimadura)

    -- Verifica a posição do queimadura.png
    local function verificarPosicao()
        if verificarColisao(queimadura, chuveiro) then
            controlarGotas(true)
        else
            controlarGotas(false)
        end
    end
    Runtime:addEventListener("enterFrame", verificarPosicao)

    -- Função para pausar o som ao mudar de cena
    function scene:hide(event)
        if event.phase == "will" then
            if somChannel then
                audio.pause(somChannel)
                somLigado = false
                button.fill = { type = "image", filename = "assets/images/btnSoundOff.png" }
            end
        end
    end

    -- Adiciona o listener para o evento de troca de cena
    scene:addEventListener("hide", scene)
end

scene:addEventListener("create", scene)
return scene
