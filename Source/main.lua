import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

-- Sprites
local playerSprite = nil
local pizzaSprite = nil
-- Timer
local playerSpeed = 4
local playTimer = nill
local playTime = 30 * 1000 -- milliseconds

local function resetTimer()
	playTimer = playdate.timer.new(playTime, playTime, 0, playdate.easingFunctions.linear)
end

local function movePizza()
	local randX = math.random(40,360)
	local randY = math.random(40,200)
	pizzaSprite:moveTo(randX, randY)
end

local function initialize()
	math.randomseed(playdate.getSecondsSinceEpoch())
	
	local playerImage = gfx.image.new("images/player") -- loading an image
	playerSprite = gfx.sprite.new(playerImage)
	playerSprite:moveTo(200, 120) -- starts in top-left corner
	-- ':' because we use moveTo on a particular instance of a sprite !!!
	playerSprite:add() -- adds sprite to a draw list
	
	local pizzaImage = gfx.image.new("images/pizza")
	pizzaSprite = gfx.sprite.new(pizzaImage)
	movePizza()
	pizzaSprite:add()
	
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
	
	resetTimer()
end

initialize()

function playdate.update()
	
	if playTimer.value == 0 then
		if playdate.buttonJustPressed(playdate.kButtonA) then
			resetTimer()
			movePizza()
		end
	else
		if playdate.buttonIsPressed(playdate.kButtonUp) then
			playerSprite:moveBy(0, -playerSpeed)
		end
		
		if playdate.buttonIsPressed(playdate.kButtonRight) then
			playerSprite:moveBy(playerSpeed, 0)
		end
		
		if playdate.buttonIsPressed(playdate.kButtonDown) then
			playerSprite:moveBy(0, playerSpeed)
		end
		
		if playdate.buttonIsPressed(playdate.kButtonLeft) then
			playerSprite:moveBy(-playerSpeed, 0)
		end
	end
	
	playdate.timer.updateTimers()
	gfx.sprite.update() -- update everything in a draw list
	gfx.drawText("*Time: *" .. math.ceil(playTimer.value/1000), 10, 10) -- ".." string concatenation 
end











