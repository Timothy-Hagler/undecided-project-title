local composer = require( "composer" )
local widget = require("widget")
local player = require("player")
local scene = composer.newScene()


local enemy, playerChar, background
-- import sprites(inherit player sprite and create enemy.lua file for enemy sprites)-- enemy 1 and enemy2
-- create health bar for enemy and playerChar
-- allow the player char to move where the user taps the screen
-- diminish health bar by level of pokemon
-- allow health bar puzzle bonus OR allow player to pick up randomly spawned potions for health boost
-- add pause button to call help scene
-- if the player dies from the enemy, dimish 1 life until life == 0 , gameover and return to start screen?
 
local function playerDeath()

   if(numOfLives == 0) then
      local options = {
         effect = "fade",
         time = 500
      }

      composer.gotoScene("mainmenu", options)

end

-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   local background = display.newImage('helpScreen.png')
   background.x = display.contentCenterX
   background.y = display.contentCenterY
   sceneGroup:insert(background)

   local button = display.newImage('back.png')
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