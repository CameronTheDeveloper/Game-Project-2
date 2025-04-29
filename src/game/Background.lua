local Class = require "libs.hump.class"

local bgGround1 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/1.png")
local bgGround6 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/6.png")
local bgCity1 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back1/7.png")
local bgCity2 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back2/7.png")
local bgCity3 = love.graphics.newImage("graphics/tilesets/Backgrounds/Back3/10.png")
local bgHighway = love.graphics.newImage("graphics/tilesets/tile/Highway_road (96 x 64).png")
local bgHighway2 = love.graphics.newImage("graphics/tilesets/tile/Desert_road (64 x 64).png")
local bgHighway3 = love.graphics.newImage("graphics/tilesets/tile/Winter_road.png")
local bgBarrier = love.graphics.newImage("graphics/obj/barrier.png")
local bgLight = love.graphics.newImage("graphics/obj/light_double.png")
local bgButtom = love.graphics.newImage("graphics/HUDandMENU/MENU/Menu Buttom.png")
local bgHUD = love.graphics.newImage("graphics/HUDandMENU/HUD/HUD Buttom.png")
local bgHUDpause = love.graphics.newImage("graphics/HUDandMENU/HUD/pause2.png")
local bgReplay = love.graphics.newImage("graphics/HUDandMENU/MENU/replay2.png")
local bgCarpic1 = love.graphics.newImage("graphics/cars/sports_race.png")
local bgCarpic2 = love.graphics.newImage("graphics/cars/sports_green.png")
local bgCarpic3 = love.graphics.newImage("graphics/cars/sports_red.png")
local bgCarpic4 = love.graphics.newImage("graphics/cars/sports_yellow.png")

local Background = Class{}
function Background:init(x)
    self.bgImages = {
        bgCity1,
        bgCity2,
        bgCity3
    }
    self.roadImages = {
        bgHighway,
        bgHighway2,
        bgHighway3

    }
    self.bgIndex = 3
    self.x = x
    self.cityScrollSpeed = 30
    self.roadScrollSpeed = 90
    self.bgButtomPosX = -255
    self.bgButtomPos1 = -230
    self.bgButtomPos2 = -300
    self.bgButtomPos3 = -370
    self.bgButtomPos4 = -300
    self.bgButtomPos5 = -370
    self.bgHUDPos1 = 25
    self.bgHUDPos2 = -230
    self.bgHUDpausePos = -560
    self.bgReplayPos = -265
    self.bgCarpicPos = -200
    self.bgLightPosX = -200
    self.bgLightPosY = -200
    self.bgBarrierPosX = -270
    self.bgBarrierPosY = -270
    self.bgGroundPos = 0
    self.bgWidth = bgBarrier:getWidth() -- 853
    self.bgHeight = bgBarrier:getHeight()
    self.bgSpeed = 30

    self.roadTop = math.floor(gameHeight / 2) + bgHighway:getHeight()
    self.roadBottom = gameHeight - 1
end

function Background:switchBackground()
    if self.bgIndex < #self.bgImages then
        self.bgIndex = self.bgIndex + 1
    else
        self.bgIndex = 1
    end
end

function Background:update(dt)
    local currentBg = self.bgImages[self.bgIndex]
    local scaleX = gameWidth / currentBg:getWidth()
    local scaledCityWidth = currentBg:getWidth() * scaleX

    self.x = (self.x + self.cityScrollSpeed * dt) % scaledCityWidth
    self.bgLightPosX = (self.bgLightPosX + self.roadScrollSpeed * dt) % scaledCityWidth
    self.bgBarrierPosX = (self.bgBarrierPosX + self.roadScrollSpeed * dt) % scaledCityWidth
end

local function drawScaledFullScreen(image, x)
    local scaleX = gameWidth / image:getWidth()
    local scaleY = gameHeight / image:getHeight()

    love.graphics.draw(image, x, 0, 0, scaleX, scaleY)
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

local function drawLights(xPosition, yPosition)
    love.graphics.draw(bgLight,xPosition, yPosition, 0, 3, 3)
    love.graphics.draw(bgLight,xPosition-100, yPosition, 0, 3, 3)
    love.graphics.draw(bgLight,xPosition+100, yPosition, 0, 3, 3)
    love.graphics.draw(bgLight,xPosition+200, yPosition, 0, 3, 3)
    love.graphics.draw(bgLight,xPosition+300, yPosition, 0, 3, 3)
    love.graphics.draw(bgLight,xPosition-200, yPosition, 0, 3, 3)
end

local function drawBarriers(xPosition, yPosition)
    love.graphics.draw(bgBarrier,xPosition-300, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition-270, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition-240, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition-210, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition-180, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition-150, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition-120, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition-90, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition-60, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition-30, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+30, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+60, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+90, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+120, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+150, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+180, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+210, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+240, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+270, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+300, yPosition, 0, 1.5, 1.5)
    love.graphics.draw(bgBarrier,xPosition+330, yPosition, 0, 1.5, 1.5)
