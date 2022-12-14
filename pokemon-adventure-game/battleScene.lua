local composer = require("composer")
local widget = require("widget")
local player = require("player")
local scene = composer.newScene()
local params

local enemy, playerChar, background
-- import sprites(inherit player sprite and create enemy.lua file for enemy sprites)-- enemy 1 and enemy2
-- create health bar for enemy and playerChar
-- allow the player char to move where the user taps the screen
-- diminish health bar by level of pokemon
-- allow health bar puzzle bonus OR allow player to pick up randomly spawned potions for health boost
-- add pause button to call help scene
-- if the player dies from the enemy, dimish 1 life until life == 0 , gameover and return to start screen?

local function playerDeath()


	local options = {
		effect = "fade",
		time = 500
	}

	composer.gotoScene("scene1", options) -- gameover if all lives lost


end

function scene:goToNextScene()

	local nextOptions = {
		effect = "fade",
		time = 500
	}
	if (params.nextScene == "scene8") then
		os.exit()
	elseif (params.lastToWin and (params.lastToWin == true) ) then
		composer.gotoScene("winScreen", nextOptions)
	else
		composer.gotoScene(params.nextScene, nextOptions)
	end
end

function scene:goToPreviousScene()

	local prevOptions = {
		effect = "fade",
		time = 500
	}
	composer.gotoScene(params.currScene, prevOptions)
end

