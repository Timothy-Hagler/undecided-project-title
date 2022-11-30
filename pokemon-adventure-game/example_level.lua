local composer = require( "composer" )
local player = require("player")
local perspective = require("lib.perspective.perspective")
local scene = composer.newScene()
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------
 
-- "scene:create()"

local camera, world, playerChar
local player_velocity_scale = 150

-- Move the world wrt. the player to simulate player movement
local function movePlayer( event )
	print(event.phase)
	if ( event.phase == "moved" or event.phase == "began") then
		local xvel, yvel
		xvel = (event.x - display.contentCenterX)/(display.contentWidth/2) * player_velocity_scale
		yvel = (event.y - display.contentCenterY)/(display.contentHeight/2) * player_velocity_scale
		playerChar:move(xvel, yvel)
		
	elseif ( event.phase == "ended" ) then
		playerChar:StopMoving()
	end
end


local function onGlobalCollision( event )
	transition.cancel( event.target )
	print( "handler" )
	if ( event.phase == "began" ) then
		print("hit")
		playerChar.prevXForce = 0
	elseif ( event.phase == "ended" ) then
		print("no longer hit")
	end
end

function scene:create( event )

   -- Initialize the scene
	
   local sceneGroup = self.view
	
	world = display.newGroup()
   physics.start( true )
   physics.setGravity(0,0)
   
   local levelText = display.newText( "Level 1", display.contentCenterX, display.contentCenterY / 2, native.systemFont, 30 )
	
	world = display.newGroup()
	sceneGroup:insert( world )
	
   local background = display.newImage( "example_background.png", display.contentCenterX, display.contentCenterY )
   background.xScale = 0.4
   background.yScale = 0.4
	
   world:insert( background )
	playerChar = player:new({x=display.contentCenterX, y=display.contentCenterY})--display.newCircle( display.contentCenterX, display.contentCenterY, 25 )
   playerChar:spawn()
	sceneGroup:insert(playerChar.shape)

   local enemy = display.newCircle(display.contentCenterX + 100, display.contentCenterY, 25 )
   enemy:setFillColor(1,0,0)
	physics.addBody( enemy, "dynamic", { radius = 25 } )
	enemy.linearDamping = 5
	enemy.angularDamping = 5
   world:insert( enemy )

	enemy:addEventListener("collision", onGlobalCollision)
	
	
   playerChar.x = display.contentCenterX
	playerChar.y = display.contentCenterY

   sceneGroup:insert(levelText)

   Runtime:addEventListener("touch", movePlayer)
   Runtime:addEventListener("collision", onGlobalCollision)
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase

	physics.start()
   if ( phase == "will" ) then
		-- Called when the scene is still off screen (but is about to come on screen).
		camera = perspective.createView(2)
		camera:add(playerChar.shape, 1) -- Add player to layer 1 of the camera
		camera:appendLayer()	-- add layer 0 in front of the camera
		
		camera:add(world, 2)
		camera:setParallax(0, 1) -- set parallax for each layer in descending order
		
		camera.damping = 10 -- A bit more fluid tracking
		camera:setFocus(playerChar.shape) -- Set the focus to the player
		print("Layers: "..camera:layerCount())
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
		camera:track() -- Begin auto-tracking
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase

	camera:destroy()
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
      Runtime:removeEventListener("touch", movePlayer)
      physics.pause()
   end
end
 
-- "scene:destroy()"
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