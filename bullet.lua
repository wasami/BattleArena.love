-- A type of projectile, small with high speed peircing damage
--[[directions
  north = 1
  east = 2
  south = 3
  west = 4
  northeast = 5
  southeast = 6
  southwest = 7
  northwest = 8
--]]

bullet = class("bullet", projectile)

function bullet:initialize(x, y, direction)
    -- initialise position so bullet looks like it comes from out of player and not within.
    projectile.initialize(self, x, y, direction)

    if direction == 1 then
        self.x = x + 17
        self.y = y - 1
    elseif direction == 2 then
        self.x = x + 33
        self.y = y + 17
    elseif direction == 3 then
        self.x = x + 17
        self.y = y + 33
    elseif direction == 4 then
        self.x = x - 1
        self.y = y + 17
    elseif direction == 5 then
        self.x = x + 33
        self.y = y - 1
    elseif direction == 6 then
        self.x = x + 33
        self.y = y + 33
    elseif direction == 7 then
        self.y = y + 33
        self.x = x - 1
    elseif direction == 8 then
        self.x = x - 1
        self.y = y - 1
    end

    self.name = bullet.name
    self.w = 5
    self.h = 5

    self.filter = function(item, other)
        if  other.name == mob   then    
            return 'bounce'
        else 
            return 'slide'
        end
    end

    
end

function bullet:reInitialize(x, y, direction)
  projectile.reInitialize(self, x, y, direction)
end

function bullet:update(dt)
    projectile.update(self, dt)
end

function bullet:draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle("fill", self.x, self.y, 5, 5)
end