-- Scene Composer for cave route (level 2)
local composer = require( "composer" )
local perspective = require( "lib.perspective.perspective" )
local scene = composer.newScene()
local player = require("player")
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
   updatedFile:write('scene7' .. ',' .. '100' .. ',' .. '3')
   io.close(updatedFile)
end

-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
	world = display.newGroup()

   physics.start()
   physics.setGravity(0,0)
   physics.setDrawMode("hybrid")

   local hugeBackground = display.newImage("images/gymMap.jpg")
   hugeBackground.x = display.contentCenterX
   hugeBackground.y = display.contentCenterY*0.01 - 45
   hugeBackground.xScale, hugeBackground.yScale = 50, 50
    world:insert(hugeBackground)

   local background = display.newImage("images/gymMap.jpg")
   background.x = display.contentCenterX
   background.y = display.contentCenterY*0.01 - 45
	world:insert(background)

	
	local imgpath = "images/gymObstacle.png"
	local obstacle1 = obstacle:new({ img=imgpath, outline=graphics.newOutline(2, imgpath, 1), bodyType="static",
		x=background.x, y=background.y })
	obstacle1:spawn()
	world:insert(obstacle1.sprite)


	local obstacleFull2 = "images/gymObstacle2.png"
	local obstaclesOutline2 = graphics.newOutline(2, obstacleFull2)
	local obstacle2 = display.newImage(obstacleFull2)
	
	obstacle2.x = background.x
	obstacle2.y = background.y

	physics.addBody(obstacle2, "static", {outline = obstaclesOutline2, density=500})
	world:insert(obstacle2)

	local obstacleFull3 = "images/gymObstacle3.png"
local obstaclesOutline3 = graphics.newOutline(2, obstacleFull3)
local obstacle3 = display.newImage(obstacleFull3)
   
   
   obstacle3.x = background.x
   obstacle3.y = background.y

   physics.addBody(obstacle3, "static", {outline = obstaclesOutline3, density=500})
    world:insert(obstacle3)

    local obstacleFull4 = "images/gymObstacle4.png"
    local obstaclesOutline4 = graphics.newOutline(2, obstacleFull4)
    local obstacle4 = display.newImage(obstacleFull4)
    
    
    obstacle4.x = background.x
    obstacle4.y = background.y
 
    physics.addBody(obstacle4, "static", {outline = obstaclesOutline4, density=500})
     world:insert(obstacle4)

     local obstacleFull5 = "images/gymObstacle5.png"
     local obstaclesOutline5 = graphics.newOutline(2, obstacleFull5)
     local obstacle5 = display.newImage(obstacleFull5)
     
     
     obstacle5.x = background.x
     obstacle5.y = background.y
  
     physics.addBody(obstacle5, "static", {outline = obstaclesOutline5, density=500})
      world:insert(obstacle5)

      local obstacleFull6 = "images/gymObstacle6.png"
      local obstaclesOutline6 = graphics.newOutline(2, obstacleFull6)
      local obstacle6 = display.newImage(obstacleFull6)
      
      
      obstacle6.x = background.x
      obstacle6.y = background.y
   
      physics.addBody(obstacle6, "static", {outline = obstaclesOutline6, density=500})
       world:insert(obstacle6)

       local obstacleFull8 = "images/gymObstacle8.png"
       local obstaclesOutline8 = graphics.newOutline(2, obstacleFull8)
       local obstacle8 = display.newImage(obstacleFull8)
       
       
       obstacle8.x = background.x
       obstacle8.y = background.y
    
       physics.addBody(obstacle8, "static", {outline = obstaclesOutline8, density=500})
        world:insert(obstacle8)

        local obstacleFull7 = "images/gymObstacle7.png"
        local obstaclesOutline7 = graphics.newOutline(2, obstacleFull7)
        local obstacle7 = display.newImage(obstacleFull7)
        
        
        obstacle7.x = background.x
        obstacle7.y = background.y
     
        physics.addBody(obstacle7, "static", {outline = obstaclesOutline7, density=500})
         world:insert(obstacle7)


    local bulbOptions =
    {
        frames = {
            {x = 39, y = 119, width = 70, height = 66}, -- 1. full bulb
            {x = 183, y = 91, width = 40, height = 34}, -- 2. mini bulb sprite
            {x = 365, y = 197, width = 51, height = 36}, -- 3. bulb back (color from background might be included oops
            {x = 12, y = 271, width = 30, height = 32}, -- 4. bulb forward walk 1
            {x = 76, y = 273, width = 30, height = 32}, -- 5. bulb forward walk 2
            {x = 140, y = 271, width = 30, height = 32}, -- 6. bulb forward walk 3
            {x = 204, y = 273, width = 30, height = 32}, -- 7. bulb forward walk 4
            {x = 8, y = 335, width = 38, height = 30}, -- 8. bulb side run 1
            {x = 72, y = 337, width = 38, height = 30}, -- 9. bulb side run 2
            {x = 136, y = 335, width = 38, height = 30}, -- 10. bulb side run 3
            --{x = , y = , width = 38, height = 30}, -- 11. bulb side run 4
            {x = 10, y = 399, width = 38, height = 30}, -- 12. bulb right 1
            {x = 74, y = 401, width = 38, height = 30}, -- 13. bulb right 2
            {x = 138, y = 399, width = 38, height = 30}, -- 14. bulb right 3
            {x = 202, y = 401, width = 38, height = 30}, -- 15. bulb right 4
        }
    }

    local bulbSheet = graphics.newImageSheet("spritesheets/bulbsprites.png", bulbOptions)
    local bulbasaur = display.newImage(bulbSheet, 4)
    bulbasaur.x = background.x
    bulbasaur.y = background.y - 275
	physics.addBody(bulbasaur, "static");
    world:insert(bulbasaur)

   playerChar = player:new({x=display.contentCenterX, y=display.contentCenterY, inWater=false})
   playerChar:spawn()

   sceneGroup:insert(playerChar.sprite)
   

 --[[  local boulderOptions = {
    frames = {
    {x = 0, y = 0, 
    width = 27, height = 28}
    }
 }
  local boulderSheet = graphics.newImageSheet('images/boulder.png', boulderOptions)
  local boulderOutline = graphics.newOutline(2, boulderSheet, 1)
  local boulder = obstacle:new({ img=boulderSheet, imgIdx=1, outline=boulderOutline, x=200, y=322 })
  boulder:spawn()
  world:insert(boulder.sprite) ]]--

  sceneGroup:insert(world)

   musicTrack = audio.loadStream( "audio/gymMusic.mp3")


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