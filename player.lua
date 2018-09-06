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

function player:initialize(x, y)
  self.playerImage = love.graphics.newImage('Sprites/nakedSprite.jpg')

  local p32 = anim8.newGrid(32,32, 416, 416, 0, 0, 0)

  self.isMoving = false
  self.health = 100
  self.direction = 1 
  self.x = x
  self.y = y
  self.speed = 100
  self.ability = {}

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
  self.movement[self.direction]:update(dt)
  self.punching[self.direction]:update(dt)
  diagSpeed = (self.speed * self.speed) + (self.speed * self.speed)

  if love.keyboard.isDown("up") and love.keyboard.isDown("right") then
    self.direction = 5
    self.y = self.y - (self.speed * dt)
    self.x = self.x + (self.speed * dt)
    self.isMoving = true
  elseif love.keyboard.isDown("down") and love.keyboard.isDown("right") then
    self.direction = 6
    self.y = self.y + (self.speed * dt)
    self.x = self.x + (self.speed * dt)
    self.isMoving = true
  elseif love.keyboard.isDown("down") and love.keyboard.isDown("left") then
    self.direction = 7
    self.y = self.y + (self.speed * dt)
    self.x = self.x - (self.speed * dt)
    self.isMoving = true
  elseif love.keyboard.isDown("up") and love.keyboard.isDown("left") then
    self.direction = 8
    self.y = self.y - (self.speed * dt)
    self.x = self.x - (self.speed * dt)
    self.isMoving = true
  elseif love.keyboard.isDown("right") then
    self.x = self.x + (self.speed * dt)
    self.direction = 2
    self.isMoving = true
  elseif love.keyboard.isDown("left") then
    self.x = self.x - (self.speed * dt)
    self.direction = 4
    self.isMoving = true
  elseif love.keyboard.isDown("down") then
    self.y = self.y + (self.speed * dt)
    self.direction = 3
    self.isMoving = true
  elseif love.keyboard.isDown("up") then
    self.y = self.y - (self.speed * dt)
    self.direction = 1
    self.isMoving = true
  else
    self.isMoving = false
  end

  -- if love.keyboard.isDown("f") then
  --   bullet:new()
  -- end

end

function player:draw()
  if(self.isMoving) then
    self.movement[self.direction]:draw(self.playerImage, self.x, self.y)
  else
    self.standing[self.direction]:draw(self.playerImage, self.x, self.y)
  end
  if love.keyboard.isDown("g") then
    --movement:pause(1)
    self.punching[self.direction]:draw(self.playerImage, self.x, self.y)
    --movement:resume()
  end

  -- for _,v in pairs(self.ability) do
  --   love.graphics.rectangle("fill", v.x, v.y, 5, 5)
  -- end

end