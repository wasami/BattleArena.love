-- A type of projectile, small with high speed peircing damage
local projectile = require 'projectile'

local bullet = class('Bullet', Projectile)

function Bullet:initialise(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
end

function Bullet:update(dt)
    
end






