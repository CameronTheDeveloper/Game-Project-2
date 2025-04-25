local Class = require "libs.hump.class"
local Tween = require "libs.tween"

local warningSprite = require "/graphics/HUDandMENU/HUD/Warning_sign.png"
local WarningSign = Class{}

function WarningSign:init(x, y)
    self.x = x
    self.y = y 
    self.alpha = 0
    
    self.tween = tween.new(1, self, {x = love.graphics.getWidth() - 100, alpha = 1}, "inOutQuad")
end

function WarningSign:update(dt)
    if self.tween then
        local complete = self.tween:update(dt)
        if complete then
            self.tween = nil
        end
    end
end


return WarningSign