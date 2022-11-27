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
    physics.addBody(self.shape, "dynamic", {bounciness=0}); 
end

function Player:InitiateBattle()
    -- waiting on pokemon to be in first
end

function Player:move(event)
    print("Pritining previous forces " .. self.prevXForce, self.prevYForce)
    if (self.prevXForce ~= 0) then
        self.shape:applyForce(-self.prevXForce / math.abs(self.prevXForce), 0, self.shape.x, self.shape.y)
    end
    if (self.prevYForce ~= 0) then
        self.shape:applyForce(0, -self.prevYForce / math.abs(self.prevYForce), self.shape.x, self.shape.y)
    end
    if (event.x < self.shape.x) then
        event.x = -event.x
    end
    if (event.y < self.shape.y) then
        event.y = -event.y
    end
    --if (self.shape.getLinearVelocity().x >)
        self.shape:applyForce(event.x / math.abs(event.x), event.y / math.abs(event.y), self.shape.x, self.shape.y)
        self.prevXForce = event.x / math.abs(event.x)
        self.prevYForce = event.y / math.abs(event.y)
    local lv, ly = (self.shape:getLinearVelocity())
    print("Printing linear velocity" .. self.shape:getLinearVelocity())
    print(lv, ly)
    --self.shape:setLinearVelocity(event.x,event.y)
    --transition.to()
end

return Player