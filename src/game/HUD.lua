local Class = require "libs.hump.class"

local hudFont = love.graphics.newFont("fonts/Abaddon_Bold.ttf",16)

local HUD = Class{}
function HUD:init(player)
    self.player = player
end


function HUD:update(dt)
    
end



function HUD:draw()
    love.graphics.printf("Score:"..math.floor(self.player.score), hudFont, 10, 4, 100, "left")
    love.graphics.printf("Time:"..math.floor(self.player.timeElapsed), hudFont, 0, 4, gameWidth, "center")
end

return HUD