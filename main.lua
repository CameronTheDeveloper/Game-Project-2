local Globals = require "src.Globals"
local Push = require "libs.push"
local Car = require "src.game.Player"
local Stage = require "src.game.stages.Stage"
local Sounds = require "src.game.Sounds"
local Background = require "src.game.Background"

local bg = Background()
local player
local stage
local tileSize


local titleFont = love.graphics.newFont("fonts/Abaddon_Bold.ttf",26)

-- local HUD = require "src.game.HUD."

function love.load()
    math.randomseed(os.time())
    love.window.setTitle("Drive,Dodge,Dash!!!")
    Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
        fullscreen = false, 
        resizable = true
    })

    player = Car(1) -- 1 = green car
    local tileImage = love.graphics.newImage("graphics/tilesets/tile/Winter_road.png")

    stage = Stage(10, 15, player, {
        tileSize = 64,
        getImage = function()
            return tileImage
        end
    })

    player.stageHeight = stage:getHeight()
    player.stageWidth = stage:getWidth()

    
    -- tileSize = stage:getTileSize()
    -- Set the window size to match the stage
    -- love.window.setMode(stage:getWidth(), stage:getHeight())
end

function love.update(dt)
    if gameState == "play" then
        player:update(dt)
        stage:update(dt)
    end
end



function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "p" and gameState=="play" then
        gameState = "pause"
    elseif key == "p" and gameState=="pause" then
        gameState = "play"
    elseif key == "return" and gameState~="play" then
        gameState = "play"
    end
end


-- function love.draw()
--     stage:draw()
--     player:draw()
-- end

-- function love.load()
--     love.window.setTitle("Drive,Dodge,Dash!!!")
--     Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})
--     math.randomseed(os.time())

--     player = Player(0,0)
--     -- hud = HUD(player)

--     stagemanager:setPlayer(player)

--     titleFont = love.graphics.newFont("fonts/Weiholmir_full_sheet.ttf",26)

-- end

function love.resize(w,h)
    Push:resize(w,h)
end


function love.mousepressed(x, y, button, istouch)
    gx, gy = Push:toGame(x,y)
    -- Handle clicks based on gameState here
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

    -- stagemanager:currentStage():draw()

    -- hud:draw()

    bg:drawBackground()
    bg:drawForeground()
    stage:draw()
    player:draw()
    
end

function drawStartState()
    if bg then bg:drawMenuground() end
    love.graphics.setColor(1,0,0)
    love.graphics.printf("Drive,\nDodge,\nDash!!!", titleFont,0,20,gameWidth,"center")
    love.graphics.setColor(1,1,1)
    love.graphics.printf("Start", 0,120,gameWidth,"center")
    love.graphics.printf("Cars", 0,140,gameWidth,"center")
    love.graphics.printf("Exit", 0,160,gameWidth,"center")

end

function drawGameOverState()
    love.graphics.setColor(0.3,0.3,0.3)
    if bg then bg:drawGameground() end
    love.graphics.setColor(0,0,1)
    love.graphics.printf("Game Over", titleFont,0,20,gameWidth,"center")
end

function drawPauseState()
    love.graphics.setColor(0.3,0.3,0.3)
    if bg then bg:drawGameground() end 
    love.graphics.setColor(0,0,1)
    love.graphics.printf("Game Paused", titleFont,0,20,gameWidth,"center")
end

function drawCarSelectState()
    if bg then bg:drawCarground() end
    love.graphics.setColor(0,0,1)
    love.graphics.printf("Game Paused", titleFont,0,20,gameWidth,"center")
end
