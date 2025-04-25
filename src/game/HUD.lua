local Class = require "libs.hump.class"

local hudFont = love.graphics.newFont("fonts/Abaddon_Bold.ttf",16)

local HUD = Class{}
function HUD:init(player)
    self.player = player
end


function HUD:update(dt)
    
end



function HUD:draw()
    love.graphics.printf("Score:"..self.player.score,hudFont,240,4,80,"right")
end

return HUD