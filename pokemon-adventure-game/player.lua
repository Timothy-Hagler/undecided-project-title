local Player = {tag="player", HP=1, xPos=0, yPos=0, prevXForce=0, prevYForce=0};

function Player:new (o)    --constructor
    o = o or {}; 
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function Player:spawn()
    -- replace shape with sprite
    self.shape=display.newCircle(self.x, self.y,15);
    self.shape.pp = self;  -- parent object
    self.shape.tag = self.tag; -- player
    self.shape:setFillColor (1,1,1);
    physics.addBody(self.shape, "dynamic", {bounciness=0, radius=15, linearDamping = 10});
end




function Player:InitiateBattle()
    -- waiting on pokemon to be in first
end

function Player:StopMoving()
    self.shape:setLinearVelocity(0, 0)
end

function Player:move(xvel, yvel)
    self.shape:setLinearVelocity(xvel, yvel)	-- #TODO: changing this to impulse-based motion would work better for boulder collision, but this will work ok as-is
end

return Player
