-- class for all types of projectiles
Projectile = class('Projectile')

function Projectile:initialise(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
    self.speed = 50 -- deafault
end

function Projectile:update(dt)
    if self.direction == 1 then
        self.y = self.y - 5
      elseif self.direction == 2 then
        self.x = self.x + 5
      elseif self.direction == 3 then
        self.y = self.y + 5
      elseif self.direction == 4 then
        self.x = self.x - 5
      elseif self.direction == 5 then
        self.y = self.y - 5
        self.x = self.x + 5
      elseif self.direction == 6 then
        self.y = self.y + 5
        self.x = self.x + 5
      elseif self.direction == 7 then
        self.y = self.y + 5
        self.x = self.x - 5
      elseif self.direction == 8 then
        self.y = self.y - 5
        self.x = self.x - 5
      end
end