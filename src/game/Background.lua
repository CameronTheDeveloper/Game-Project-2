local Class = require "hump.class"

local bgGround1 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/1.png")
local bgGround2 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/2.png")
local bgGround3 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/3.png")
local bgGround4 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/4.png")
local bgGround5 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/5.png")
local bgGround6 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/6.png")
local bgGround7 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/7.png")
local bgBarrier = love.graphics.newImage("graphics/obj/barrier.png")
local bgLight = love.graphics.newImage("graphics/obj/light_double.png")

local Background = Class{}
function Background:init()
    self.bgLightPos = 0
    self.bgGroundPos = 0
    self.bgBarrierPos = 0
    self.bgWidth = bgBarrier:getWidth() -- 853
    self.bgSpeed = 30
end

function Background:update(dt)
    self.bgLightPos = (self.bgCloudPos+self.bgSpeed*2*dt)%self.bgWidth
    self.bgGroundPos = (self.bgGroundPos+self.bgSpeed*dt)%self.bgWidth
    self.bgBarrierPos = (self.bgBarrierPos+self.bgSpeed*2*dt)%self.bgWidth
    self.bgLightPos = (self.bgLightPos+self.bgSpeed*2*dt)%self.bgWidth

end

function Background:drawBackground()
    love.graphics.draw(bgGround1,-self.bgGroundPos,0)
    love.graphics.draw(bgGround1,self.bgWidth-self.bgGroundPos,0)

    love.graphics.draw(bgGround2,-self.bgGroundPos,0)
    love.graphics.draw(bgGround2,self.bgWidth-self.bgGroundPos,0)

    love.graphics.draw(bgGround3,-self.bgGroundPos,0)
    love.graphics.draw(bgGround3,self.bgWidth-self.bgGroundPos,0)

    love.graphics.draw(bgGround4,-self.bgGroundPos,0)
    love.graphics.draw(bgGround4,self.bgWidth-self.bgGroundPos,0)

    love.graphics.draw(bgGround5,-self.bgGroundPos,0)
    love.graphics.draw(bgGround5,self.bgWidth-self.bgGroundPos,0)

    love.graphics.draw(bgGround6,-self.bgGroundPos,0)
    love.graphics.draw(bgGround6,self.bgWidth-self.bgGroundPos,0)

    love.graphics.draw(bgGround7,-self.bgGroundPos,0)
    love.graphics.draw(bgGround7,self.bgWidth-self.bgGroundPos,0)
end

function Background:drawForeground()
    love.graphics.draw(bgLight,-self.bgLightPos,0)
    love.graphics.draw(bgLight,self.bgWidth-self.bgLightPos,0)

    love.graphics.draw(bgBarrier,-self.bgBarrierPos,0)
    love.graphics.draw(bgBarrier,self.bgWidth-self.bgBarrierPos,0)
end


return Background