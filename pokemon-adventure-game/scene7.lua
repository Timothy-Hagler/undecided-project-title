-- Scene Composer for cave route (level 2)
local composer = require("composer")
local perspective = require("lib.perspective.perspective")
local scene = composer.newScene()
local player = require("player")
local obstacle = require("obstacle")
local musicTrack
local camera, world
if playerChar == nil then
   playerChar = player:new({x=display.contentCenterX, y=display.contentCenterY, inWater=true, tag = "player"})
else
   playerChar.inWater = true
   playerChar.y = display.contentCenterY
end
local player_velocity_scale = 150
worldTable = {}
local numOfLives = 3


local function updateSavedGame()
	local path = system.pathForFile("save.csv", system.DocumentsDirectory)
	local updatedFile = io.open(path, "w+")
	updatedFile:write('scene' .. ',' .. 'health' .. ',' .. 'lives')
	updatedFile:write('\n')
	updatedFile:write('scene7' .. ',' .. '100' .. ',' .. '3')
	io.close(updatedFile)
end

-- "scene:create()"
function scene:create(event)

	local sceneGroup = self.view
	world = display.newGroup()

   physics.start()
   physics.setGravity(0,0)

	local hugeBackground = display.newImage("images/gymMap.jpg")
	hugeBackground.x = display.contentCenterX
	hugeBackground.y = display.contentCenterY * 0.01 - 45
	hugeBackground.xScale, hugeBackground.yScale = 50, 50
	world:insert(hugeBackground)

	local background = display.newImage("images/gymMap.jpg")
	background.x = display.contentCenterX
	background.y = display.contentCenterY * 0.01 - 45
	world:insert(background)



	local Options = {
		frames = {
			{ x = 0, y = 0,
				width = 320, height = 480 }

		}
	}

	local obstacleFull = "images/gymObstacle.png"
	local obstaclesOutline = graphics.newOutline(2, obstacleFull)
	local obstacle1 = display.newImage(obstacleFull)
	obstaclesOutline.alpha = 0

	obstacle1.x = background.x
	obstacle1.y = background.y

	physics.addBody(obstacle1, "static", { outline = obstaclesOutline, density = 500 })
	world:insert(obstacle1)

	local obstacleFull2 = "images/gymObstacle2.png"
	local obstaclesOutline2 = graphics.newOutline(2, obstacleFull2)
	local obstacle2 = display.newImage(obstacleFull2)

	obstacle2.x = background.x
	obstacle2.y = background.y

	physics.addBody(obstacle2, "static", { outline = obstaclesOutline2, density = 500 })
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

         local ledgeFull = "images/gymLedge.png"
         local ledgeOutline = graphics.newOutline(2, ledgeFull)
         local ledge = display.newImage(ledgeFull)
         
         
         ledge.x = background.x
         ledge.y = background.y
      
         physics.addBody(ledge, "static", {outline = ledgeOutline, density=500})
          world:insert(ledge)

          local ledgeFull2 = "images/gymLedge2.png"
          local ledgeOutline2 = graphics.newOutline(2, ledgeFull2)
          local ledge2 = display.newImage(ledgeFull2)
          
          
          ledge2.x = background.x
          ledge2.y = background.y
       
          physics.addBody(ledge2, "static", {outline = ledgeOutline2, density=500})
           world:insert(ledge2)

           local ledgeFull3 = "images/gymLedge3.png"
           local ledgeOutline3 = graphics.newOutline(2, ledgeFull3)
           local ledge3 = display.newImage(ledgeFull3)
           
           
           ledge3.x = background.x
           ledge3.y = background.y
        
           physics.addBody(ledge3, "static", {outline = ledgeOutline3, density=500})
            world:insert(ledge3)

            local ledgeFull4 = "images/gymLedge4.png"
            local ledgeOutline4 = graphics.newOutline(2, ledgeFull4)
            local ledge4 = display.newImage(ledgeFull4)
            
            
            ledge4.x = background.x
            ledge4.y = background.y
         
            physics.addBody(ledge4, "static", {outline = ledgeOutline4, density=500})
             world:insert(ledge4)

             local ledgeFull5 = "images/gymLedge5.png"
             local ledgeOutline5 = graphics.newOutline(2, ledgeFull5)
             local ledge5 = display.newImage(ledgeFull5)
             
             
             ledge5.x = background.x
             ledge5.y = background.y
          
             physics.addBody(ledge5, "static", {outline = ledgeOutline5, density=500})
              world:insert(ledge5)

              local ledgeFull6 = "images/gymLedge6.png"
              local ledgeOutline6 = graphics.newOutline(2, ledgeFull6)
              local ledge6 = display.newImage(ledgeFull6)
              
              
              ledge6.x = background.x
              ledge6.y = background.y
           
              physics.addBody(ledge6, "static", {outline = ledgeOutline6, density=500})
               world:insert(ledge6)

               local ledgeFull7 = "images/gymLedge7.png"
               local ledgeOutline7 = graphics.newOutline(2, ledgeFull7)
               local ledge7 = display.newImage(ledgeFull7)
               
               
               ledge7.x = background.x
               ledge7.y = background.y
            
               physics.addBody(ledge7, "static", {outline = ledgeOutline7, density=500})
                world:insert(ledge7)

                local ledgeFull8 = "images/gymLedge8.png"
                local ledgeOutline8 = graphics.newOutline(2, ledgeFull8)
                local ledge8 = display.newImage(ledgeFull8)
                
                
                ledge8.x = background.x
                ledge8.y = background.y
             
                physics.addBody(ledge8, "static", {outline = ledgeOutline8, density=500})
                 world:insert(ledge8)

                 local ledgeFull9 = "images/gymLedge9.png"
                 local ledgeOutline9 = graphics.newOutline(2, ledgeFull9)
                 local ledge9 = display.newImage(ledgeFull9)
                 
                 
                 ledge9.x = background.x
                 ledge9.y = background.y
              
                 physics.addBody(ledge9, "static", {outline = ledgeOutline9, density=500})
                  world:insert(ledge9)


        -- bulbasaur (friend)
   local bulbOpt = 
   {
      frames =
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
   }

   local bulbSheet = graphics.newImageSheet("spritesheets/bulbasaur.png",bulbOpt)

  -- create the sequence table
   local bulbSequenceData = 
   {
      { name = "attack", frames = {4, 5, 6, 7}, time = 200, loopCount = 0},
      { name = "run", frames = {8, 9, 10}, time = 200, loopCount = 0},
      { name = "defend", frames = {12, 13, 14, 15}, time = 200, loopCount = 0}
   }

   local bulbSprite = display.newSprite(bulbSheet, bulbSequenceData)

   bulbSprite.x = display.contentCenterX - 100
   bulbSprite.y = display.contentCenterY - 200           
   
   world:insert(bulbSprite)





  


    local circle1 = display.newCircle(display.contentCenterX, display.contentCenterY, 100)
   -- local circle1 = display.newCircle(display.contentCenterX,display.contentCenterY,100)
    circle1.alpha = 0
    -- hide the circle
    physics.addBody(circle1, "static", {radius = 100})
    circle1.isSensor = true
    
    
    
    -- add collision event
   


