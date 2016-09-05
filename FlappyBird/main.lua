-- 
-- Abstract: JungleScene sample project
-- Demonstrates sprite sheet animations, with different frame rates
-- 
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.

-- Plants are from http://blender-archi.tuxfamily.org/Greenhouse
-- and are subject to creative commons license, http://creativecommons.org/licenses/by/3.0/
--
--	Supports Graphics 2.0
---------------------------------------------------------------------------------------

--physics object

local physics=require "physics"

physics.start()

physics.setGravity(0,2)

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

-- Define reference points locations anchor ponts
local TOP_REF = 0
local BOTTOM_REF = 1
local LEFT_REF = 0
local RIGHT_REF = 1
local CENTER_REF = 0.5

display.setStatusBar( display.HiddenStatusBar )

-- The sky as background
local sky = display.newImage( "assets/sky.jpg", _W, _H )
sky.x=_W/2
sky.y=_H/2

--physics.setGravity(-2,10)

local baseline = 280


local score=0



local bird=display.newImageRect("assets/bird.jpg",40,40)
	bird.x=50
	bird.y=100	


-- a bunch of foliage
local tree = {}

local function gameover(event)	
	native.showAlert("Game over","You Lose")
end

local function reset() 

tree[1] = display.newImage( "assets/tunnel.png" )
tree[1].xScale = 0.7; tree[1].yScale = 0.7
tree[1].anchorY = BOTTOM_REF
tree[1].x = 150; tree[1].y = baseline
tree[1].dx = 0.3
--tree[1]:addEventListener("collision",gameover)
physics.addBody(tree[1],"kinematic")
	tree[2] = display.newImage( "assets/tunnel.png" )
	tree[2].xScale = 0.6; tree[2].yScale = 0.6
	--tree[2].anchorY = BOTTOM_REF
	tree[2].x = 150; tree[2].y = 0
	tree[2].dx = 0.3
--	tree[2]:addEventListener("collision",gameover)
	physics.addBody(tree[2],"kinematic")
tree[3] = display.newImage( "assets/tunnel.png" )
tree[3].xScale = 0.8; tree[3].yScale = 0.8
tree[3].anchorY = BOTTOM_REF
tree[3].x = 300; tree[3].y = baseline
tree[3].dx = 0.3
--tree[3]:addEventListener("collision",gameover)
physics.addBody(tree[3],"kinematic")
	tree[4] = display.newImage( "assets/tunnel.png" )
	tree[4].xScale = 0.7; tree[4].yScale = 0.7
	--tree[4].anchorY = BOTTOM_REF
	tree[4].x = 300; tree[4].y = 0
	tree[4].dx = 0.3
--	tree[4]:addEventListener("collision",gameover)
	physics.addBody(tree[4],"kinematic")
tree[5] = display.newImage( "assets/tunnel.png" )
tree[5].xScale = 0.8; tree[5].yScale = 0.8
tree[5].anchorY = BOTTOM_REF
tree[5].x = 450; tree[5].y = baseline
tree[5].dx = 0.3
--tree[5]:addEventListener("collision",gameover)
physics.addBody(tree[5],"kinematic")
	tree[6] = display.newImage( "assets/tunnel.png" )
	tree[6].xScale = 0.4; tree[5].yScale = 0.4
	--tree[6].anchorY = BOTTOM_REF
	tree[6].x = 450; tree[6].y = 0
	tree[6].dx = 0.3
--	tree[6]:addEventListener("collision",gameover)
	physics.addBody(tree[6],"kinematic")
tree[7] = display.newImage( "assets/tunnel.png" )
tree[7].xScale = 0.4; tree[7].yScale = 0.4
tree[7].anchorY = BOTTOM_REF
tree[7].x = 600; tree[7].y = baseline
tree[7].dx = 0.3
--tree[7]:addEventListener("collision",gameover)
physics.addBody(tree[7],"kinematic")
	tree[8] = display.newImage( "assets/tunnel.png" )
	tree[8].xScale = 0.8; tree[8].yScale = 0.8
	--tree[8].anchorY = BOTTOM_REF
	tree[8].x = 600; tree[8].y = 0
	tree[8].dx = 0.3
--	tree[8]:addEventListener("collision",gameover)
	physics.addBody(tree[8],"kinematic")
end

-- solid ground, doesn't need to move
local ground = display.newRect( 0, baseline, 480, 90 )
ground:setFillColor( 0x31/255, 0x5a/255, 0x18/255 )
ground.anchorX = LEFT_REF
ground.anchorY = TOP_REF
physics.addBody(ground,"static")

-- A per-frame event to move the elements

local function clear()
	local i
	for i=1,#tree,1 do
		tree[i]:removeSelf()
	end
end


local function move(event)
	--clear()
	local i
	local k=1
	for i=1,#tree,2 do
		local j=i-k
		k=k+1
		tree[i+1].x=(j)*150
		tree[i].x=(j)*150
		tree[i].xScale=(math.random(10)/10)
		tree[i].yScale=(math.random(10)/10)
	end
end

-- Start everything moving

	reset()
	local obj=display.newText(score,100,20,systemFont,35)

local l=1

local function listen(event)
		physics.addBody(bird,"dynamic",{bounce=0})	
		obj:removeSelf()
--		bird.x=bird.x+5
		print(bird.x)
		if bird.x>=l*150 then
		 	l=l+1
			score=score+1
		end
		obj=display.newText(score,100,20,systemFont,35)
		--bird:setLinearVelocity(2,0)
		bird:applyLinearImpulse(0.01,0)
		if(bird.x>400) then
			bird.x=0
			move(event)
		end
end

bird:addEventListener("tap",listen)

