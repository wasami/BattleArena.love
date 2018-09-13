-- class for all types of projectiles
projectile = class("projectile")

function projectile:initialize(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
    self.speed = 500 -- deafault
    self.isActive = true 
end

function projectile:reInitialize(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
    self.speed = 50 -- deafault
    self.isActive = true 
end

function projectile:update(dt)
  local dx,dy = 0,0

  if self.direction == 1 then
      dy = -self.speed * dt
    elseif self.direction == 2 then
      dx = self.speed * dt
    elseif self.direction == 3 then
      dy = self.speed * dt
    elseif self.direction == 4 then
      dx = -self.speed * dt
    elseif self.direction == 5 then
      dy = -self.speed * dt
      dx =  self.speed * dt
    elseif self.direction == 6 then
      dy =  self.speed * dt
      dx =  self.speed * dt
    elseif self.direction == 7 then
      dy =  self.speed * dt
      dx = -self.speed * dt
    elseif self.direction == 8 then
      dy = -self.speed * dt
      dx = -self.speed * dt
    end

    if dx ~= 0 or dy ~= 0 then
      local cols
      self.x, self.y, cols, cols_len = world:move(self, self.x + dx, self.y + dy, self.filter)
    end

    if self.y < -10 then
      self:delete()
    elseif self.x < -10 then
      self:delete()
    elseif self.x > 640 then
      self:delete()
    elseif self.y > 640 then
      self:delete()
    end
end

-- function projectile:draw()
--   love.graphics.rectangle("fill", self.x, self.y, 5, 5)
-- end

function projectile:delete()
  -- print("projectile deleted")
  self.x, self.y = 0
  self.isActive = false
  world:remove(self)
end