-- add collision event
local function circleCollision (event)
   if(event.phase == "began") then
      print("CIRCLE1")
      print(event.other)
      print(playerChar)


      local overlayOptions = { -- options for scene overlay
         effect = "fade",
         time = 500,
         isModal = true,
         params = {
            nextScene = "scene5",
            currScene = "scene6",
            pokemon = "charmander",
            numOfLives = numOfLives,
         }
      }
      composer.showOverlay("battleScene", overlayOptions)

      --[[ -- draw battle button
      local function handleButtonEvent( buttonEvent )
         if("ended" == buttonEvent.phase) then
            composer.showOverlay("battleScene", overlayOptions)
         end
      end



      local battleButton = widget.newButton(
         {
            left = display.contentCenterX - 100,
            top = display.contentCenterY + 200,
            id = "battleButton",
            shape = "roundedRect",
            label = "BATTLE",
            onEvent = handleButtonEvent
         }
      )
 ]]
   end
end
    
    circle1:addEventListener("collision", circleCollision)
    -- call the battle scene overlay here if the radius is encountered at a certain x and y positions
    
    
    


   playerChar = player:new({x=display.contentCenterX, y=display.contentCenterY, inWater=false})
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
 local boulder = obstacle:new({ img=boulderSheet, imgIdx=1, outline=boulderOutline, -270, 489 })
 local boulder2 = obstacle:new({ img=boulderSheet, imgIdx=1, outline=boulderOutline, -270, 489 })
 local boulder3 = obstacle:new({ img=boulderSheet, imgIdx=1, outline=boulderOutline, -270, 489 })
 local boulder4 = obstacle:new({ img=boulderSheet, imgIdx=1, outline=boulderOutline, -270, 489 })
 boulder:spawn()
 boulder2:spawn()
 boulder3:spawn()
 boulder4:spawn()
 world:insert(boulder.sprite)
    boulder.sprite.x = -140
    boulder.sprite.y = 169
    world:insert(boulder2.sprite)
    boulder2.sprite.x = 164
    boulder2.sprite.y = 104
    world:insert(boulder3.sprite)
    boulder3.sprite.x = 370
    boulder3.sprite.y = 126
    world:insert(boulder4.sprite)
    boulder4.sprite.x = 154
    boulder4.sprite.y = -163


   musicTrack = audio.loadStream( "audio/gymMusic.mp3")


	-- Move the world wrt. the player to simulate player movement
	local function movePlayer(event)
		-- print(event.phase)
		if (event.phase == "moved" or event.phase == "began") then
			local xvel, yvel
			xvel = (event.x - display.contentCenterX) / (display.contentWidth / 2) * player_velocity_scale
			yvel = (event.y - display.contentCenterY) / (display.contentHeight / 2) * player_velocity_scale
			playerChar:move(xvel, yvel)

		elseif (event.phase == "ended") then
			playerChar:StopMoving()
		end
	end

	local function onGlobalCollision(event)
		transition.cancel(event.target)
		print("collision handler")
		print(event.phase)
		if (event.phase == "began") then
			print("hit")
		elseif (event.phase == "ended") then
			print("no longer hit")
		end
	end

	local function onPlayerCollision(self, event)
		transition.cancel(event.target)

		if (event.phase == "began") then
			print("hit at " .. playerChar.sprite.x .. " " .. playerChar.sprite.y)

		elseif (event.phase == "ended") then
			print("no longer hit")
		end
	end

	local function updatePlayerRotation()
		playerChar.sprite.rotation = 0
	end

	Runtime:addEventListener("touch", movePlayer)
	playerChar.sprite.collision = onPlayerCollision
	playerChar.sprite:addEventListener("collision")

	timer.performWithDelay(0, updatePlayerRotation, -1)
	updateSavedGame()
	--Runtime:addEventListener("collision", onGlobalCollision)	-- global collision
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	playerChar.sprite.x = display.contentCenterX
	playerChar.sprite.y = display.contentCenterY

	if (phase == "will") then
		--------------------------------
		-- Camera Tracking
		--------------------------------
		camera = perspective.createView(2) -- #DEBUG1
		camera:add(playerChar.sprite, 1) -- Add player to layer 1 of the camera	-- #DEBUG1
		camera:appendLayer() -- add layer 0 in front of the camera	-- #DEBUG1

		camera:add(world, 2) -- #DEBUG1
		camera:setParallax(0, 1) -- set parallax for each layer in descending order	-- #DEBUG1

		camera.damping = 10 -- A bit more fluid tracking
		camera:setFocus(playerChar.sprite) -- Set the focus to the player
		print("Layers: " .. camera:layerCount())
	elseif (phase == "did") then
		-- Called when the scene is now on screen.
		-- Insert code here to make the scene come alive.
		-- Example: start timers, begin animation, play audio, etc.
		camera:track() -- Begin auto-tracking
		audio.play(musicTrack, { channel = 1, loops = -1 })
	end
end

function scene:hide(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		audio.stop(1)
		updateSavedGame()

	elseif (phase == "did") then
		-- Called immediately after scene goes off screen.
		camera:destroy()
	end
end

function scene:destroy(event)

	local sceneGroup = self.view
	updateSavedGame()

	-- Called prior to the removal of scene's view ("sceneGroup").
	-- Insert code here to clean up the scene.
	-- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
---------------------------------------------------------------------------------

return scene
