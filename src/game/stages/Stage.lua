local Class = require "libs.hump.class"
local Matrix = require "libs.matrix"
local Obstacle = require "src.game.Obstacle"
local WarningSign = require "src.game.WarningSign"

local Stage = Class{}
local sounds = {}  

sounds['boom'] = love.audio.newSource("sounds/Object_impacts/explosion.wav","static")

function Stage:init(rows, cols, player, background, ts)
    self.tileset = ts
    self.rowCount = rows
    self.colCount = cols

    self.timeSwitch = 5

    self.spawnTimer = 0
    self.spawnInterval = 2 -- Seconds

    self.timeElapsed = 0
    self.score = 0
    self.scoreRate = 2.5

    self.player = player
    self.initialPlayerY = 0
    self.initialPlayerX = 0
    self.music = nil
    self.obstacles = {}
    self.warningSigns = {}
    self.warningLeadTime = 0.5

    self.background = background
    self.backgroundTime = 0
    self.map = Matrix:new(self.rowCount, self.colCount)

    for row = 1, self.rowCount do
        for col = 1, self.colCount do
            self.map[row][col] = {
                quad = nil,
                rotation = 0,
                flipHor = 1,
                flipVer = 1,
            }
        end
    end
end

function Stage:resetStage()
    self.obstacles = {}
    self.warningSigns = {}
    self.spawnTimer = 0
    self.timeElapsed = 0
    self.backgroundTime = 0
    self.score = 0

end

function Stage:updateNextStage(dt)
    if self.backgroundTime > 2 then
        self.backgroundTime = 0
        gameState = "play"
    end
    gameState = "play"
    self.backgroundTime = self.backgroundTime + dt
end

function Stage:update(dt)
    if self.backgroundTime > self.timeSwitch then
        self.backgroundTime = 0
        gameState = "nextstage"
    end

    self.timeElapsed = self.timeElapsed + dt
    self.backgroundTime = self.backgroundTime + dt
    -- Add score every second (or fraction thereof)
    self.score = self.score + self.scoreRate * dt
    -- Update obstacles
    for i = 1, #self.obstacles do
        self.obstacles[i]:update(dt)
    end

    -- Increment the spawn timer
    self.spawnTimer = self.spawnTimer + dt

    -- Check if it's time to spawn a new obstacle
    if self.spawnTimer >= self.spawnInterval then
        self.spawnTimer = 0
        local x = self:getWidth()
        local y = math.random(self.background.roadTop, self.background.roadBottom - 64)
        local speed = math.random(50, 100)
        self:spawnObstacle(x, y, speed)
    end

    -- Update warning signs
    for j = #self.warningSigns, 1, -1 do
        local warning = self.warningSigns[j]
        warning.timer = warning.timer - dt
        warning:update(dt)

        if warning.timer <= 0 then
            self:spawnRealObstacle(warning.x, warning.y, warning.speed)
            table.remove(self.warningSigns, j)
        end
    end

    -- Check for collisions with obstacles
    for i = 1, #self.obstacles do
        if self.player:checkCollision(self.obstacles[i]) then
            sounds["boom"]:play()
            gameState = "over"
        end
    end

    -- Remove obstacles that moved offscreen
    for i = #self.obstacles, 1, -1 do
        if self.obstacles[i].x + self.obstacles[i].image:getWidth() < 0 then
            table.remove(self.obstacles, i)
        end
    end
end

function Stage:spawnObstacle(x, y, speed)
    -- Create a warning sign first before spawning an obstacle
    local warning = WarningSign(x, y)
    warning.timer = self.warningLeadTime
    warning.speed = speed / 2
    table.insert(self.warningSigns, warning)
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
    -- Draw the background tiles
    for row = 1, self.rowCount do
        for col = 1, self.colCount do
            self:drawTile(row, col)
        end
    end

    -- Draw obstacles
    for k = 1, #self.obstacles do
        self.obstacles[k]:draw()
    end

    -- Draw warning signs
    for j = 1, #self.warningSigns do
        self.warningSigns[j]:draw()
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

function Stage:spawnRealObstacle(x, y, speed)
    -- Spawn the real obstacle after the warning has passed
    local obs = Obstacle(x, y, speed)
    table.insert(self.obstacles, obs)
end

return Stage
