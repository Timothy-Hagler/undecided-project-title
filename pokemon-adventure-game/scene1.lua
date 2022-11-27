-- Main Menu Screen
local composer = require( "composer" )
local scene = composer.newScene()

local musicTrack
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------


local function showGame()

    audio.stop( 1 )

   local options = {
      effect = "fade",
      time = 500
   }
   composer.gotoScene("scene5", options)

end

local function exit()

  os.exit()

end

local function showCredits()

   local options = {
      effect = "fade",
      time = 500
   }
   composer.gotoScene("scene2", options)

end

local function showHelp()

   local options = {
      effect = "fade",
      time = 500
   }
   composer.gotoScene("scene3", options)

end




-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.

   local background = display.newImage('menu.png')
   background.x = display.contentCenterX
   background.y = display.contentCenterY
   sceneGroup:insert(background)

   local myText = display.newText("PLAY", 145, 204, "pokemon_fire_red.ttf", 36)
   myText:setFillColor(0.3,0.3,0.3)
   sceneGroup:insert(myText)
   myText:addEventListener("tap", showGame)

   local myText = display.newText("CREDITS", 165, 254, "pokemon_fire_red.ttf", 36)
   myText:setFillColor(0.3,0.3,0.3)
   sceneGroup:insert(myText)
   myText:addEventListener("tap", showCredits)

   local myText = display.newText("HOW TO\nPLAY", 154, 314, "pokemon_fire_red.ttf", 36)
   myText:setFillColor(0.3,0.3,0.3)
   sceneGroup:insert(myText)
   myText:addEventListener("tap", showHelp)

   local myText = display.newText("EXIT", 145, 376, "pokemon_fire_red.ttf", 36)
   myText:setFillColor(0.3,0.3,0.3)
   sceneGroup:insert(myText)
   myText:addEventListener("tap", exit)

   musicTrack = audio.loadStream( "menuMusic.mp3")

end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).

   elseif ( phase == "did" ) then
         audio.play( musicTrack, { channel=1, loops=-1 } )

   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then

   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
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