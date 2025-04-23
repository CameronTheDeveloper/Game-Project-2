local Tileset = require "src.game.tiling.Tileset"

local imgTileset = love.graphics.newImage("graphics/tilesets/tile/Highway_road (96 x 64)")

local BasicTileset = Tileset(imgTileset, 16)
BasicTileset:setNotSolid({25,26,27,28,29,33,34,35,36,37,41,42,43,44,45})

return BasicTileset