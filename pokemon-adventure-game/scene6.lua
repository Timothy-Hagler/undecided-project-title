-- Scene Composer for cave route (level 2)
local composer = require("composer")
local perspective = require("lib.perspective.perspective")
local player = require("player")
local scene = composer.newScene()
local musicTrack
local numOfLives = 3

local camera, world
local cameraDestroyed = nil
local playerChar
local player_velocity_scale = 150

physics.start()
physics.setGravity(0, 0)

if playerChar == nil then
	playerChar = player:new({ x = display.contentCenterX, y = display.contentCenterY, inWater = true })
else
	playerChar.inWater = true
	playerChar.sprite.x = display.contentCenterX
	playerChar.sprite.y = display.contentCenterY
end
playerChar:spawn()


local function updateSavedGame()
	local path = system.pathForFile("save.csv", system.DocumentsDirectory)
	local updatedFile = io.open(path, "w+")
	updatedFile:write('scene' .. ',' .. 'health' .. ',' .. 'lives')
	updatedFile:write('\n')
	updatedFile:write('scene6' .. ',' .. '100' .. ',' .. '3')
	io.close(updatedFile)
end

-- Move the world wrt. the player to simulate player movement
local function movePlayer(event)
	if (event.phase == "moved" or event.phase == "began") then
		local xvel, yvel
		xvel = (event.x - display.contentCenterX) / (display.contentWidth / 2) * player_velocity_scale
		yvel = (event.y - display.contentCenterY) / (display.contentHeight / 2) * player_velocity_scale
		playerChar:move(xvel, yvel, event.phase)

	elseif (event.phase == "ended") then
		playerChar:StopMoving()
	end
end

-- "scene:create()"
function scene:create(event)

	local sceneGroup = self.view
	world = display.newGroup()

	sceneGroup:insert(playerChar.sprite)

	-- add random pokemon enemy generator
	-- create a sprite object and then do a physics.addBody on int1Sheet
	-- make the enemy a kinematic object that randomy attacks and defends
	-- grab the movement from the scene5 and add it in the overlay scene

	-- put the sprites onto the screen

	-- put the trainer and pikachu in a group and then put the enemies in a group

	-- 1 add phyiscs bodies and outlines to the sprites

	local circle1 = display.newCircle(display.contentCenterX + 610, display.contentCenterY - 390, 100)
	--local circle1 = display.newCircle(display.contentCenterX,display.contentCenterY,100)
	circle1.alpha = 0
	-- hide the circle
	physics.addBody(circle1, "static", { radius = 100 })
	circle1.isSensor = true

	-- add collision event
	local function circleCollision(event)
		if (event.phase == "began") then
			local overlayOptions = { -- options for scene overlay
				effect = "fade",
				time = 500,
				isModal = true,
				params = {
					nextScene = "scene7",
					currScene = "scene1",
					pokemon = "charmander",
					numOfLives = numOfLives,
				}
			}
			playerChar.movementEnabled = false
			circle1:removeEventListener("collision", circleCollision)
			if not cameraDestroyed then
				camera:destroy()
				camera = nil
				cameraDestroyed = true
			end
			composer.showOverlay("battleScene", overlayOptions)
			-- timer.cancelAll()
		end
	end

	circle1:addEventListener("collision", circleCollision)
	-- call the battle scene overlay here if the radius is encountered at a certain x and y positions
	world:insert(circle1)

	local backgroundWater = display.newImage("images/map3smallwater.png")
	backgroundWater.x = display.contentCenterX
	backgroundWater.y = display.contentCenterY
	backgroundWater.xScale, backgroundWater.yScale = 50, 50
	world:insert(backgroundWater)

	local background = display.newImage("images/map3wateronly.PNG")
	background.x = display.contentCenterX + 300
	background.y = display.contentCenterY * 0.25
	world:insert(background)


	local obstacleFull = "images/map3obstacles.png"
	local obstaclesOutline = graphics.newOutline(2, obstacleFull)
	local obstacle = display.newImage(obstacleFull)
	obstaclesOutline.alpha = 0
	--obstaclesOutline = graphics.newOutline(2, obsSheet, 2);

	obstacle.x = background.x
	obstacle.y = background.y

	physics.addBody(obstacle, "static", { outline = obstaclesOutline, density = 500 })
	world:insert(obstacle)


	local obstacleFull2 = "images/map3obstacles2.png"
	local obstaclesOutline2 = graphics.newOutline(2, obstacleFull2)
	local obstacle2 = display.newImage(obstacleFull2)
	--obstaclesOutline = graphics.newOutline(2, obsSheet, 2);

	obstacle2.x = background.x
	obstacle2.y = background.y

	physics.addBody(obstacle2, "static", { outline = obstaclesOutline2, density = 500 })
	world:insert(obstacle2)


	local obstacleFull3 = "images/map3obstacles3.png"
	local obstaclesOutline3 = graphics.newOutline(2, obstacleFull3)

	local obstacle3 = display.newImage(obstacleFull3)
	--obstaclesOutline = graphics.newOutline(2, obsSheet, 2);

	obstacle3.x = background.x
	obstacle3.y = background.y

	physics.addBody(obstacle3, "static", { outline = obstaclesOutline3, density = 500 })
	world:insert(obstacle3)


	local obstacleFull4 = "images/map3obstacles4.png"
	local obstaclesOutline4 = graphics.newOutline(2, obstacleFull4)
	local obstacle4 = display.newImage(obstacleFull4)
	--obstaclesOutline = graphics.newOutline(2, obsSheet, 2);

	obstacle4.x = background.x
	obstacle4.y = background.y

	physics.addBody(obstacle4, "static", { outline = obstaclesOutline4, density = 500 })
	world:insert(obstacle4)


	local obstacleFull5 = "images/map3obstacles5.png"
	local obstaclesOutline5 = graphics.newOutline(2, obstacleFull5)
	local obstacle5 = display.newImage(obstacleFull5)
	--obstaclesOutline = graphics.newOutline(2, obsSheet, 2);

	obstacle5.x = background.x
	obstacle5.y = background.y

	physics.addBody(obstacle5, "static", { outline = obstaclesOutline5, density = 500 })
	world:insert(obstacle5)


	local obstacleFull6 = "images/map3obstacles6.png"
	local obstaclesOutline6 = graphics.newOutline(2, obstacleFull6)
	local obstacle6 = display.newImage(obstacleFull6)
	--obstaclesOutline = graphics.newOutline(2, obsSheet, 2);

	obstacle6.x = background.x
	obstacle6.y = background.y

	physics.addBody(obstacle6, "static", { outline = obstaclesOutline6, density = 500 })
	world:insert(obstacle6)

	sceneGroup:insert(world)

	musicTrack = audio.loadStream("audio/caveMusic.mp3")

	updateSavedGame()

