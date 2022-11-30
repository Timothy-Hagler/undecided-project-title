-- Win Screen
local composer = require( "composer" )
local scene = composer.newScene()
 
local function backButton()

   local options = {
      effect = "fade",
      time = 1000
   }
   composer.gotoScene("scene2", options)

end

-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   local background = display.newImage('images/menu.png')
   background.x = display.contentCenterX
   background.y = display.contentCenterY
   sceneGroup:insert(background)

   local winText = display.newText("YOU WIN!", 145, 220, "pokemon_fire_red.ttf", 38)
   winText:setFillColor(0.3,0.3,0.3)
   sceneGroup:insert(winText)
   winText:addEventListener("tap", backButton)

   local button = display.newImage('images/back.png')
   button.x = 270
   button.y = 45
   sceneGroup:insert(button)
   button:addEventListener("tap", backButton)

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