-- "scene:create()"
function scene:create(event)
	local sceneGroup = self.view

	params = event.params -- reference to parent object
	local numOfLives = params.numOfLives

	local background = display.newRect(display.contentCenterX, display.contentCenterY, 500, 500)
	sceneGroup:insert(background)
	-- add the attack button and functionality
	-- add the health bars for enemy and player's pokemon

	local playerHealthBar = widget.newProgressView(
		{
			left = display.contentCenterX - 100,
			top = display.contentCenterY + 40,
			width = 50,
			isAnimated = true
		}
	)
	playerHealthBar:setProgress(1) -- 1 = 100%
	sceneGroup:insert(playerHealthBar)

	local enemyHealthBar = widget.newProgressView(
		{
			left = display.contentCenterX + 60,
			top = display.contentCenterY - 180,
			width = 50,
			isAnimated = true
		}
	)
	enemyHealthBar:setProgress(1)
	sceneGroup:insert(enemyHealthBar)

	-- insert charmander sprite and pikachu sprite

	-- charmander (enemy)
	if (params.pokemon == "charmander") then
		local charOpt =
		{
			frames = {
				{ x = 44, y = 136, width = 76, height = 84 }, -- 1. full char
				{ x = 181, y = 109, width = 42, height = 36 }, -- 2. mini char sprite
				{ x = 16, y = 269, width = 22, height = 32 }, -- 3. char forward walk 1
				{ x = 80, y = 271, width = 22, height = 32 }, -- 4. char forward walk 2
				{ x = 144, y = 269, width = 22, height = 32 }, -- 5. char forward walk 3
				{ x = 208, y = 271, width = 22, height = 32 }, -- 6. char forward walk 4
				{ x = 6, y = 333, width = 36, height = 32 }, -- 7. char side run 1
				{ x = 70, y = 335, width = 36, height = 32 }, -- 8. char side run 2
				{ x = 134, y = 333, width = 38, height = 32 }, -- 9. char side run 3
				{ x = 198, y = 335, width = 38, height = 32 }, -- 10. char side run 4
				{ x = 14, y = 397, width = 36, height = 32 }, -- 11. char right 1
				{ x = 78, y = 399, width = 36, height = 32 }, -- 12. char right 2
				{ x = 140, y = 397, width = 38, height = 32 }, -- 13. char right 3
				{ x = 204, y = 399, width = 38, height = 32 }, -- 14. char right 4
			}
		}

		local charSheet = graphics.newImageSheet("spritesheets/charmander.png", charOpt)

		-- create the sequence table
		local charSequenceData =
		{
			{ name = "attack", frames = { 3, 4, 5, 6 }, time = 200, loopCount = 0 },
			{ name = "run", frames = { 7, 8, 9, 10 }, time = 200, loopCount = 0 },
			{ name = "defend", frames = { 11, 12, 13, 14 }, time = 200, loopCount = 0 }
		}

		local charSprite = display.newSprite(charSheet, charSequenceData)

		charSprite.x = display.contentCenterX + 80
		charSprite.xScale = 2.5
		charSprite.y = display.contentCenterY - 100
		charSprite.yScale = 2.5
		sceneGroup:insert(charSprite)
	end



	-- friend (pikachu)
	local pikachuOpt =
	{
		frames =
		{
			{ x = 6, y = 26, width = 36, height = 28 }, -- attack
			{ x = 52, y = 28, width = 36, height = 28 },
			{ x = 102, y = 25, width = 36, height = 28 }
		}
	}


	local pikachuSheet = graphics.newImageSheet("spritesheets/pikachu.png", pikachuOpt)

	-- create the sequence table
	local pikachuSequenceData =
	{
		{ name = "attack", frames = { 1, 2, 3 }, time = 200, loopCount = 0 },
		{ name = "run", frames = { 7, 8, 9, 10 }, time = 200, loopCount = 0 },
		{ name = "defend", frames = { 11, 12, 13, 14 }, time = 200, loopCount = 0 }
	}

	local pikachuSprite = display.newSprite(pikachuSheet, pikachuSequenceData)

	pikachuSprite.x = display.contentCenterX - 80
	pikachuSprite.y = display.contentCenterY + 120

	pikachuSprite.xScale = 4
	pikachuSprite.yScale = 4
	sceneGroup:insert(pikachuSprite)



	if (params.pokemon == "bulbasaur") then

		-- bulbasaur (friend)
		local bulbOpt =
		{
			frames =
			{
				{ x = 39, y = 119, width = 70, height = 66 }, -- 1. full bulb
				{ x = 183, y = 91, width = 40, height = 34 }, -- 2. mini bulb sprite
				{ x = 365, y = 197, width = 51, height = 36 }, -- 3. bulb back (color from background might be included oops
				{ x = 12, y = 271, width = 30, height = 32 }, -- 4. bulb forward walk 1
				{ x = 76, y = 273, width = 30, height = 32 }, -- 5. bulb forward walk 2
				{ x = 140, y = 271, width = 30, height = 32 }, -- 6. bulb forward walk 3
				{ x = 204, y = 273, width = 30, height = 32 }, -- 7. bulb forward walk 4
				{ x = 8, y = 335, width = 38, height = 30 }, -- 8. bulb side run 1
				{ x = 72, y = 337, width = 38, height = 30 }, -- 9. bulb side run 2
				{ x = 136, y = 335, width = 38, height = 30 }, -- 10. bulb side run 3
				{ x = 10, y = 399, width = 38, height = 30 }, -- 12. bulb right 1
				{ x = 74, y = 401, width = 38, height = 30 }, -- 13. bulb right 2
				{ x = 138, y = 399, width = 38, height = 30 }, -- 14. bulb right 3
				{ x = 202, y = 401, width = 38, height = 30 }, -- 15. bulb right 4
			}
		}

		local bulbSheet = graphics.newImageSheet("spritesheets/bulbasaur.png", bulbOpt)

		-- create the sequence table
		local bulbSequenceData =
		{
			{ name = "attack", frames = { 4, 5, 6, 7 }, time = 200, loopCount = 0 },
			{ name = "run", frames = { 8, 9, 10 }, time = 200, loopCount = 0 },
			{ name = "defend", frames = { 12, 13, 14, 15 }, time = 200, loopCount = 0 }
		}

		local bulbSprite = display.newSprite(bulbSheet, bulbSequenceData)

		bulbSprite.x = display.contentCenterX + 80
		bulbSprite.xScale = 2.5
		bulbSprite.y = display.contentCenterY - 100
		bulbSprite.yScale = 2.5
		sceneGroup:insert(bulbSprite)

	end

	if (params.pokemon == "squirtle") then

		-- squirtle (enemy)
		local squirtleOpt =
		{
			frames =
			{
				{ x = 39, y = 113, width = 76, height = 78 }, -- 1. full squirtle
				{ x = 185, y = 93, width = 42, height = 34 }, -- 2. mini squirtle sprite
				{ x = 17, y = 267, width = 22, height = 30 }, -- 3. squirtle forward walk 1
				{ x = 81, y = 269, width = 22, height = 30 }, -- 4. squirtle forward walk 2
				{ x = 145, y = 267, width = 22, height = 30 }, -- 5. squirtle forward walk 3
				{ x = 209, y = 269, width = 22, height = 30 }, -- 6. squirtle forward walk 4
				{ x = 17, y = 331, width = 30, height = 30 }, -- 7. squirtle side run 1
				{ x = 81, y = 333, width = 30, height = 30 }, -- 8. squirtle side run 2
				{ x = 145, y = 331, width = 30, height = 30 }, -- 9. squirtle side run 3
				{ x = 209, y = 333, width = 30, height = 30 }, -- 10. squirtle side run 4
				{ x = 11, y = 395, width = 30, height = 30 }, -- 11. squirtle right 1
				{ x = 75, y = 397, width = 30, height = 30 }, -- 12. squirtle right 2
				{ x = 139, y = 395, width = 30, height = 30 }, -- 13. squirtle right 3
				{ x = 203, y = 397, width = 30, height = 30 }, -- 14. squirtle right 4
			}
		}


		local squirtleSheet = graphics.newImageSheet("spritesheets/squirtle.png", squirtleOpt)

		-- create the sequence table
		local squirtleSequenceData =
		{
			{ name = "attack", frames = { 3, 4, 5, 6 }, time = 200, loopCount = 0 },
			{ name = "run", frames = { 7, 8, 9, 10 }, time = 200, loopCount = 0 },
			{ name = "defend", frames = { 11, 12, 13, 14 }, time = 200, loopCount = 0 }
		}

		local squirtleSprite = display.newSprite(squirtleSheet, squirtleSequenceData)

		squirtleSprite.x = display.contentCenterX + 80
		squirtleSprite.xScale = 2.5
		squirtleSprite.y = display.contentCenterY - 100
		squirtleSprite.yScale = 2.5
		sceneGroup:insert(squirtleSprite)

	end



	-- create attack and defend randomizer for the enemy
	local function randAttackOrDefend()
		return math.random(0, 1)
	end

	-- draw attack and defend buttons
	local function handleAttackButtonEvent(event)
		local randNum = randAttackOrDefend() -- defend = 1 attack = 0
		if ("ended" == event.phase) then
			if (randNum == 1) then -- if the enemy defends against player attack
				enemyHealthBar:setProgress(enemyHealthBar:getProgress() - 0.10)
			else
				playerHealthBar:setProgress(playerHealthBar:getProgress() - 0.20) -- player loses health if enemy hits
				enemyHealthBar:setProgress(enemyHealthBar:getProgress() - 0.20)
			end -- end else
		end -- end if
		-- check for health status
		if (playerHealthBar:getProgress() <= 0) then -- if player dies, decrement lives
			numOfLives = numOfLives - 1
			if (numOfLives == 0) then
				playerDeath()
			end
			composer.hideOverlay("fade", 400)
			scene:goToPreviousScene() -- uses parent function in scene 5
			-- composer.hideOverlay("fade")
			-- and restart the scene
		end
		if (enemyHealthBar:getProgress() <= 0) then -- if enemy dies, move on
			composer.hideOverlay("fade", 400)

			if (params.lastToWin ==true ) then 
				scene:goToNextScene() -- uses parent function in scene 5
			else
				scene:goToNextScene() -- uses parent function in scene 5
			end
			-- composer.hideOverlay("fade")
			-- go to the scene7
		end
	end -- end function

	local function handleDefendButtonEvent(event)
		local randNum = randAttackOrDefend() -- defend = 1 attack = 0
		if ("ended" == event.phase) then
			if (randNum == 0) then -- if the enemy attacks
				playerHealthBar:setProgress(playerHealthBar:getProgress() - 0.10)
			else
				-- nothing happens if they both defend because it is countered
			end -- end else
		end -- end if
		-- check for health status
		if (playerHealthBar:getProgress() <= 0) then -- if player dies, decrement lives
			numOfLives = numOfLives - 1
			composer.hideOverlay("fade", 400)
			-- and restart the scene
			scene:goToPreviousScene() -- uses parent function in scene 5
			-- composer.hideOverlay("fade")

		end
		if (enemyHealthBar:getProgress() <= 0) then -- if player dies, decrement lives
			composer.hideOverlay("fade", 400)
			scene:goToNextScene() -- uses parent function in scene 5

			-- go to the next scene
		end

	end -- end function

	-- create attack and defend buttons

	local attackButton = widget.newButton(
		{
			left = display.contentCenterX - 140,
			top = display.contentCenterY + 170,
			id = "attackButton",
			shape = "roundedRect",
			label = "ATTACK",
			width = 100,
			cornerRadius = 9,
			strokeColor = { default = { 1, 0, 0, 0 }, over = { 0.8, 0.8, 1, 1 } },
			fillColor = { default = { 1, 0, 0, 1 }, over = { 1, 1, 1, 1 } },
			strokeWidth = 4,
			onEvent = handleAttackButtonEvent
		}
	)
	sceneGroup:insert(attackButton)

	local defendButton = widget.newButton(
		{
			left = display.contentCenterX + 40,
			top = display.contentCenterY + 170,
			id = "defendButton",
			shape = "roundedRect",
			label = "DEFEND",
			width = 100,
			cornerRadius = 9,
			strokeColor = { default = { 1, 0, 0, 0 }, over = { 0.8, 0.8, 1, 1 } },
			fillColor = { default = { 0, 0, 1, 1 }, over = { 1, 1, 1, 1 } },
			strokeWidth = 4,
			onEvent = handleDefendButtonEvent
		}
	)
	sceneGroup:insert(defendButton)

	composer.hideOverlay("fade", 400)
end

-- "scene:show()"
function scene:show(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Called when the scene is still off screen (but is about to come on screen).
	elseif (phase == "did") then
		-- Called when the scene is now on screen.
		-- Insert code here to make the scene come alive.
		-- Example: start timers, begin animation, play audio, etc.
	end
end

-- "scene:hide()"
function scene:hide(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Called when the scene is on screen (but is about to go off screen).
		-- Insert code here to "pause" the scene.
		-- Example: stop timers, stop animation, stop audio, etc.
	elseif (phase == "did") then
		-- Called immediately after scene goes off screen.
	end
end

-- "scene:destroy()"
function scene:destroy(event)

	local sceneGroup = self.view

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
