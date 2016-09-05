require "CiderDebugger";-- Abstract: Storyboard Chat Sample using AppWarp
--
--
-- Demonstrates use of the AppWarp API (connect, disconnect, joinRoom, subscribeRoom, chat )
--

display.setStatusBar( display.HiddenStatusBar )

local storyboard = require "storyboard"
local widget = require "widget"


-- Replace these with the values from AppHQ dashboard of your AppWarp app
API_KEY = "69d873ab2e5c54c3cbbd4950960c870338a0cb4e623f2f9124e11fbc95f04a78"
SECRET_KEY = "d3543fd068abf1d86601d13c0fc3ce546b4c3b6a2bb7ffa8b8397af35f6b75a4"
ROOM_ID = ""
USER_NAME = ""
REMOTE_USER = ""
ROOM_ADMIN = ""

-- create global warp client and initialize it
appWarpClient = require "AppWarp.WarpClient"
appWarpClient.initialize(API_KEY, SECRET_KEY)

--appWarpClient.enableTrace(true)

-- IMPORTANT! loop WarpClient. This is required for receiving responses and notifications
local function gameLoop(event)
  appWarpClient.Loop()
end

-- load first scene
storyboard.gotoScene( "ConnectScene", "fade", 400 )


Runtime:addEventListener("enterFrame", gameLoop)