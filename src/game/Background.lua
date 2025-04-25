local Class = require "libs.hump.class"

local bgGround1 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/1.png")
local bgGround6 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/6.png")
local bgGround7 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/7.png")
local bgHighway = love.graphics.newImage("graphics/tilesets/tile/Highway_road (96 x 64).png")
local bgBarrier = love.graphics.newImage("graphics/obj/barrier.png")
local bgLight = love.graphics.newImage("graphics/obj/light_double.png")
local bgButtom = love.graphics.newImage("graphics/HUDandMENU/MENU/Menu Buttom.png")

local Background = Class{}
function Background:init()
    self.bgButtomPos = -210
    self.bgLightPos = 0
    self.bgGroundPos = 0
    self.bgBarrierPos = 0
    self.bgWidth = bgBarrier:getWidth() -- 853
    self.bgHeight = bgBarrier:getHeight()
    self.bgSpeed = 30
end

function Background:update(dt)
    self.bgLightPos = (self.bgLightPos+self.bgSpeed*2*dt)%self.bgWidth
    self.bgGroundPos = (self.bgGroundPos+self.bgSpeed*dt)%self.bgWidth
    self.bgBarrierPos = (self.bgBarrierPos+self.bgSpeed*2*dt)%self.bgWidth
    self.bgLightPos = (self.bgLightPos+self.bgSpeed*2*dt)%self.bgWidth

end

local function drawScaledFullScreen(image)
    local scaleX = gameWidth / image:getWidth()
    local scaleY = gameHeight / image:getHeight()

    love.graphics.draw(image, 0, 0, 0, scaleX, scaleY)
end

function Background:drawBackground()
    drawScaledFullScreen(bgGround7)
end

function Background:drawMenuground()
    drawScaledFullScreen(bgGround6)
    -- love.graphics.draw(bgButtom,-self.bgBarrierPos,0)
    -- love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos,0)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos-15, self.bgHeight-self.bgButtomPos, 0, 0.5, 0.5)
    
end

function Background:drawCarground()
    drawScaledFullScreen(bgGround1)
end

function Background:drawGameground()
    drawScaledFullScreen(bgHighway)
end

--function Background:drawForeground()
--    love.graphics.draw(bgLight,-self.bgLightPos,0)
--    love.graphics.draw(bgLight,self.bgWidth-self.bgLightPos,0)

--    love.graphics.draw(bgBarrier,-self.bgBarrierPos,0)
--    love.graphics.draw(bgBarrier,self.bgWidth-self.bgBarrierPos,0)
--end


return Background