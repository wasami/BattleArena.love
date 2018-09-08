-- class for all types of projectiles
projectile = class("projectile")

function projectile:initialize(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
    self.speed = 50 -- deafault
    self.isActive = true 
end

function projectile:reInitilize(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
    self.speed = 50 -- deafault
    self.isActive = true 
end

function projectile:update(dt)
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
    if self.y < -10 then
      self:delete()
    elseif self.x < -10 then
      self:delete()
    elseif self.x > 800 then
      self:delete()
    elseif self.y > 600 then
      self:delete()
    end
end

-- function projectile:draw()
--   love.graphics.rectangle("fill", self.x, self.y, 5, 5)
-- end

function projectile:delete()
  self.x, self.y = 0
  self.isActive = false
end