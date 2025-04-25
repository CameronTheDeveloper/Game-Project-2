local Class = require "libs.hump.class"

local bgGround1 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/1.png")
local bgGround6 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/6.png")
local bgGround7 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/7.png")
local bgHighway = love.graphics.newImage("graphics/tilesets/tile/Highway_road (96 x 64).png")
local bgBarrier = love.graphics.newImage("graphics/obj/barrier.png")
local bgLight = love.graphics.newImage("graphics/obj/light_double.png")
local bgButtom = love.graphics.newImage("graphics/HUDandMENU/MENU/Menu Buttom.png")
local bgHUD = love.graphics.newImage("graphics/HUDandMENU/HUD/HUD Buttom.png")

local Background = Class{}
function Background:init()
    self.bgButtomPos1 = -235
    self.bgButtomPos2 = -300
    self.bgButtomPos3 = -370
    self.bgButtomPos4 = -300
    self.bgButtomPos5 = -370
    self.bgHUDPos1 = 25
    self.bgHUDPos2 = -230
    self.bgLightPos = 0
    self.bgGroundPos = 0
    self.bgBarrierPos = 0
    self.bgWidth = bgBarrier:getWidth() -- 853
    self.bgHeight = bgBarrier:getHeight()
    self.bgSpeed = 30

    self.roadTop = math.floor(gameHeight / 2) + bgHighway:getHeight()
    self.roadBottom = gameHeight - 1
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

local function drawGameRoad(roadTop, roadBottom)
    local roadTileWidth = bgHighway:getWidth()
    local roadTileHeight = bgHighway:getHeight()


    for y = roadTop, roadBottom, roadTileHeight do
        for x = 0, gameWidth - 1, roadTileWidth do
            love.graphics.draw(bgHighway, x, y)
        end
    end
end

function Background:drawPlayBackground()
    drawScaledFullScreen(bgGround7)
    drawGameRoad(self.roadTop, self.roadBottom)
end

function Background:drawMenuground()
    drawScaledFullScreen(bgGround6)
    -- love.graphics.draw(bgButtom,-self.bgBarrierPos,0)
    -- love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos,0)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos1-10, self.bgHeight-self.bgButtomPos1-5, 0, 0.35, 0.35)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos2-75, self.bgHeight-self.bgButtomPos2, 0, 0.35, 0.35)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos3-145, self.bgHeight-self.bgButtomPos3, 0, 0.35, 0.35)
end

function Background:drawCarground()
    drawScaledFullScreen(bgGround1)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos4-75, self.bgHeight-self.bgButtomPos4, 0, 0.35, 0.35)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos5-145, self.bgHeight-self.bgButtomPos5, 0, 0.35, 0.35)
end

function Background:drawEndGameGround()
    drawScaledFullScreen(bgHighway)
end

function Background:drawHudground()
    love.graphics.draw(bgHUD,self.bgWidth-self.bgHUDPos1-15, self.bgHeight-self.bgHUDPos1-5, 0, 0.35, 0.35)
    love.graphics.draw(bgHUD,self.bgWidth-self.bgHUDPos2-3, self.bgHeight-self.bgHUDPos2-260, 0, 0.35, 0.35)
end

function Background:drawPauseground()
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos1-10, self.bgHeight-self.bgButtomPos1-5, 0, 0.35, 0.35)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos2-75, self.bgHeight-self.bgButtomPos2, 0, 0.35, 0.35)
end

--function Background:drawForeground()
--    love.graphics.draw(bgLight,-self.bgLightPos,0)
--    love.graphics.draw(bgLight,self.bgWidth-self.bgLightPos,0)

--    love.graphics.draw(bgBarrier,-self.bgBarrierPos,0)
--    love.graphics.draw(bgBarrier,self.bgWidth-self.bgBarrierPos,0)
--end


return Background