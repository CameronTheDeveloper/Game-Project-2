local Class = require "hump.class"
local carSprites = {}

-- Check paths
carSprites[1] = love.graphics.newImage("../graphics/cars/sports_green.png")
carSprites[2] = love.graphics.newImage("../graphics/cars/sports_red.png")
carSprites[3] = love.graphics.newImage("../graphics/cars/sports_yellow.png")

local Car = class{}

function Car:init(spriteIndex)
    self.x = 0
    self.y = 0
    self.timeElapsed = 0
    self.spriteIndex = spriteIndex or 1 -- Default value
    self.score = 0
    self.scoreRate = 1
    self.timeElapsed = 0
end

function Car:update(dt)
    self.timeElapsed = self.timeElapsed + dt

    -- Add score every second (or fraction thereof)
    self.score = self.score + self.scoreRate * dt
end

function Car:draw()
    love.graphics.draw(carSprites[self.spriteIndex], self.x, self.y)
end

return Car