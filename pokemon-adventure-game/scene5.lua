-- Scene Composer for Route 1
local composer = require( "composer" )
local perspective = require( "lib.perspective.perspective" )
local scene = composer.newScene()
local player = require( "player" )
local obstacle = require( "obstacle" )
local musicTrack
 
local camera, world, playerChar
local player_velocity_scale = 150
worldTable = {}

local function updateSavedGame()
   local path = system.pathForFile("save.csv", system.DocumentsDirectory)
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

   physics.start()
   physics.setGravity(0,0)
   physics.setDrawMode("hybrid")


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
	local fence = obstacle:new({ img=sheet, imgIdx=1, outline=outline, bodyType="static",
		x=display.contentCenterX, y=display.contentCenterY })
	fence:spawn()
	world:insert(fence.sprite)

   playerChar = player:new({x=display.contentCenterX, y=display.contentCenterY})--display.newCircle( display.contentCenterX, display.contentCenterY, 25 )
   playerChar:spawn()
   sceneGroup:insert(playerChar.sprite)

   local boulderOptions = {
      frames = {
      {x = 0, y = 0, 
      width = 27, height = 28}
      }
   }
	local boulderSheet = graphics.newImageSheet("images/boulder.png", boulderOptions)
	local boulderOutline = graphics.newOutline(2, boulderSheet, 1)
	local boulder = obstacle:new({ img=boulderSheet, imgIdx=1, outline=boulderOutline, x=200, y=322 })
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

	-- local function onPlayerCollision( self, event )
   --    transition.cancel( event.target )

	-- --	print( "player collision with " .. event.target.tag )	-- #TODO: Assign this for puzzle goals and one-way terrain
   --    if ( event.phase == "began" ) then
   --       print("hit")
   --    elseif ( event.phase == "ended" ) then
   --       print("no longer hit")
   --    end
   -- end

   local function updatePlayerRotation()
      playerChar.sprite.rotation = 0
   end

   Runtime:addEventListener("touch", movePlayer)
	-- playerChar.sprite.collision = onPlayerCollision
   -- playerChar.sprite:addEventListener("collision")
   timer.performWithDelay(0,updatePlayerRotation,-1)
   updateSavedGame()
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
   end
end


function scene:destroy( event )
 
   local sceneGroup = self.view
   updateSavedGame()
 
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