local composer = require( "composer" )
local widget = require( "widget" )
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

   local function handleGameOverPressed(event)
        if (event.phase == "ended") then
            local options = {
                isModal = true
            }
            composer.showOverlay("game_over_screen", options)
        end
   end

   local function handleWinPressed(event)
        if (event.phase == "ended") then
            local options = {
                isModal = true
            }
            composer.showOverlay("win_screen", options)
        end
   end

   local goToGameOverButton = widget.newButton(
    {
        left = display.contentCenterX - 200,
        top = display.contentCenterY + 100,
        id = "gameOver",
        shape = "roundedRect",
        label = "Game Over",
        fillColor = { default={1,1,1,1}, over={0.9,0.9,0.9,0.9} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4,
        onEvent = handleGameOverPressed
    }
   )

   local goToWinButton = widget.newButton(
    {
        left = display.contentCenterX + 100,
        top = display.contentCenterY + 100,
        id = "win",
        shape = "roundedRect",
        label = "Win Game",
        fillColor = { default={1,1,1,1}, over={0.9,0.9,0.9,0.9} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4,
        onEvent = handleWinPressed
    }
   )

   goToGameOverButton.xScale, goToGameOverButton.yScale = 0.5, 0.5
   goToWinButton.xScale, goToWinButton.yScale = 0.5, 0.5

   sceneGroup:insert(goToGameOverButton)
   sceneGroup:insert(goToWinButton)

 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
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