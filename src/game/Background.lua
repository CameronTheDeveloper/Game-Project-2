local Class = require "libs.hump.class"

local bgGround1 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/1.png")
local bgGround6 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/6.png")
local bgGround7 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/7.png")
local bgHighway = love.graphics.newImage("graphics/tilesets/tile/Highway_road (96 x 64).png")
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
    love.graphics.draw(bgGround7,-self.bgGroundPos,0)
    love.graphics.draw(bgGround7,self.bgWidth-self.bgGroundPos,0)
end

function Background:drawMenuground()
    love.graphics.draw(bgGround6,-self.bgGroundPos,0)
    love.graphics.draw(bgGround6,self.bgWidth-self.bgGroundPos,0)
end

function Background:drawCarground()
    love.graphics.draw(bgGround1,-self.bgGroundPos,0)
    love.graphics.draw(bgGround1,self.bgWidth-self.bgGroundPos,0)
end

function Background:drawGameground()
    love.graphics.draw(bgHighway,-self.bgGroundPos,0)
    love.graphics.draw(bgHighway,self.bgWidth-self.bgGroundPos,0)
end

function Background:drawForeground()
    love.graphics.draw(bgLight,-self.bgLightPos,0)
    love.graphics.draw(bgLight,self.bgWidth-self.bgLightPos,0)

    love.graphics.draw(bgBarrier,-self.bgBarrierPos,0)
    love.graphics.draw(bgBarrier,self.bgWidth-self.bgBarrierPos,0)
end


return Background