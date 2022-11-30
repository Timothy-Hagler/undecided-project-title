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
   playerChar = player:new({x=display.contentCenterX, y=display.contentCenterY, inWater=false})
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


   local function goToNextScene()

      local options = {
         effect = "fade",
         time = 500
      }
      composer.gotoScene("scene6", options)
   end

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



-- charmander (enemy)

   local charOpt = 
      {
         {x = 44, y = 136, width = 76, height = 84}, -- 1. full char
         {x = 181, y = 109, width = 42, height = 36}, -- 2. mini char sprite
         {x = 16, y = 269, width = 22, height = 32}, -- 3. char forward walk 1
         {x = 80, y = 271, width = 22, height = 32}, -- 4. char forward walk 2
         {x = 144, y = 269, width = 22, height = 32}, -- 5. char forward walk 3
         {x = 208, y = 271, width = 22, height = 32}, -- 6. char forward walk 4
         {x = 6, y = 333, width = 36, height = 32}, -- 7. char side run 1
         {x = 70, y = 335, width = 36, height = 32}, -- 8. char side run 2
         {x = 134, y = 333, width = 38, height = 32}, -- 9. char side run 3
         {x = 198, y = 335, width = 38, height = 32}, -- 10. char side run 4
         {x = 14, y = 397, width = 36, height = 32}, -- 11. char right 1
         {x = 78, y = 399, width = 36, height = 32}, -- 12. char right 2
         {x = 140, y = 397, width = 38, height = 32}, -- 13. char right 3
         {x = 204, y = 399, width = 38, height = 32}, -- 14. char right 4
       }

   local charSheet = graphics.newImageSheet("charmander.png", charOpt)

     -- create the sequence table
     local charSequenceData = 
     {
        { name = "attack", frames = {3,4,5,6}, time = 200, loopCount = 0},
        { name = "run", frames = {7,8,9,10}, time = 200, loopCount = 0},
        { name = "defend", frames = {11,12,13,14}, time = 200, loopCount = 0}
     }

     local charSprite = display.newSprite(charSheet, charSequenceData)
  

   -- bulbasaur (friend)
   local bulbOpt = 
   {
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
      {x = 10, y = 399, width = 38, height = 30}, -- 12. bulb right 1
      {x = 74, y = 401, width = 38, height = 30}, -- 13. bulb right 2
      {x = 138, y = 399, width = 38, height = 30}, -- 14. bulb right 3
      {x = 202, y = 401, width = 38, height = 30}, -- 15. bulb right 4
   }

   local bulbSheet = graphics.newImageSheet("bulbasaur.png")

  -- create the sequence table
   local bulbSequenceData = 
   {
      { name = "attack", frames = {4, 5, 6, 7}, time = 200, loopCount = 0},
      { name = "run", frames = {8, 9, 10}, time = 200, loopCount = 0},
      { name = "defend", frames = {12, 13, 14, 15}, time = 200, loopCount = 0}
   }

   local bulbSprite = display.newSprite(bulbSheet, bulbSequenceData)


-- squirtle (enemy)
   local squirtleOpt = 
      {
         {x = 39, y = 113, width = 76, height = 78}, -- 1. full squirtle
         {x = 185, y = 93, width = 42, height = 34}, -- 2. mini squirtle sprite
         {x = 17, y = 267, width = 22, height = 30}, -- 3. squirtle forward walk 1
         {x = 81, y = 269, width = 22, height = 30}, -- 4. squirtle forward walk 2
         {x = 145, y = 267, width = 22, height = 30}, -- 5. squirtle forward walk 3
         {x = 209, y = 269, width = 22, height = 30}, -- 6. squirtle forward walk 4
         {x = 17, y = 331, width = 30, height = 30}, -- 7. squirtle side run 1
         {x = 81, y = 333, width = 30, height = 30}, -- 8. squirtle side run 2
         {x = 145, y = 331, width = 30, height = 30}, -- 9. squirtle side run 3
         {x = 209, y = 333, width = 30, height = 30}, -- 10. squirtle side run 4
         {x = 11, y = 395, width = 30, height = 30}, -- 11. squirtle right 1
         {x = 75, y = 397, width = 30, height = 30}, -- 12. squirtle right 2
         {x = 139, y = 395, width = 30, height = 30}, -- 13. squirtle right 3
         {x = 203, y = 397, width = 30, height = 30}, -- 14. squirtle right 4
       }
   

   local squirtleSheet = graphics.newImageSheet("squirtle.png")

   -- create the sequence table
   local squirtleSequenceData = 
   {
      { name = "attack", frames = {3, 4, 5, 6}, time = 200, loopCount = 0},
      { name = "run", frames = {7, 8, 9, 10}, time = 200, loopCount = 0},
      { name = "defend", frames = {11, 12, 13, 14}, time = 200, loopCount = 0}
   }

   local squirtleSprite = display.newSprite(squirtleSheet, squirtleSequenceData)


   -- friend (pikachu)
   local pikachuOpt = 
   {
      {x = 6, y = 26, width = 36, height = 28}, -- attack
      {x = 52, y = 28, width = 36, height = 28},
      {x = 102, y = 25, width = 36, height = 28},
   }

   
   local pikachuSheet = graphics.newImageSheet("pikachu.png")

   -- create the sequence table
   local pikachuSequenceData = 
   {
      { name = "attack", frames = {1, 2, 3}, time = 200, loopCount = 0},
      { name = "run", frames = {7, 8, 9, 10}, time = 200, loopCount = 0},
      { name = "defend", frames = {11, 12, 13, 14}, time = 200, loopCount = 0}
   }

   local pikachuSprite = display.newSprite(pikachuSheet, pikachuSequenceData)


   





   
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

   Runtime:addEventListener("touch", movePlayer)
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