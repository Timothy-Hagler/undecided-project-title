local Obstacle = {tag="obstacle", img=nil, imgIdx=nil, outline=nil, x = 0, y = 0, 
	bodyType="dynamic", collisionType="all", bounce=0, triggerFxn = nil};
local aboveCollisionOnly, belowCollisionOnly

function Obstacle:new (o)    --constructor
    o = o or {}; 	-- create obj if not provided
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function Obstacle:spawn()
	-- replace shape with sprite
	if ( self.imgIdx ~= nil) then
		self.sprite = display.newImage(self.img, self.imgIdx);
	else
		self.sprite = display.newImage(self.img);
	end
	self.sprite.x, self.sprite.y = self.x, self.y
	self.sprite.pp = self;  -- parent object

	if ( self.bodyType == "static") then 
		physics.addBody(self.sprite, "static", {outline=self.outline, bounce=self.bounce} );	
	else
		physics.addBody(self.sprite, self.bodyType, {outline=self.outline, bounce=self.bounce} );
		self.sprite.linearDamping = 3.5
		self.sprite.angularDamping = 3.5
	end

	if ( self.collisionType == "above" ) then
		self.sprite.preCollision = aboveCollisionOnly
		self.sprite:addEventListener( "preCollision" )
	elseif ( self.collisionType == "below" ) then
		self.sprite.preCollision = belowCollisionOnly
		self.sprite:addEventListener( "preCollision" )
	end

	if self.triggerFxn then
		self.sprite.collision = self.triggerFxn
		self.sprite:addEventListener("collision")
	end
end

-- Note: directional collision only intended for player
function aboveCollisionOnly( self, event)
	if ( self.y < event.other.y+60  ) then -- self.y < other.y --> colliding above object --> ignore collision
		event.contact.isEnabled = false
	end
end

function belowCollisionOnly( self, event)
	if ( event.y > 4 and event.y < 100 ) then	 -- self.y > other.y --> colliding below object --> ignore collision. <100 added to avoid bugs
		-- print(event.target.pp.tag)	-- #DEBUG
		-- print(event.x..", "..event.y)
		if not event.other.transitioning then
			event.contact.isEnabled = false
			event.other.IsBodyActive = false -- disable for tranition
			event.other.transitioning = true
			if ( event.other.tag=="player" ) then
				event.other:stopMoving()
			end
			transition.moveBy( event.other, {y=30, time=500, onComplete=
				function()
					event.other.isBodyActive=true
					event.other.transitioning=nil
					event.other:setLinearVelocity(0,0)
				end } )
		end
	end
end

function genericTrigger( self, event )
	print("Placeholder!")
end

function moveToScene( sceneName )

end

return Obstacle