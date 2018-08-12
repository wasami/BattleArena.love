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
local projectile = require 'projectile'

local bullet = class('Bullet', Projectile)

function Bullet:initialise(x, y, direction)
    -- initialise position so bullet looks like it comes from out of player and not within.
    if direction == 1 then
        x = self.x + 16
        y = self.y
      elseif direction == 2 then
        x = self.x + 32
        y = self.y + 16
      elseif direction == 3 then
        x = self.x + 16
        y = self.y + 32
      elseif direction == 4 then
        x = self.x
        y = self.y + 16
      elseif direction == 5 then
        x = self.x + 32
        y = self.y
      elseif direction == 6 then
        x = self.x + 32
        y = self.y + 32
      elseif direction == 7 then
        y = self.y + 32
        x = self.x
      elseif direction == 8 then
        x = self.x
        y = self.y
      end
      
    Projectile.initialize(self, x, y, direction)
end

function Bullet:update(dt)
    Projectile.update(self, dt)
end

function Bullet:draw()
    love.graphics.rectangle("fill", self.x, self.y, 5, 5)
end





