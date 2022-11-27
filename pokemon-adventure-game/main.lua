-- Moves to the Main Menu Immediately
local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)

-- Reserve channel 1 for background music
audio.reserveChannels( 1 )
-- Reduce the overall volume of the channel
audio.setVolume( 0.5, { channel=1 } )

composer.gotoScene("scene1")

