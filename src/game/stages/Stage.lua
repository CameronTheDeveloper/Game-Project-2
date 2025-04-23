local Class = require "libs.hump.class"
local Matrix = require "libs.matrix"

local Stage = Class{}

function Stage:init(rows, cols, ts)
    self.tileset = ts
    self.rowCount = rows
    self.colCount = cols

    self.initialPlayerY = 0
    self.initialPlayerX = 0
    self.music = nil
    self.objects = {} 
    self.bgs = {} 
    self.map = Matrix:new(self.rowCount, self.colCount) 
end