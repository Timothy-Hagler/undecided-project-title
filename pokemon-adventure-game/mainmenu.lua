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
 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   local titleText = display.newText("Pokemon Adventure Game", display.contentCenterX, display.contentCenterY / 2, native.systemFont, 30)
   local background = display.newImage("mainmenu_background.png", display.contentCenterX, display.contentCenterY)

   local function playButtonPressed(event)
      if (event.phase == "ended") then
         composer.gotoScene("level3")
      end
   end

   -- Create the play button
   local playButton = widget.newButton(
      {
      left = display.contentCenterX - 75,
      top = display.contentCenterY,
      id = "playButton",
      label = "Play",
      labelColor = { default={0,0,0,1} },
      onEvent = playButtonPressed,
      emboss = false,
      -- Properties for a rounded rectangle button
      shape = "roundedRect",
      width = 200,
      height = 40,
      cornerRadius = 2,
      fillColor = { default={0.5,0.5,0.5,1}, over={0.5,0.5,0.5,0.5} },
      }
   )

   sceneGroup:insert(background)
   sceneGroup:insert(titleText)
   sceneGroup:insert(playButton)
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