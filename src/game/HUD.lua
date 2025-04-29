local Class = require "libs.hump.class"

local hudFont = love.graphics.newFont("fonts/Abaddon_Bold.ttf",20)
local hudFont2 = love.graphics.newFont("fonts/Abaddon_Bold.ttf",23)

local HUD = Class{}
function HUD:init(stage)
    self.stage = stage
end

local function formatTime(seconds)
    local mins = math.floor(seconds / 60)
    local sec = math.floor(seconds % 60)

    return string.format("%02d:%02d", mins, sec)
end


function HUD:update(dt)
    
end



function HUD:draw()
    local formattedTime = formatTime(self.stage.timeElapsed)
    love.graphics.printf("Score:"..math.floor(self.stage.score), hudFont, 10, 22, 100, "left")
    love.graphics.printf("Time:"..formattedTime, hudFont2, 0, 20, gameWidth, "center")
end

return HUD