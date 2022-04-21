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
	
	--[[
	setBackgroundDrawingCallback:
	1. Create screen-sized sprite
	2. Adds to draw list
	3. Sets to lowest z-index
	4. and more	
	
	drawCallback is a routine you specify that implements your background drawing. The callback should be a function taking the arguments x, y, width, height, where x, y, width, height specify the region (in screen coordinates, not world coordinates) of the background region that needs to be updated.
	--]]
	
	local backgroundImage = gfx.image.new("images/background")
	gfx.sprite.setBackgroundDrawingCallback(
		function (x, y, width, height)
			gfx.setClipRect(x, y, width, height) -- let's only draw the part of the screen that's dirty
			backgroundImage:draw(0,0)
			gfx.clearClipRect() -- clear so we don't interfere with drawing that comes after this
		end
	)	
end




initialize()

function playdate.update()
	gfx.sprite.update() -- update everything in a draw list
end