import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local playerSprite = nil


local function initialize()
	local playerImage = gfx.image.new("images/player") -- loading an image
	playerSprite = gfx.sprite.new(playerImage)
	playerSprite:moveTo(200, 120) -- starts in top-left corner
	-- ':' because we use moveTo on a particular instance of a sprite !!!
	playerSprite:add() -- adds sprite to a draw list
end

--[[
this 
is 
a
comment
--]]

initialize()

function playdate.update()
	gfx.sprite.update() -- update everything in a draw list
end