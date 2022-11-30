local Enemy = {tag="enemy", HP=100, xPos=0, yPos=0, prevXForce=0, prevYForce=0};

local function battleScene()

    local options = {
       effect = "fade", -- put a layer over instead of transitioning to a new scene
       time = 500,
       isModal = true -- prevents touch events from passing through the overlayscene
                      -- to the parent scene
    }
    composer.showOverlay("battleScene", options)
 
 end

function Enemy:new (o)    --constructor
    o = o or {}; 
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function Enemy:spawn()
    -- replace shape with sprite
    self.shape=display.newCircle(self.x, self.y,15);
    self.shape.pp = self;  -- parent object
    self.shape.tag = self.tag; -- player
    self.shape:setFillColor (1,1,1);
    physics.addBody(self.shape, "dynamic", {bounciness=0, radius=15, linearDamping = 10});
end

function Enemy:InitiateBattle()
    -- when encountering a player within a certain radius
    if Player.yPos < Enemy.yPos - 3 then
       -- transition to battle scene.lua 
    end

end

function Enemy:StopMoving()
    self.shape:setLinearVelocity(0, 0)
end

function Enemy:move(xvel, yvel)
    self.shape:setLinearVelocity(xvel, yvel)	-- #TODO: changing this to impulse-based motion would work better for boulder collision, but this will work ok as-is
end

    

return Enemy
