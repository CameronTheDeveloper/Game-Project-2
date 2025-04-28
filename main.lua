local Globals = require "src.Globals"
local Push = require "libs.push"
local Car = require "src.game.Player"
local Stage = require "src.game.stages.Stage"
local Sounds = require "src.game.Sounds"
local Background = require "src.game.Background"
local HUD = require "src.game.HUD"


local titleFont = love.graphics.newFont("fonts/Abaddon_Bold.ttf",65)
local titleFont2 = love.graphics.newFont("fonts/Abaddon_Bold.ttf",35)

local bg = Background()
local player
local hud
local stage
local tileSize




-- local HUD = require "src.game.HUD."

function love.load()
    math.randomseed(os.time())
    love.window.setTitle("Drive,Dodge,Dash!!!")
    Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})

    sounds = {} -- create an empty table
    sounds['music'] = love.audio.newSource("sounds/Background_music/Juhani Junkala [Retro Game Music Pack] Level 1.wav","static")
    sounds['music2'] = love.audio.newSource("sounds/Background_music/Juhani Junkala [Retro Game Music Pack] Level 2.wav","static")
    sounds['music3'] = love.audio.newSource("sounds/Menu_music/ElevatorMusic.wav","static")
    sounds['music4'] = love.audio.newSource("sounds/Menu_music/Juhani Junkala [Retro Game Music Pack] Ending.wav","static")
    sounds["music"]:setLooping(true)
    love.audio.setVolume(0.25)
    sounds["music"]:play()

    player = Car(1, bg.roadTop, bg.roadBottom) -- 1 = green car
    hud = HUD(player)
    local tileImage = love.graphics.newImage("graphics/tilesets/tile/Winter_road.png")

    stage = Stage(10, 15, player, bg, {
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
        sounds["music2"]:stop()
        sounds['music3']:setLooping(true)
        sounds['music3']:play()
    elseif key == "p" and gameState=="pause" then
        gameState = "play"
        sounds['music3']:stop()
        sounds['music2']:setLooping(true)
        sounds['music2']:play()
    elseif key == "return" and gameState=="start" then
        gameState = "play"
        sounds["music"]:stop()
        sounds['music2']:setLooping(true)
        sounds['music2']:play()
    elseif key == "c" and gameState=="start" then
        gameState = "cars"
    elseif key == "e" and gameState=="cars" then
        gameState = "start"
        sounds["music"]:setLooping(true)
        sounds["music"]:play()
    elseif key == "r" and gameState=="pause" then
        gameState = "start"
        player:reset()
        stage:resetStage()
        sounds['music3']:stop()
        sounds["music"]:setLooping(true)
        sounds["music"]:play()
    elseif key == "e" and gameState=="pause" then
        love.event.quit()
    elseif key == "e" and gameState=="start" then
        love.event.quit()
    elseif key == "r" and gameState=="over" then
        gameState = "start"
        player:reset()
        stage:resetStage()
        sounds["music4"]:stop()
        sounds["music"]:setLooping(true)
        sounds["music"]:play()
    elseif key == "e" and gameState=="over" then
        love.event.quit()
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

    if button == 1 then 
        if gameState == "start" then
            bg:mouseClicked(gx, gy)
        elseif gameState == "play" then
            
        end
    end
    
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
        sounds["music2"]:stop()
        sounds['music4']:setLooping(true)
        sounds['music4']:play()
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
    bg:drawMapBackground()
    bg:drawBackobjground2()
    bg:drawPlayBackground()
    bg:drawBackobjground()
    bg:drawHudground()
    stage:draw()
    player:draw()
    hud:draw()
    
end

function drawStartState()
    bg:drawMenuground()
    love.graphics.setColor(1,0,0)
    love.graphics.printf("Drive,\nDodge,\nDash!!!", titleFont,0,20,gameWidth,"center")
    love.graphics.setColor(1,1,1)
    love.graphics.printf("Start", titleFont2,0,270,gameWidth,"center")
    love.graphics.printf("Cars", titleFont2,0,340,gameWidth,"center")
    love.graphics.printf("Exit", titleFont2,0,410,gameWidth,"center")

end

function drawGameOverState()
    love.graphics.setColor(0.3,0.3,0.3)
    if bg then bg:drawEndGameGround() end
    love.graphics.setColor(1,1,1)
    bg:drawOverground()
    love.graphics.printf("Restart", titleFont2,0,270,gameWidth,"center")
    love.graphics.printf("Exit", titleFont2,0,340,gameWidth,"center")
    love.graphics.setColor(1,0,0)
    love.graphics.printf("Game Over", titleFont,0,100,gameWidth,"center")
    love.graphics.printf("Highscore: "..player.score, titleFont2,0,160,gameWidth,"center")
end

function drawPauseState()
    love.graphics.setColor(0.3,0.3,0.3)
    if bg then bg:drawEndGameGround() end
    love.graphics.setColor(1,1,1)
    bg:drawPauseground()
    love.graphics.printf("Resume", titleFont2,0,270,gameWidth,"center")
    love.graphics.printf("Exit", titleFont2,0,340,gameWidth,"center")
    love.graphics.setColor(1,0,0)
    love.graphics.printf("Game Paused", titleFont,0,100,gameWidth,"center")
end

function drawCarSelectState()
    if bg then bg:drawCarground() end
    love.graphics.setColor(0,0,1)
    love.graphics.printf("Select", titleFont2,0,340,gameWidth,"center")
    love.graphics.printf("Leave", titleFont2,0,410,gameWidth,"center")
end
