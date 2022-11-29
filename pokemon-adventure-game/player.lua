local Player = {tag="player", HP=1, xPos=0, yPos=0, prevXForce=0, prevYForce=0, inWater=false};

local options =
{
    frames = {
        {x = 6, y = 9, width = 16, height = 19}, -- 1. ash forward 1
        {x = 24, y = 9, width = 16, height = 19}, -- 2. ash forward 2
        {x = 41, y = 9, width = 16, height = 19}, -- 3. ash forward 3
        {x = 59, y = 9, width = 16, height = 19}, -- 4. ash left 1
        {x = 77, y = 10, width = 16, height = 18}, -- 5. ash left 2
        {x = 94, y = 10, width = 16, height = 18}, -- 6. ash left 3
        {x = 113, y = 9, width = 16, height = 19}, -- 7. ash up 1
        {x = 132, y = 9, width = 16, height = 19}, -- 8. ash up 2
        {x = 150, y = 9, width = 16, height = 19}, -- 9. ash up 3
        {x = 168, y = 9, width = 16, height = 19}, -- 10. ash right 1
        {x = 186, y = 10, width = 16, height = 18}, -- 11. ash right 2
        {x = 203, y = 10, width = 16, height = 18}, -- 12. ash right 3
        {x = 138, y = 139, width = 18, height = 24}, -- 13. surf forward
        {x = 138, y = 171, width = 18, height = 25}, -- 14. surf up
        {x = 138, y = 203, width = 20, height = 23}, -- 15. surf left
        {x = 137, y = 234, width = 20, height = 23}, -- 16. surf right
    }
}

local sequenceData =
{
    {name="forward", start=1, count=3, time=400},
    {name="left", start=4, count=3, time=400},
    {name="up", start=7, count=3, time=400},
    {name="right", start=10, count=3, time=400},
    {name="surfForward", start=13, count=1, time=400},
    {name="surfUp", start=14, count=1, time=400},
    {name="surfLeft", start=15, count=1, time=400},
    {name="surfRight", start=16, count=1, time=400},
}

function Player:new (o)    --constructor
    o = o or {}; 
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function Player:spawn()
    -- replace shape with sprite
    local sheet = graphics.newImageSheet("spritesheets/ashSheet.png", options)
    self.sprite = display.newSprite(sheet,sequenceData)
    self.sprite.xScale, self.sprite.yScale = 1.75, 1.75
    self.sprite.x, self.sprite.y = self.x, self.y
    self.sprite.pp = self;  -- parent object
    physics.addBody(self.sprite, "dynamic", {bounciness=0, linearDamping = 10});

    if (self.inWater) then
        self.sprite:setSequence("surfForward")
    end

end

function Player:InitiateBattle()
    -- waiting on pokemon to be in first
end

function Player:StopMoving()
    self.sprite:pause()
    self.sprite:setLinearVelocity(0, 0)
end

function Player:move(xvel, yvel)
    if (self.inWater == false) then
        if (xvel < 0 and math.abs(xvel) > math.abs(yvel)) then
            self.sprite:setSequence("left")
        elseif (xvel > 0 and math.abs(xvel) > math.abs(yvel)) then
            self.sprite:setSequence("right")
        elseif (yvel < 0 and math.abs(xvel) < math.abs(yvel)) then
            self.sprite:setSequence("up")
        elseif (yvel > 0 and math.abs(xvel) < math.abs(yvel)) then
            self.sprite:setSequence("forward")
        end
    else
        if (xvel < 0 and math.abs(xvel) > math.abs(yvel)) then
            self.sprite:setSequence("surfLeft")
        elseif (xvel > 0 and math.abs(xvel) > math.abs(yvel)) then
            self.sprite:setSequence("surfRight")
        elseif (yvel < 0 and math.abs(xvel) < math.abs(yvel)) then
            self.sprite:setSequence("surfUp")
        elseif (yvel > 0 and math.abs(xvel) < math.abs(yvel)) then
            self.sprite:setSequence("surfForward")
        end

    end
    self.sprite:play()
    self.sprite:setLinearVelocity(xvel, yvel)	-- #TODO: changing this to impulse-based motion would work better for boulder collision, but this will work ok as-is
end

return Player
