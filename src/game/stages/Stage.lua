local Class = require "libs.hump.class"
local Matrix = require "libs.matrix"
local Obstacle = require "src.game.Obstacle"

local Stage = Class{}

function Stage:init(rows, cols, ts)
    self.tileset = ts
    self.rowCount = rows
    self.colCount = cols

    self.spawnTimer = 0
    self.spawnInterval = 2 -- Seconds

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
    for i = 1, #self.obstacles do 
        self.obstacles[i]:update(dt)
    end

    -- Increment the spawn timer
    self.spawnTimer = self.spawnTimer + dt

    -- Check if it's time to spawn a new obstacle
    if self.spawnTimer >= self.spawnInterval then
        self.spawnTimer = 0

        local x = self:getWidth()
        local y = math.random(0, self:getHeight() - 64)
        local speed = 100
        self:spawnObstacle(x, y, speed)
    end

    -- Remove obstacles that moved offscreen
    for i = #self.obstacles, 1, -1 do
        if self.obstacles[i].x + self.obstacles[i].image:getWidth() < 0 then
            table.remove(self.obstacles, i)
        end
    end
end

function Stage:spawnObstacle(x, y, speed)
    local obs = Obstacle(x, y, speed)
    table.insert(self.obstacles, obs)
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