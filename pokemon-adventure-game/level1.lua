local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view

   physics.start()
   physics.setGravity(0,0)
   
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   local levelText = display.newText("Level 1", display.contentCenterX, display.contentCenterY / 2, native.systemFont, 30)

   local world = display.newGroup()

   local background = display.newImage("example_background.png", display.contentCenterX, display.contentCenterY)
   background.xScale = 0.4
   background.yScale = 0.4

   local myCharacter = display.newCircle(display.contentCenterX, display.contentCenterY, 25)
   physics.addBody(myCharacter, { density=0, friction=0.5, bounce=0.3 })

   local enemy = display.newCircle(display.contentCenterX + 100, display.contentCenterY, 25)
   enemy:setFillColor(1,0,0)
   physics.addBody(enemy, { density=500, friction=0.5, bounce=0.3 })

   local function onGlobalCollision( event )
       if ( event.phase == "began" ) then
            print("hit")
       elseif ( event.phase == "ended" ) then
            print("no longer hit")
       end
    end

   local function movePlayer(event)
        if (event.phase == "began" or event.phase == "moved") then
            transition.to(background, {x=event.x, y=event.y, time = 2000})
            transition.to(enemy, {x=event.x, y=event.y, time = 2000})
        elseif (event.phase == "ended") then
            transition.cancel(background)
            transition.cancel(enemy)
        end
   end


   local function update()
        myCharacter.x = display.contentCenterX
        myCharacter.y = display.contentCenterY
   end

   local function moveEnemyReverse(event)
        transition.to(enemy, {time=1000, x=enemy.x - 100, y=enemy.y - 50, onComplete=moveEnemyStart})
   end

   local function moveEnemyStart(event)
        transition.to(enemy, {time=1000, x=enemy.x + 100, y=enemy.y + 50, onComplete=moveEnemyReverse})
   end

    timer.performWithDelay(0, update, 0)
    moveEnemyStart()

   -- note: order matters here. If background is insert last, it covers everything else
   sceneGroup:insert(background)
   sceneGroup:insert(myCharacter)
   sceneGroup:insert(enemy)
   sceneGroup:insert(levelText)

   Runtime:addEventListener("touch", movePlayer)
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