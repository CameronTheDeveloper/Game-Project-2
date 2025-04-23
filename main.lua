local Car = require "src.game.Player"
local Stage = require "src.game.stages.Stage"
local player
local stage

function love.load()
    player = Car(1) -- 1 = green car
    stage = Stage(10, 15, {
        tileSize = 64,
        getImage = function()
            return love.graphics.newImage("graphics/tilesets/tile/Winter_road.png")
        end
    })

    -- Set the window size to match the stage
    love.window.setMode(stage:getWidth(), stage:getHeight())
end

function love.update(dt)
    handleInput(dt)
    player:update(dt)
    stage:update(dt)
end
function handleInput(dt)
    local speed = player.speed
    local tileSize = stage:getTileSize()
    local stageWidth = stage:getWidth()
    local stageHeight = stage:getHeight()
    local carWidth = player.image:getWidth()
    local carHeight = player.image:getHeight()

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        player.x = math.max(0, player.x - speed * dt)
    end
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        player.x = math.min(stageWidth - carWidth, player.x + speed * dt)
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        player.y = math.max(0, player.y - speed * dt)
    end
    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        player.y = math.min(stageHeight - carHeight, player.y + speed * dt)
    end
end


function love.draw()
    stage:draw()
    player:draw()
end
