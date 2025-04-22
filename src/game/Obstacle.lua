local Class = require "hump.class"

-- Check paths
local obstacleSprite = love.graphics.newImage("../graphics/obj/towtruck.png")


local Obstacle = class{}

function Obstacle:init(spriteIndex){
    self.x = 0
    self.y = 0
    self.timeElapsed = 0
}

function Obstacle:update(dt){
    
}

function Obstacle:draw(){
    love.graphics.draw(obstacleSprite, self.x, self.y)
}

return Obstacle