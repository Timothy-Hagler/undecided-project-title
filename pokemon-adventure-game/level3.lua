local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local touchInUse = false
-- local world = display.newGroup()
-- world.x = display.contentCenterX
-- world.y = display.contentCenterY -- track world movement
worldTable = {}
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.

   local sceneGroup = self.view
   physics.start()
   physics.setGravity(0,0)
   
   local levelText = display.newText("Level 3", display.contentCenterX, display.contentCenterY / 4, native.systemFont, 30)
   
   --[[
      world = display.newGroup()
      world.x = 0
      world.y = 0 -- track world movement
      sceneGroup:insert(world)
   ]]

   local background = display.newImage("map3stuff/map3full.png", display.contentCenterX*1.95, -145)
   background.xScale = 1
   background.yScale = 1

   -- world:insert(background)   -- disabled: group transitions not working?
   table.insert(worldTable, background);

   local water = display.newImage("map3stuff/map3fullwater.png", display.contentCenterX*1.95, -145)
   water.xScale = 1
   water.yScale = 1
   table.insert(worldTable, water)

   local obstacles = display.newImage("map3stuff/map3obstacles.png", display.contentCenterX*1.95, -145)
   obstacles.xScale = 1
   obstacles.yScale = 1
   table.insert(worldTable, obstacles)

   local myCharacter = display.newCircle(display.contentCenterX, display.contentCenterY, 25)
   physics.addBody(myCharacter, "kinematic", { density=0, friction=0.5, bounce=0.3 })
   myCharacter:toFront()
   levelText:toFront()

   --local enemy = display.newCircle(display.contentCenterX + 100, display.contentCenterY, 25)
   --enemy:setFillColor(1,0,0)
   --physics.addBody(enemy, "kinematic", { density=500, friction=0.5, bounce=0.3 })
   -- world:insert(enemy)
   --table.insert(worldTable, enemy);

   local function onGlobalCollision( event )
      print( "handler" )
      if ( event.phase == "began" ) then
         print("hit")
      elseif ( event.phase == "ended" ) then
         print("no longer hit")
      end
   end
   
   local function movePlayer(event)
      -- interrupt any existing events to move to the new requested location
      if (touchInUse) then
         for i,v in ipairs(worldTable) do
            transition.cancel(v)
         end
      end
      touchInUse = true

      --[[
         -- #DEBUG
      print("STARTING MOVEMENT: "..event.x..", "..event.y)
      print("\tWITH BKGND AT: "..background.x..", "..background.y)
      print("\tEXP DELTA: "..event.x-background.x..", "..event.y-background.y)
      ]]
      -- transition.moveBy(world, {time = 1000, x=display.contentCenterX-event.x, y=display.contentCenterY-event.y, onComplete=function() touchInUse = false end}) -- disabled: group transitions not working?
      for i,v in ipairs(worldTable) do
         -- print(i, v)
         transition.moveBy(v, {time = 1000, x=display.contentCenterX-event.x, y=display.contentCenterY-event.y, onComplete=function() touchInUse = false end})
      end
   end


   local function update()
        myCharacter.x = display.contentCenterX
        myCharacter.y = display.contentCenterY
        myCharacter:toFront()
        --print(background.y)
   end

   -- local function moveEnemyReverse(event)
   --      transition.to(enemy, {time=1000, x=enemy.x - 100, y=enemy.y - 50, onComplete=moveEnemyStart})
   -- end

   -- local function moveEnemyStart(event)
   --      transition.to(enemy, {time=1000, x=enemy.x + 100, y=enemy.y + 50, onComplete=moveEnemyReverse})
   -- end

    timer.performWithDelay(0, update, 0)
   --  moveEnemyStart()

   -- note: order matters here. If background is insert last, it covers everything else
   sceneGroup:insert(background)
   sceneGroup:insert(myCharacter)
   -- sceneGroup:insert(enemy)
   sceneGroup:insert(levelText)

   Runtime:addEventListener("tap", movePlayer)  -- # TODO: was formerly touch
   Runtime:addEventListener("collision", onGlobalCollision)
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
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
      physics:pause()
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