local Obstacle = {tag="Obstacle",x = 0, y = 0, imgPath=nil, outline=nil, mass=10, collisionDir="all"};
local aboveCollisionOnly, belowCollisionOnly

function Obstacle:new (o)    --constructor
    o = o or {}; 	-- create obj if not provided
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function Obstacle:spawn()
	-- replace shape with sprite
	self.sprite = display.newImageRect(parent,filename,x,y);
	self.sprite.x, self.sprite.y = self.x, self.y
	self.sprite.pp = self;  -- parent object

	if ( self.mass == "inf") then 
		physics.addBody(self.sprite, "static", {outline=self.outline, bounciness=0} );	
	else
		physics.addBody(self.sprite, "dynamic", {outline=self.outline, bounciness=0, linearDamping = 10, mass = self.mass} );
	end

	if ( self.collisionType == "above" ) then
		self.preCollision = aboveCollisionOnly
		self:addEventListener( "preCollision" )
	elseif ( self.collisionType == "below" ) then
		self.preCollision = belowCollisionOnly
		self:addEventListener( "preCollision" )
	end

end

function aboveCollisionOnly(collisionDirs, self, event)
	if ( self.y < event.other.y  ) then -- self.y < other.y --> colliding above object --> ignore collision
		event.contact.isEnabled = false
	end
end

function belowCollisionOnly(collisionDirs, self, event)
	if ( self.y > event.other.y  ) then -- self.y < other.y --> colliding above object --> ignore collision
		event.contact.isEnabled = false
	end
end

return Obstacle