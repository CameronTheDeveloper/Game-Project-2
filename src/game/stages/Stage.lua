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

    for row = 1, self.rowCount do
        for col = 1, self.colCount do
            self.map[row][col] = {
                quad = nil,  -- set to a proper quad if you have one
                rotation = 0,
                flipHor = 1,
                flipVer = 1,
            }
        end
    end
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

function Stage:draw()
    for row = 1, self.rowCount do
        for col = 1, self.colCount do
            self:drawTile(row,col) 
        end -- col
    end -- row

    for k=1, #self.obstacles do
        self.obstacles[k]:draw()
    end
end


function Stage:drawTile(row, col)
    local curTile = self.map[row][col]
    if curTile and curTile.quad then
        love.graphics.draw(self.tileset:getImage(),
            curTile.quad,
            (col - 1) * self:getTileSize(),
            (row - 1) * self:getTileSize(),
            curTile.rotation or 0,
            curTile.flipHor or 1,
            curTile.flipVer or 1
        )
    end
end


return Stage