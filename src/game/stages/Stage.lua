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
    self.obstacles = {} 
    self.bgs = {} 
    self.map = Matrix:new(self.rowCount, self.colCount) 
end

function Stage:update(dt)
    for i=1, #self.obstacles do 
        self.obstacles[i]:update(dt)
    end
end

function Stage:getWidth()
    return self.colCount * self:getTileSize()
end

function Stage:getHeight()
    return self.rowCount * self:getTileSize()
end

function Stage:getTileSize()
    return self.tileset.tileSize
end