end

local function setupCamera(playerChar, world)
	--------------------------------
	-- Camera Tracking
	--------------------------------
	camera = perspective.createView(2)
	camera:add(playerChar.sprite, 1) -- Add player to layer 1 of the camera
	camera:appendLayer() -- add layer 0 in front of the camera

	camera:add(world, 2)
	camera:setParallax(0, 1) -- set parallax for each layer in descending order

	camera.damping = 10 -- A bit more fluid tracking
	camera:setFocus(playerChar.sprite) -- Set the focus to the player

	cameraDestroyed = nil
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		setupCamera(playerChar, world)
		playerChar.movementEnabled = true
		Runtime:addEventListener("touch", movePlayer)
	elseif (phase == "did") then
		-- Called when the scene is now on screen.
		-- Insert code here to make the scene come alive.
		-- Example: start tieers, begin animation, play audio, etc.
		camera:track() -- Begin auto-tracking
		audio.play( musicTrack, { channel=1, loops=-1 } )

	end
end

function scene:hide(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		playerChar.movementEnabled = false
		Runtime:removeEventListener("touch", movePlayer)
		audio.stop(1)
		timer.cancelAll()
		updateSavedGame()

	elseif (phase == "did") then
		-- Called immediately after scene goes off screen.
		if camera then camera:cancel() end
	end
end

function scene:destroy(event)
	local sceneGroup = self.view

	if not cameraDestroyed then
		camera:destroy()
		camera = nil
		cameraDestroyed = true
	end
	-- composer.removeScene("scene6", false)

	-- Called prior to the removal of scene's view ("sceneGroup").
	-- Insert code here to clean up the scene.
	-- Example: remove display objects, save state, etc.
	world:removeSelf()
end

---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
---------------------------------------------------------------------------------

return scene
