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
player = class('player')

function player:initialize(x, y, w, h)
  self.playerImage = love.graphics.newImage('Sprites/nakedSprite.jpg')

  local p32 = anim8.newGrid(32,32, 416, 416, 0, 0, 0)

  self.isMoving = false
  self.health = 100
  self.direction = 1 
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.speed = 100

  self.punch = function()
    movement:pause()
  end
    

  self.movement = {
    anim8.newAnimation(p32(4,3, 13,2, 8,3, 12,3),0.1),--north
    anim8.newAnimation(p32(13,3, 1,3, 5,3, 9,3), 0.1),--east
    anim8.newAnimation(p32(3,3, 12,2, 7,3, 11,3), 0.1),--south
    anim8.newAnimation(p32(1,4, 2,3, 6,3, 10,3), 0.1),--west
    anim8.newAnimation(p32(13,3, 1,3, 5,3, 9,3), 0.1),--northeast
    anim8.newAnimation(p32(13,3, 1,3, 5,3, 9,3), 0.1),--southeast
    anim8.newAnimation(p32(1,4, 2,3, 6,3, 10,3), 0.1),--northwest
    anim8.newAnimation(p32(1,4, 2,3, 6,3, 10,3), 0.1),--southwest
  }
  self.standing = {
    anim8.newAnimation(p32(2,1),0.1),
    anim8.newAnimation(p32(3,1),0.1),
    anim8.newAnimation(p32(1,1),0.1),
    anim8.newAnimation(p32(4,1),0.1),
    anim8.newAnimation(p32(3,1),0.1),
    anim8.newAnimation(p32(3,1),0.1),
    anim8.newAnimation(p32(4,1),0.1),
    anim8.newAnimation(p32(4,1),0.1),
  }
  self.punching = {
      anim8.newAnimation(p32(10,5, 1,6),0.1),--north
      anim8.newAnimation(p32(11,5, 2,6),0.1),--east
      anim8.newAnimation(p32(9,5, 13,5),0.1),--south
      anim8.newAnimation(p32(12,5, 3,6),0.1),--west
      anim8.newAnimation(p32(11,5, 2,6),0.1),--northeast
      anim8.newAnimation(p32(11,5, 2,6),0.1),--southeast
      anim8.newAnimation(p32(12,5, 3,6),0.1),--northwest
      anim8.newAnimation(p32(12,5, 3,6),0.1),--southwest
    }

  -- print("player was initialized")
end

function player:update(dt)
  local dx, dy = 0, 0

  if love.keyboard.isDown("up") and love.keyboard.isDown("right") then
    self.direction = 5
    dy = -self.speed * dt
    dx =  self.speed * dt
    self.isMoving = true
  elseif love.keyboard.isDown("down") and love.keyboard.isDown("right") then
    self.direction = 6
    dy = self.speed * dt
    dx = self.speed * dt
    self.isMoving = true
  elseif love.keyboard.isDown("down") and love.keyboard.isDown("left") then
    self.direction = 7
    dy = self.speed * dt
    dx = -self.speed * dt
    self.isMoving = true
  elseif love.keyboard.isDown("up") and love.keyboard.isDown("left") then
    self.direction = 8
    dy = - self.speed * dt
    dx = - self.speed * dt
    self.isMoving = true
  elseif love.keyboard.isDown("right") then
    dx = self.speed * dt
    self.direction = 2
    self.isMoving = true
  elseif love.keyboard.isDown("left") then
    dx = -self.speed * dt
    self.direction = 4
    self.isMoving = true
  elseif love.keyboard.isDown("down") then
    dy = self.speed * dt
    self.direction = 3
    self.isMoving = true
  elseif love.keyboard.isDown("up") then
    dy = -self.speed * dt
    self.direction = 1
    self.isMoving = true
  else
    self.isMoving = false
  end
  
  if dx ~= 0 or dy ~= 0 then
    -- print ("making moves")
    -- print (dy)
    -- print (dx)
    local cols
    self.x, self.y, cols, cols_len = world:move(self, self.x + dx, self.y + dy)
  end

  if love.keyboard.isDown("f") then
    projectileEngineObj:createProjectile(bullet, self.x, self.y, self.direction)
  end

  self.movement[self.direction]:update(dt)
  self.punching[self.direction]:update(dt)

end

function player:draw()
  if(self.isMoving) then
    self.movement[self.direction]:draw(self.playerImage, self.x, self.y)
  else
    self.standing[self.direction]:draw(self.playerImage, self.x, self.y)
  end

  if love.keyboard.isDown("g") then
    self.punching[self.direction]:draw(self.playerImage, self.x, self.y)
  end

end