-- Scene Composer for cave route (level 2)
local composer = require( "composer" )
local perspective = require( "lib.perspective.perspective" )
local scene = composer.newScene()
local player = require("player")
local musicTrack
 
local camera, world, playerChar
local player_velocity_scale = 150
worldTable = {}

local function updateSavedGame()
   local path = system.pathForFile("save.csv", system.DocumentsDirectory)
   print(path)
   local updatedFile = io.open(path, "w+")
   updatedFile:write('scene' .. ',' .. 'health' .. ',' .. 'lives')
   updatedFile:write('\n')
   updatedFile:write('scene6' .. ',' .. '100' .. ',' .. '3')
   io.close(updatedFile)
end

-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
	world = display.newGroup()

   physics.start()
   physics.setGravity(0,0)
   physics.setDrawMode("hybrid")

   local backgroundWater = display.newImage("images/map3smallwater.png")
   backgroundWater.x = display.contentCenterX
   backgroundWater.y = display.contentCenterY
   backgroundWater.xScale, backgroundWater.yScale = 50, 50
   world:insert(backgroundWater)

   local background = display.newImage("images/map3wateronly.PNG")
   background.x = display.contentCenterX + 300
   background.y = display.contentCenterY*0.25
	world:insert(background)


	local Options = {
      frames = {
      {x = 0, y = 0, 
      width = 320, height = 480}

      }
   }

   local obstacleFull = "images/map3obstacles.png"
   local obstaclesOutline = graphics.newOutline(2, obstacleFull)
   local obstacle = display.newImage(obstacleFull)
   obstaclesOutline.alpha = 0
   --obstaclesOutline = graphics.newOutline(2, obsSheet, 2);

   obstacle.x = background.x
   obstacle.y = background.y

   physics.addBody(obstacle, "static", {outline = obstaclesOutline, density=500})
    world:insert(obstacle)

    local obstacleFull2 = "images/map3obstacles2.png"
    local obstaclesOutline2 = graphics.newOutline(2, obstacleFull2)
    local obstacle2 = display.newImage(obstacleFull2)
    --obstaclesOutline = graphics.newOutline(2, obsSheet, 2);
 
    obstacle2.x = background.x
    obstacle2.y = background.y
 
    physics.addBody(obstacle2, "static", {outline = obstaclesOutline2, density=500})
     world:insert(obstacle2)

     local obstacleFull3 = "images/map3obstacles3.png"
     local obstaclesOutline3 = graphics.newOutline(2, obstacleFull3)
     
     local obstacle3 = display.newImage(obstacleFull3)
     --obstaclesOutline = graphics.newOutline(2, obsSheet, 2);
  
     obstacle3.x = background.x
     obstacle3.y = background.y
  
     physics.addBody(obstacle3, "static", {outline = obstaclesOutline3, density=500})
      world:insert(obstacle3)
      
      local obstacleFull4 = "images/map3obstacles4.png"
      local obstaclesOutline4 = graphics.newOutline(2, obstacleFull4)
      local obstacle4 = display.newImage(obstacleFull4)
      --obstaclesOutline = graphics.newOutline(2, obsSheet, 2);
   
      obstacle4.x = background.x
      obstacle4.y = background.y
   
      physics.addBody(obstacle4, "static", {outline = obstaclesOutline4, density=500})
       world:insert(obstacle4)

       local obstacleFull5 = "images/map3obstacles5.png"
       local obstaclesOutline5 = graphics.newOutline(2, obstacleFull5)
       local obstacle5 = display.newImage(obstacleFull5)
       --obstaclesOutline = graphics.newOutline(2, obsSheet, 2);
    
       obstacle5.x = background.x
       obstacle5.y = background.y
    
       physics.addBody(obstacle5, "static", {outline = obstaclesOutline5, density=500})
        world:insert(obstacle5)
    
        local obstacleFull6 = "images/map3obstacles6.png"
        local obstaclesOutline6 = graphics.newOutline(2, obstacleFull6)
        local obstacle6 = display.newImage(obstacleFull6)
        --obstaclesOutline = graphics.newOutline(2, obsSheet, 2);
     
        obstacle6.x = background.x
        obstacle6.y = background.y
     
        physics.addBody(obstacle6, "static", {outline = obstaclesOutline6, density=500})
         world:insert(obstacle6)


   playerChar = player:new({x=display.contentCenterX, y=display.contentCenterY, inWater=true})
   playerChar:spawn()

   sceneGroup:insert(playerChar.sprite)
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

      if ( event.phase == "began" ) then
         print("hit")
      elseif ( event.phase == "ended" ) then
         print("no longer hit")
      end
   end

   local function updatePlayerRotation()
      playerChar.sprite.rotation = 0
   end

   Runtime:addEventListener("touch", movePlayer)
	playerChar.sprite.collision = onPlayerCollision
   playerChar.sprite:addEventListener("collision")

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
		camera = perspective.createView(2)	-- #DEBUG1
		camera:add(playerChar.sprite, 1) -- Add player to layer 1 of the camera	-- #DEBUG1
		camera:appendLayer()	-- add layer 0 in front of the camera	-- #DEBUG1
		
		camera:add(world, 2)	-- #DEBUG1
		camera:setParallax(0, 1) -- set parallax for each layer in descending order	-- #DEBUG1
		
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