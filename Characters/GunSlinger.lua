-- A character that wields two powerful guns  
GunSlinger = class("GunSlinger", player)

function GunSlinger:initialize(x, y, w, h)

    -- initialize character sprite here
    -- initialize character abilities here
    player.initialize(self, x, y, w, h)
end

function GunSlinger:update(dt)
    -- triggger character ability moves here
    player.update(self, dt)
end

function GunSlinger:draw()
    -- make character movements and animations here.
end
