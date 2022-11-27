local composer = require( "composer" )
local widget = require("widget")
local player = require("player")
local scene = composer.newScene()
local touchInUse = false
-- local world = display.newGroup()
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 
-- "scene:create()"

local enemy, playerChar, background
local player_velocity_scale = 150

function scene:create( event )

   -- Initialize the scene

   local sceneGroup = self.view
   physics.start( true )
   physics.setGravity(0,0)
   
   local levelText = display.newText( "Level 1", display.contentCenterX, display.contentCenterY / 2, native.systemFont, 30 )
	
	world = display.newGroup()
	sceneGroup:insert( world )

   background = display.newImage( "example_background.png", display.contentCenterX, display.contentCenterY )
   background.xScale = 0.4
   background.yScale = 0.4
	
   world:insert( background )
	physics.addBody(background,kinematic);	-- add bg to physics to use velocity
	background.isSensor = true	-- disable bg collision

   playerChar = player:new({x=display.contentCenterX, y=display.contentCenterY})--display.newCircle( display.contentCenterX, display.contentCenterY, 25 )
   playerChar:spawn()
--   physics.addBody( playerChar, "dynamic", { radius = 25 } )
--	playerChar.isSensor = true
	
	
   enemy = display.newCircle(display.contentCenterX + 100, display.contentCenterY, 25 )
   enemy:setFillColor(1,0,0)
	physics.addBody( enemy, "static", { radius = 25 } )
   world:insert( enemy )
	

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
	
	enemy:addEventListener("collision", onGlobalCollision)
	
	-- Immediately stop world transitions and movement
	local function cancelPlayerMovement( event )
		transition.cancel( world );
		touchInUse = false
	end

   -- Move the world wrt. the player to simulate player movement
	local function movePlayer( event )
		print(event.phase)
		if ( event.phase == "moved" or event.phase == "began") then
			--xvel = (display.contentCenterX - event.x)/(display.contentWidth/2) * player_velocity_scale
			--yvel = (display.contentCenterY - event.y)/(display.contentHeight/2) * player_velocity_scale
			--print(xvel .. ", "..yvel)	-- #DEBUG
			--background:setLinearVelocity( xvel, yvel )
			--enemy:setLinearVelocity(enemy:getLinearVelocity() + xvel, yvel)
			-- timer.performWithDelay(100, function() bg.setLinearVelocity( 0,0 ) end, 1);
         --playerChar:applyForce(event.x, event.y, playerChar.x, playerChar.y)
         playerChar:move(event)
		elseif ( event.phase == "ended" ) then
			background:setLinearVelocity(0,0)
			enemy:setLinearVelocity(0,0)
		end
	end
	
   playerChar.x = display.contentCenterX
	playerChar.y = display.contentCenterY

   -- local function moveEnemyReverse(event)
   --      transition.to(enemy, {time=1000, x=enemy.x - 100, y=enemy.y - 50, onComplete=moveEnemyStart})
   -- end
	
   -- local function moveEnemyStart(event)
   --      transition.to(enemy, {time=1000, x=enemy.x + 100, y=enemy.y + 50, onComplete=moveEnemyReverse})
   -- end

   --  moveEnemyStart()

   sceneGroup:insert(levelText)

   Runtime:addEventListener("touch", movePlayer)  -- # TODO: was formerly touch
   Runtime:addEventListener("collision", onGlobalCollision)
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase

	physics.start( true )

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
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