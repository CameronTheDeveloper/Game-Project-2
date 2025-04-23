local Stage = require "src.game.stages.Stage"
--local BasicTileset = require "src.game.tiling.BasicTileset"
local Background = require "src.game.tiling.Background"
local towtruck = require "src.game.obstacle.towtruck"
local Sounds = require "src.game.Sounds"

local function createSdaylight()
    local stage = Stage(20,50,BasicTileset)
    local mapdata = require "src.game.maps.map1"
    stage:readMapData(mapdata)

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