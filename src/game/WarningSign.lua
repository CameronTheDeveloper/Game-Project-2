local Class = require "libs.hump.class"
local Tween = require "libs.tween"

local warningSprite = love.graphics.newImage("/graphics/HUDandMENU/HUD/Warning_sign.png")
local WarningSign = Class{}

function WarningSign:init(x, y)
    self.x = 550
    self.y = y
    self.alpha = 1 
    self.timer = 0.5
    self.speed = nil

    self.tween = Tween.new(0.4, self, {x = love.graphics.getWidth() - 80, alpha = 1}, "inOutQuad")
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
    love.graphics.setColor(1, 0.4, 0, self.alpha)
    love.graphics.draw(warningSprite, self.x, self.y, 0, 0.05, 0.05)
    love.graphics.setColor(1, 1, 1, 1)
end

return WarningSign
