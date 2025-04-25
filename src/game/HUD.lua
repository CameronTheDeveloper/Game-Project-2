local Class = require "libs.hump.class"

local hudFont = love.graphics.newFont("fonts/Abaddon_Bold.ttf",16)

local HUD = Class{}
function HUD:init(player)
    self.player = player
end

local function formatTime(seconds)
    local mins = math.floor(seconds / 60)
    local sec = math.floor(seconds % 60)

    return string.format("%02d:%02d", mins, sec)
end


function HUD:update(dt)
    
end



function HUD:draw()
    local formattedTime = formatTime(self.player.timeElapsed)
    love.graphics.printf("Score:"..math.floor(self.player.score), hudFont, 10, 4, 100, "left")
    love.graphics.printf("Time:"..formattedTime, hudFont, 0, 4, gameWidth, "center")
end

return HUD