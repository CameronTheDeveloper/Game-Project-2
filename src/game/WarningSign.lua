local Class = require "libs.hump.class"
local Tween = require "libs.tween"

local warningSprite = love.graphics.newImage("/graphics/HUDandMENU/HUD/Warning_sign.png")
local WarningSign = Class{}

function WarningSign:init(x, y)
    self.x = x
    self.y = y 
    self.alpha = 0
    self.warningLeadTimer = 0.5
    self.speed = nil
    
    self.tween = Tween.new(1, self, {alpha = 1}, "inOutQuad")
end

function WarningSign:update(dt)
    if self.tween then
        local complete = self.tween:update(dt)
        if complete then
            self.tween = nil
        end
    end
end

function WarningSign:draw()
    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.draw(warningSprite, self.x, self.y)
    love.graphics.setColor(1, 1, 1, 1)
end


return WarningSign