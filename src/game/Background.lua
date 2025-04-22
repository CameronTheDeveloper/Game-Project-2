local Class = require "hump.class"

local bgGround1 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/1.png")
local bgGround2 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/2.png")
local bgGround3 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/3.png")
local bgGround4 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/4.png")
local bgGround5 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/5.png")
local bgGround6 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/6.png")
local bgGround7 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/7.png")

local Background = Class{}
function Background:init()
    self.bgCloudPos = 0
    self.bgGroundPos = 0
    self.bgWidth = bgClouds:getWidth() -- 853
    self.bgSpeed = 30
end

function Background:update(dt)
    self.bgCloudPos = (self.bgCloudPos+self.bgSpeed*dt)%self.bgWidth
    self.bgGroundPos = (self.bgGroundPos+self.bgSpeed*2*dt)%self.bgWidth
end

function Background:drawBackground()
    love.graphics.draw(bgClouds,-self.bgCloudPos,0)
    love.graphics.draw(bgClouds,self.bgWidth-self.bgCloudPos,0)
end

function Background:drawForeground()
    love.graphics.draw(bgGround,-self.bgGroundPos,0)
    love.graphics.draw(bgGround,self.bgWidth-self.bgGroundPos,0)
end


return Background