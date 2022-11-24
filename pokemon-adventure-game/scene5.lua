-- Scene Composer for Route 1
local composer = require( "composer" )
local scene = composer.newScene()

local musicTrack
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   local background = display.newImage('route.png')
   background.x = display.contentCenterX
   background.y = display.contentCenterY
   sceneGroup:insert(background)

   local Options = {
   
      frames = {
      {x = 0, y = 0, 
      width = 320, height = 480}

      }
   }

   local obsSheet = graphics.newImageSheet("RouteObstacles.png", Options) 

   obstacles = display.newImage(obsSheet, 1);
   obstaclesOutline = graphics.newOutline(2, obsSheet, 1);

   obstacles.x = display.contentCenterX
   obstacles.y = display.contentCenterY

   physics.addBody(obstacles, "static", {outline = obstaclesOutline});

   sceneGroup:insert(obstacles)

   local int1Sheet = graphics.newImageSheet("RouteInteractables1.png", Options) 

   interactables1 = display.newImage(int1Sheet, 1);
   interactables1Outline = graphics.newOutline(2, int1Sheet, 1);

   interactables1.x = display.contentCenterX
   interactables1.y = display.contentCenterY

   physics.addBody(interactables1, "static", {outline = interactables1Outline});

   sceneGroup:insert(interactables1)

   local int2Sheet = graphics.newImageSheet("RouteInteractables2.png", Options) 

   interactables2 = display.newImage(int2Sheet, 1);
   interactables2Outline = graphics.newOutline(2, int2Sheet, 1);

   interactables2.x = display.contentCenterX
   interactables2.y = display.contentCenterY

   physics.addBody(interactables2, "static", {outline = interactables2Outline});

   sceneGroup:insert(interactables2)

   local boulderOptions = {
   
      frames = {
      {x = 0, y = 0, 
      width = 27, height = 28}

      }
   }

   local boulderSheet = graphics.newImageSheet("Boulder.png", boulderOptions) 

   boulder = display.newImage(boulderSheet, 1);
   boulderOutline = graphics.newOutline(2, boulderSheet, 1);

   boulder.x = 200
   boulder.y = 322

   physics.addBody(boulder, "dynamic", {outline = boulderOutline});

   sceneGroup:insert(boulder)

   local boulderGoalOptions = {
   
      frames = {
      {x = 0, y = 0, 
      width = 28, height = 24}

      }
   }

   local boulderGoalSheet = graphics.newImageSheet("BoulderGoal.png", boulderGoalOptions) 

   boulderGoal = display.newImage(boulderGoalSheet, 1);
   boulderGoalOutline = graphics.newOutline(2, boulderGoalSheet, 1);

   boulderGoal.x = 105
   boulderGoal.y = 322

   physics.addBody(boulderGoal, "dynamic", {outline = boulderGoalOutline});

   sceneGroup:insert(boulderGoal)

   musicTrack = audio.loadStream( "route1Music.mp3")

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
          audio.stop( 1 )

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