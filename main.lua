-- Author: Justin

local Globals = require "src.Globals"
local Push = require "libs.push"
local Sounds = require "src.game.Sounds"
local Background = require "src.game.Background"
local Player = require "src.game.Player"
local HUD = require "src.game.HUD."

function love.load()
    love.window.setTitle("Drive,Dodge,Dash!!!")
    Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})
    math.randomseed(os.time())

    player = Player(0,0)
    hud = HUD(player)

    stagemanager:setPlayer(player)

    titleFont = love.graphics.newFont("fonts/Weiholmir_full_sheet.ttf",26)

end

function love.resize(w,h)
    Push:resize(w,h)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "F2" or key == "tab" then
        debugFlag = not debugFlag
    elseif key == "p" and gameState=="pause" then
        gameState = "pause"
    else 
        player:keypressed(key)
    end
end

function love.mousepressed(x, y, button, istouch)
    gx, gy = Push:toGame(x,y)

end

function love.update(dt)
    
end

function love.draw()
    Push:start()

    if gameState == "play" then -- Game
        drawPlayState()
    elseif gameState == "start" then -- Main menu
        drawStartState()
    elseif gameState == "pause" then
        drawPauseState()
    elseif gameState == "over" then
        drawGameOverState()
    elseif gameState == "cars" then
        drawCarSelectState()
    else
        love.graphics.setColor(1,1,0) -- Yellow
        love.graphics.printf("Error", 0,20,gameWidth, "center")
    end

    Push:finish()
end

function drawPlayState()

    stagemanager:currentStage():draw()

    hud:draw()

    bg:drawBackground()
    bg:drawForeground()

    player:draw()
end

function drawStartState()
    bg:drawMenuground()
    love.graphics.setColor(0,0,1)
    love.graphics.printf("Drive,\nDodge,\nDash!!!", titleFont,0,20,gameWidth,"center")
    love.graphics.setColor(0,0,0)
    love.graphics.printf("Start", 0,100,gameWidth,"center")
    love.graphics.printf("Cars", 0,120,gameWidth,"center")
    love.graphics.printf("Exit", 0,140,gameWidth,"center")

end

function drawGameOverState()
    love.graphics.setColor(0.3,0.3,0.3)
    bg:drawGameground()
    love.graphics.setColor(0,0,1)
    love.graphics.printf("Game Over", titleFont,0,20,gameWidth,"center")
end

function drawPauseState()
    love.graphics.setColor(0.3,0.3,0.3)
    bg:drawGameground()
    love.graphics.setColor(0,0,1)
    love.graphics.printf("Game Paused", titleFont,0,20,gameWidth,"center")
end

function drawCarSelectState()
    bg:drawCarground()
    love.graphics.setColor(0,0,1)
    love.graphics.printf("Game Paused", titleFont,0,20,gameWidth,"center")
end
