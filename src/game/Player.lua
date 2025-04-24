local Class = require "libs.hump.class"
local carSprites = {}

-- Check paths
carSprites[1] = love.graphics.newImage("/graphics/cars/sports_green.png")
carSprites[2] = love.graphics.newImage("/graphics/cars/sports_red.png")
carSprites[3] = love.graphics.newImage("/graphics/cars/sports_yellow.png")

local Player = Class{}

function Player:init(spriteIndex)
    self.x = 0
    self.y = 0
    self.timeElapsed = 0
    self.image = carSprites[spriteIndex or 1] -- Default value
    self.score = 0
    self.scoreRate = 1
    self.timeElapsed = 0
    self.speed = 100
end

function Player:update(dt)
    self.timeElapsed = self.timeElapsed + dt

    -- Add score every second (or fraction thereof)
    self.score = self.score + self.scoreRate * dt
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