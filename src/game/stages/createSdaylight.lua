local Stage = require "src.game.stages.Stage"
local BasicTileset = require "src.game.tiling.BasicTileset"
local Background = require "src.game.Background"
local towtruck = require "src.game.obstacle.towtruck"
local props = require "src.game.obstacle.props"
local Sounds = require "src.game.Sounds"

local function createSdaylight()
    local stage = Stage(20,50,BasicTileset)
    for row = 1, 20 do -- 15*16 = 240pixels
        for col = 1, 50 do -- 30*16 = 480 pixels
            if row < 13 then
                stage.map[row][col] = nil
            elseif row == 13 then
                stage.map[row][col] = stage.tileset:get(2)
            else
                stage.map[row][col] = stage.tileset:get(10)
            end
        end -- end for col
    end -- end for row

    -- Backgrounds
    local bg1 = Background("graphics/tilesets/Backgrounds/Back1/7.png")
    
    stage:addBackground(bg1)

    -- Initial Player Pos
    stage.initialPlayerX = 1*16
    stage.initialPlayerY = 13*16 

    -- Adding obstacles
    local obs1 = Truck()
    obs1:setCoord(25*16, 12*16)
    obs1:changeDirection()
    stage:addObs(obs1)

    -- music
    stage:setMusic(Sounds["music_Driving"])

    return stage
end