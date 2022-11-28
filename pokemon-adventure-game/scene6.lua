-- Scene Composer for cave route (level 2)
local composer = require( "composer" )
local perspective = require( "lib.perspective.perspective" )
local scene = composer.newScene()
local player = require("player")
local musicTrack
 
local camera, world, playerChar
local player_velocity_scale = 150
worldTable = {}
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
	world = display.newGroup()

   physics.start()
   physics.setGravity(0,0)
   physics.setDrawMode("hybrid")


   local background = display.newImage("images/map3wateronly.PNG")
   background.x = display.contentCenterX
   background.y = display.contentCenterY
	world:insert(background)


	local Options = {
      frames = {
      {x = 0, y = 0, 
      width = 320, height = 480}

      }
   }


   playerChar = player:new({x=display.contentCenterX, y=display.contentCenterY})--display.newCircle( display.contentCenterX, display.contentCenterY, 25 )
   playerChar:spawn()
   sceneGroup:insert(playerChar.shape)


   
    sceneGroup:insert(world)

   musicTrack = audio.loadStream( "audio/caveMusic.mp3")


	-- Move the world wrt. the player to simulate player movement
	local function movePlayer( event )
		-- print(event.phase)
		if ( event.phase == "moved" or event.phase == "began") then
			local xvel, yvel
			xvel = (event.x - display.contentCenterX)/(display.contentWidth/2) * player_velocity_scale
			yvel = (event.y - display.contentCenterY)/(display.contentHeight/2) * player_velocity_scale
         playerChar:move(xvel, yvel)

		elseif ( event.phase == "ended" ) then
			playerChar.shape:setLinearVelocity(0, 0)
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

	local function onPlayerCollision( self, event )
      transition.cancel( event.target )

		print( "player collision with " .. event.target.tag )	-- #TODO: Assign this for puzzle goals and one-way terrain
      if ( event.phase == "began" ) then
         print("hit")
      elseif ( event.phase == "ended" ) then
         print("no longer hit")
      end
   end

   Runtime:addEventListener("touch", movePlayer)
	playerChar.shape.collision = onPlayerCollision
   playerChar.shape:addEventListener("collision")
   --Runtime:addEventListener("collision", onGlobalCollision)	-- global collision
end


function scene:show( event )	
   local sceneGroup = self.view
   local phase = event.phase
	
	if ( phase == "will" ) then
		--------------------------------
		-- Camera Tracking
		--------------------------------
		camera = perspective.createView(2)	-- #DEBUG1
		camera:add(playerChar.shape, 1) -- Add player to layer 1 of the camera	-- #DEBUG1
		camera:appendLayer()	-- add layer 0 in front of the camera	-- #DEBUG1
		
		camera:add(world, 2)	-- #DEBUG1
		camera:setParallax(0, 1) -- set parallax for each layer in descending order	-- #DEBUG1
		
		camera.damping = 10 -- A bit more fluid tracking
		camera:setFocus(playerChar.shape) -- Set the focus to the player
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

   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
		camera:destroy()
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