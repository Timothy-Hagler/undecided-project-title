local Pokemon = {tag="pokemon", HP=100, x=0, y=0}

function Pokemon:new(o)
    o = o or {}; 
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function Pokemon:spawn()
    -- replace shape with sprite
    self.shape=display.newCircle(self.x, self.y,15);
    self.shape.pp = self;  -- parent object
    self.shape.tag = self.tag; -- â€œenemyâ€
    self.shape:setFillColor (1,1,0);
    physics.addBody(self.shape, "kinematic"); 
end

function Pokemon:attack()

end

function Pokemon:defend()

end

return Pokemon