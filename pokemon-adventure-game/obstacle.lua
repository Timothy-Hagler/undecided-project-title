local Obstacle = {tag="Obstacle", img=nil, imgIdx=nil, outline=nil, x = 0, y = 0, bodyType="dynamic", collisionType="all"};
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
		physics.addBody(self.sprite, "static", {outline=self.outline, bounciness=0} );	
	else
		physics.addBody(self.sprite, self.bodyType, {outline=self.outline, bounciness=0} );
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
end

-- Note: directional collision only intended for player
function aboveCollisionOnly( self, event)
	if ( self.y < event.other.y+60  ) then -- self.y < other.y --> colliding above object --> ignore collision
		event.contact.isEnabled = false
	end
end

function belowCollisionOnly( self, event)
	print(self.y..", "..event.y)
	print("\t"..self.x..", "..event.x)
	print("\twidth: "..self.width)
	print("\t"..event.other.x.." , "..event.other.y)
	if ( event.y > 4 and math.abs(event.x) - self.width/2 < 5  ) then -- self.y > other.y --> colliding below object --> ignore collision
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

function sceneTrigger( self, event )
	print("Placeholder!")
end

return Obstacle