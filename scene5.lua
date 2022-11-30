-- Scene Composer for Route 1
local composer = require( "composer" )
local perspective = require( "lib.perspective.perspective" )
local scene = composer.newScene()
local player = require( "player" )
local obstacle = require( "obstacle" )
local musicTrack

physics.start()
physics.setGravity(0,0)
physics.setDrawMode("hybrid")
local camera, world
if playerChar == nil then
   playerChar = player:new({x=display.contentCenterX, y=450, inWater=false})
else
   playerChar.inWater = false
end
playerChar:spawn()
 
local camera, world
local player_velocity_scale = 150
local worldTable = {}

local function updateSavedGame()
   local path = system.pathForFile("save.csv", system.DocumentsDirectory)
   print(path)
   local updatedFile = io.open(path, "w+")
   updatedFile:write('scene' .. ',' .. 'health' .. ',' .. 'lives')
   updatedFile:write('\n')
   updatedFile:write('scene5' .. ',' .. '100' .. ',' .. '3')
   io.close(updatedFile)
end

-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
	world = display.newGroup()

   local background = display.newImage('images/route.png')
   background.x = display.contentCenterX
   background.y = display.contentCenterY
	world:insert(background)

	local Options = { frames = { {x = 0, y = 0, width = 320, height = 480} } }
   local sheet = graphics.newImageSheet("images/map1_left_terrain.png", Options) 
   local outline = graphics.newOutline(2, sheet, 1);
	local lTerrain = obstacle:new({ img=sheet, imgIdx=1, outline=outline, bodyType="static",
		x=display.contentCenterX, y=display.contentCenterY })
	lTerrain:spawn()
	lTerrain.bounce = 0
	world:insert(lTerrain.sprite)

   sheet = graphics.newImageSheet("images/map1_right_terrain.png", Options) 
   outline = graphics.newOutline(2, sheet, 1);
	local rTerrain = obstacle:new({ img=sheet, imgIdx=1, outline=outline, bodyType="static",
		x=display.contentCenterX, y=display.contentCenterY })
	rTerrain:spawn()
	world:insert(rTerrain.sprite)

	sheet = graphics.newImageSheet("images/map1_top_terrain.png", Options) 
   outline = graphics.newOutline(2, sheet, 1);
	local topTerrain = obstacle:new({ img=sheet, imgIdx=1, outline=outline, bodyType="static",
		x=display.contentCenterX, y=display.contentCenterY })
		topTerrain:spawn()
	world:insert(topTerrain.sprite)

	sheet = graphics.newImageSheet("images/map1_midtrees_terrain.png", Options) 
   outline = graphics.newOutline(2, sheet, 1);
	local midTrees = obstacle:new({ img=sheet, imgIdx=1, outline=outline, bodyType="static",
		x=display.contentCenterX, y=display.contentCenterY })
		midTrees:spawn()
	world:insert(midTrees.sprite)

	sheet = graphics.newImageSheet("images/map1_steepledge.png", Options) 
   outline = graphics.newOutline(2, sheet, 1);
	local steepLedge = obstacle:new({ img=sheet, imgIdx=1, outline=outline, bodyType="static",
		x=display.contentCenterX, y=display.contentCenterY })
		steepLedge:spawn()
	world:insert(steepLedge.sprite)

	sheet  = graphics.newImageSheet("images/map1_ledge_s.png", Options) 
	local ledge_s = obstacle:new({ img=sheet, imgIdx=1, outline=graphics.newOutline(2, sheet, 1),
		bodyType="static", collisionType="below", x=display.contentCenterX, y=display.contentCenterY })
	ledge_s:spawn()
	world:insert(ledge_s.sprite)

	sheet  = graphics.newImageSheet("images/map1_ledge_m.png", Options) 
	local ledge_m = obstacle:new({ img=sheet, imgIdx=1, outline=graphics.newOutline(2, sheet, 1),
		bodyType="static", collisionType="below", x=display.contentCenterX, y=display.contentCenterY })
	ledge_m:spawn()
	world:insert(ledge_m.sprite)

	sheet  = graphics.newImageSheet("images/map1_ledge_lg.png", Options) 
	local ledge_lg = obstacle:new({ img=sheet, imgIdx=1, outline=graphics.newOutline(2, sheet, 1),
		bodyType="static", collisionType="below", x=display.contentCenterX, y=display.contentCenterY })
		ledge_lg:spawn()
	world:insert(ledge_lg.sprite)

	sheet = graphics.newImageSheet("images/map1_fence_terrain.png", Options) 
   outline = graphics.newOutline(2, sheet, 1);
	local fence = obstacle:new({ img=sheet, imgIdx=1, outline=graphics.newOutline(2, sheet, 1), bodyType="static",
		x=display.contentCenterX, y=display.contentCenterY })
	fence:spawn()
	world:insert(fence.sprite)

   sheet = graphics.newImageSheet("images/RouteInteractables2.png", Options) 
   outline = graphics.newOutline(2, sheet, 1);
	local exitGate = obstacle:new({ img=sheet, imgIdx=1, outline=outline, bodyType="static",
		x=display.contentCenterX, y=display.contentCenterY })
	fence:spawn()
	world:insert(fence.sprite)

   sceneGroup:insert(playerChar.sprite)

   Options = {
      frames = {
      {x = 0, y = 0, 
      width = 27, height = 28}
      }
   }
	
	sheet = graphics.newImageSheet("images/boulder.png", Options) 
	local boulder = obstacle:new({ img=sheet, imgIdx=1, outline=graphics.newOutline(2, sheet, 1),
		x=220, y=322 })
		boulder:spawn()
	world:insert(boulder.sprite)


   local boulderGoalOptions = {
      frames = {
      {x = 0, y = 0, 
      width = 28, height = 24}
      }
   }

	local boulderGoalSheet = graphics.newImageSheet("images/boulderGoal.png", boulderGoalOptions) 

   boulderGoal = display.newImage(boulderGoalSheet, 1);
   boulderGoalOutline = graphics.newOutline(2, boulderGoalSheet, 1);

   boulderGoal.x = 105
   boulderGoal.y = 322

   physics.addBody(boulderGoal, "dynamic", {outline = boulderGoalOutline});

   sceneGroup:insert(boulderGoal)
	world:insert(boulderGoal)

	sceneGroup:insert(world)

	local entrance = display.newRect(display.contentCenterX, 485, 100, 20)
	entrance:setFillColor(1,1,1,0)
	physics.addBody(entrance, "static")
	sceneGroup:insert(entrance)
	world:insert(entrance)

	local exitBlock = display.newRect(50, 10, 100, 10)
	entrance:setFillColor(1,1,1,0)
	physics.addBody(exitBlock, "static")
	sceneGroup:insert(exitBlock)
	world:insert(exitBlock)

   musicTrack = audio.loadStream( "audio/route1Music.mp3")


	-- Move the world wrt. the player to simulate player movement
	local function movePlayer( event )
		-- print(event.phase)
		if ( event.phase == "moved" or event.phase == "began") then
			local xvel, yvel
			xvel = (event.x - display.contentCenterX)/(display.contentWidth/2) * player_velocity_scale
			yvel = (event.y - display.contentCenterY)/(display.contentHeight/2) * player_velocity_scale
         playerChar:move(xvel, yvel, event.phase)

		elseif ( event.phase == "ended" ) then
         playerChar:StopMoving()
		end
	end

   local function onGlobalCollision( event )
      transition.cancel( event.target )
		print( "collision handler" )
		print( event.phase )
      if ( event.phase == "began" ) then
         print("hit")
      elseif ( event.phase == "ended" ) then
         print("no longer hit")
      end
   end

   local success = audio.loadSound("audio/success.mp3")
   local function resumeAudio()
   	audio.resume(1)
   end

   local boulderExists = true
   local function checkBoulder()
   	--print(boulder.sprite.x)
   	--print(boulder.sprite.y)
   	if boulderExists and boulder.sprite.x < 105 and boulder.sprite.y < 325 then
   		physics.removeBody(boulder.sprite)
   		physics.addBody(boulder.sprite, "static", {outline=boulder.outline, bounciness=0})
   		boulder.sprite.x = 105
   		boulder.sprite.y = 325
   		audio.pause(1)
   		audio.play(success)
   		timer.performWithDelay(2750, resumeAudio, 1)
   		boulderExists = false
   	end
   end

   local function nextGame()
   	audio.stop( 1 )
   	local options = {
      	effect = "fade",
      	time = 500
   	}
   	composer.gotoScene("scene6", options)
	end

   local function playerLeft()
   	--print(playerChar.sprite.x, ": x")
   	--print(playerChar.sprite.y, ": y")
   	if playerChar.sprite.y < 38 and playerChar.sprite.x > 25 and playerChar.sprite.x < 75 then
   		nextGame()
   	end
   end

   Runtime:addEventListener("touch", movePlayer)
   timer.performWithDelay(1000,checkBoulder,-1)
   timer.performWithDelay(500,playerLeft,-1)
   updateSavedGame()
	-- playerChar.sprite.collision = onPlayerCollision		-- local collison
   -- playerChar.sprite:addEventListener("collision")		-- local collision
   --Runtime:addEventListener("collision", onGlobalCollision)	-- global collision
end


function scene:show( event )	
   local sceneGroup = self.view
   local phase = event.phase
	
	if ( phase == "will" ) then
		--------------------------------
		-- Camera Tracking
		--------------------------------
		camera = perspective.createView(2)
		camera:add(playerChar.sprite, 1) -- Add player to layer 1 of the camera
		camera:appendLayer()	-- add layer 0 in front of the camera
		
		camera:add(world, 2)
		camera:setParallax(0, 1) -- set parallax for each layer in descending order
		
		camera.damping = 10 -- A bit more fluid tracking
		camera:setFocus(playerChar.sprite) -- Set the focus to the player
		print("Layers: "..camera:layerCount())
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
		camera:track() -- Begin auto-tracking
      

      audio.play( musicTrack, { channel=1, loops=-1 } )
   end
end


function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
		audio.stop( 1 )
      updateSavedGame()

   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
		camera:destroy()
      composer.removeScene("scene5", false)
   end
end


function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end


---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
 
return scene