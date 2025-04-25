local Class = require "libs.hump.class"
local Tween = require "libs.tween"

local warningSprite = require "/graphics/HUDandMENU/HUD/Warning_sign.png"
local WarningSign = Class{}

function WarningSign:Init(x, y)
    self.x = x
    self.y = y 
end



return WarningSign