end

function Background:mouseClickedMenu(x, y)

    local buttonX = self.bgWidth - self.bgButtomPos1 - 15
    local playButtonY = self.bgHeight - self.bgButtomPos1 - 30
    local carsButtonY = self.bgHeight - self.bgButtomPos2 - 35
    local exitButtonY = self.bgHeight - self.bgButtomPos3 - 35

    local buttonWidth = bgButtom:getWidth() * 0.35
    local buttonHeight = bgButtom:getHeight() * 0.35

    
    if x >= buttonX + 25 and x <= buttonX + buttonWidth and
       y >= playButtonY + 55 and y <= playButtonY + buttonHeight then
        gameState = "play"
    elseif
    x >= buttonX + 25 and x <= buttonX + buttonWidth and
    y >= carsButtonY + 55 and y <= carsButtonY + buttonHeight then
     gameState = "cars"
    elseif 
    x >= buttonX + 25 and x <= buttonX + buttonWidth and
    y >= exitButtonY + 55 and y <= exitButtonY + buttonHeight then
        love.event.quit()
    end
end

function Background:drawMapBackground()
    local currentBg = self.bgImages[self.bgIndex]
    local scaleX = gameWidth / currentBg:getWidth()
    local x = -self.x
    drawScaledFullScreen(currentBg, x)
    drawScaledFullScreen(currentBg, x + currentBg:getWidth() * scaleX)
    drawScaledFullScreen(currentBg, x + (currentBg:getWidth() * 2) * scaleX)
end

function Background:drawPlayBackground()
    drawGameRoad(self.roadTop, self.roadBottom)
end

function Background:drawMenuground()
    drawScaledFullScreen(bgGround6, 0)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos1, self.bgHeight-self.bgButtomPos1, 0, 0.35, 0.35)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos1, self.bgHeight-self.bgButtomPos2, 0, 0.35, 0.35)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos1, self.bgHeight-self.bgButtomPos3, 0, 0.35, 0.35)
end

function Background:drawCarground()
    drawScaledFullScreen(bgGround1, 0)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos4-75, self.bgHeight-self.bgButtomPos4, 0, 0.35, 0.35)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos5-145, self.bgHeight-self.bgButtomPos5, 0, 0.35, 0.35)

    love.graphics.draw(bgCarpic1,self.bgWidth-self.bgCarpicPos+260, self.bgHeight-self.bgCarpicPos, 0, 3.5, 3.5)
    love.graphics.draw(bgCarpic2,self.bgWidth-self.bgCarpicPos-40, self.bgHeight-self.bgCarpicPos, 0, 3.5, 3.5)
    love.graphics.draw(bgCarpic3,self.bgWidth-self.bgCarpicPos+110, self.bgHeight-self.bgCarpicPos, 0, 3.5, 3.5)
    love.graphics.draw(bgCarpic4,self.bgWidth-self.bgCarpicPos-190, self.bgHeight-self.bgCarpicPos, 0, 3.5, 3.5)
end

function Background:drawEndGameGround()
    drawScaledFullScreen(bgHighway, 0)
end

function Background:drawHudground()
    love.graphics.draw(bgHUD,self.bgWidth-self.bgHUDPos1-15, self.bgHeight-self.bgHUDPos1-5, 0, 0.35, 0.35)
    love.graphics.draw(bgHUD,self.bgWidth-self.bgHUDPos2-3, self.bgHeight-self.bgHUDPos2-260, 0, 0.35, 0.35)
    love.graphics.draw(bgHUDpause,self.bgWidth-self.bgHUDpausePos, self.bgHeight-self.bgHUDpausePos-570, 0, 0.3, 0.3)
end

function Background:drawPauseground()
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos1-5, self.bgHeight-self.bgButtomPos1, 0, 0.35, 0.35)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos2-75, self.bgHeight-self.bgButtomPos2, 0, 0.35, 0.35)
    love.graphics.draw(bgReplay,self.bgWidth-self.bgReplayPos+100, self.bgHeight-self.bgReplayPos, 0, 0.2, 0.2)
end

function Background:drawOverground()
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos1-5, self.bgHeight-self.bgButtomPos1, 0, 0.35, 0.35)
    love.graphics.draw(bgButtom,self.bgWidth-self.bgButtomPos2-75, self.bgHeight-self.bgButtomPos2, 0, 0.35, 0.35)
end

function Background:drawBackobjground()
    local currentBg = self.bgImages[self.bgIndex]
    local scaleX = gameWidth / currentBg:getWidth()
    local scaledCityWidth = currentBg:getWidth() * scaleX

    for i = -1, 2 do
        drawLights(-self.bgLightPosX + i * scaledCityWidth, self.bgHeight-self.bgLightPosY)
    end

    for i = -1, 2 do
        drawBarriers(-self.bgBarrierPosX + i * scaledCityWidth, self.bgHeight-self.bgBarrierPosY)
    end
end

return Background