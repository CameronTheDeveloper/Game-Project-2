local Class = require "libs.hump.class"
local carSprites = {}

-- Check paths
carSprites[1] = love.graphics.newImage("/graphics/cars/sports_green.png")
carSprites[2] = love.graphics.newImage("/graphics/cars/sports_red.png")
carSprites[3] = love.graphics.newImage("/graphics/cars/sports_yellow.png")

local Player = Class{}

function Player:init(spriteIndex, roadTop, roadBottom)
    self.x = 0
    self.y = roadTop + (roadBottom - roadTop) / 2 -- Center car on road
    self.timeElapsed = 0
    self.image = carSprites[spriteIndex or 1] -- Default value
    self.score = 0
    self.scoreRate = 1
    self.timeElapsed = 0
    self.speed = 100

    self.roadTop = roadTop
    self.roadBottom = roadBottom

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.stageWidth = nil
    self.stageHeight = nil

end


--Seperating function 
function Player:handlePlayerInput(dt)

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        self.x = math.max(0, self.x - self.speed * dt)
    end
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        self.x = math.min(self.stageWidth - self.width, self.x + self.speed * dt)
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        self.y = math.max(self.roadTop, self.y - self.speed * dt)
    end
    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        self.y = math.min(self.roadBottom - self.height, self.y + self.speed * dt)
    end
end

function Player:nextStage(stage)
    self.x = stage.initialPlayerX
    self.y = stage.initialPlayerY
end

function Player:update(dt)
    self.timeElapsed = self.timeElapsed + dt

    -- Add score every second (or fraction thereof)
    self.score = self.score + self.scoreRate * dt
    self:handlePlayerInput(dt)
end



function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Player:checkCollision(obstacle)
    local playerLeft = self.x
    local playerRight = self.x + self.image:getWidth()
    local playerTop = self.y
    local playerBottom = self.y + self.image:getHeight()

    local obstacleLeft = obstacle.x
    local obstacleRight = obstacle.x + obstacle.image:getWidth()
    local obstacleTop = obstacle.y
    local obstacleBottom = obstacle.y + obstacle.image:getHeight()

    -- Check if the boxes overlap
    if playerRight > obstacleLeft and playerLeft < obstacleRight and
       playerBottom > obstacleTop and playerTop < obstacleBottom then
        return true
    else
        return false
    end
end


return Player