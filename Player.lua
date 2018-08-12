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

function player:initialize()
  image = love.graphics.newImage('sprites/planesprite.png')
  playerImage = love.graphics.newImage('sprites/nakedSprite.jpg')

  local p32 = anim8.newGrid(32,32, 416, 416, 0, 0, 0)

  local g32 = anim8.newGrid(32, 32, 1024, 768, 3, 3, 1)

  self.isMoving = false
  self.health = 100
  self.direction = 1 
  self.x = 0
  self.y = 10
  self.speed = 100
  self.ability = {}
  self.punch = function()
    movement:pause()
  end
  self.fire = function()
    bullet = {}
    bullet.direction = self.direction
    if bullet.direction == 1 then
      bullet.x = self.x + 16
      bullet.y = self.y
    elseif bullet.direction == 2 then
      bullet.x = self.x + 32
      bullet.y = self.y + 16
    elseif bullet.direction == 3 then
      bullet.x = self.x + 16
      bullet.y = self.y + 32
    elseif bullet.direction == 4 then
      bullet.x = self.x
      bullet.y = self.y + 16
    elseif bullet.direction == 5 then
      bullet.x = self.x + 32
      bullet.y = self.y
    elseif bullet.direction == 6 then
      bullet.x = self.x + 32
      bullet.y = self.y + 32
    elseif bullet.direction == 7 then
      bullet.y = self.y + 32
      bullet.x = self.x
    elseif bullet.direction == 8 then
      bullet.x = self.x
      bullet.y = self.y
    end
    table.insert(self.ability, bullet)
  end

  movement = {
    anim8.newAnimation(p32(4,3, 13,2, 8,3, 12,3),0.1),--north
    anim8.newAnimation(p32(13,3, 1,3, 5,3, 9,3), 0.1),--east
    anim8.newAnimation(p32(3,3, 12,2, 7,3, 11,3), 0.1),--south
    anim8.newAnimation(p32(1,4, 2,3, 6,3, 10,3), 0.1),--west
    anim8.newAnimation(p32(13,3, 1,3, 5,3, 9,3), 0.1),--northeast
    anim8.newAnimation(p32(13,3, 1,3, 5,3, 9,3), 0.1),--southeast
    anim8.newAnimation(p32(1,4, 2,3, 6,3, 10,3), 0.1),--northwest
    anim8.newAnimation(p32(1,4, 2,3, 6,3, 10,3), 0.1),--southwest
  }
  standing = {
    anim8.newAnimation(p32(2,1),0.1),
    anim8.newAnimation(p32(3,1),0.1),
    anim8.newAnimation(p32(1,1),0.1),
    anim8.newAnimation(p32(4,1),0.1),
    anim8.newAnimation(p32(3,1),0.1),
    anim8.newAnimation(p32(3,1),0.1),
    anim8.newAnimation(p32(4,1),0.1),
    anim8.newAnimation(p32(4,1),0.1),
  }
  punching = {
      anim8.newAnimation(p32(10,5, 1,6),0.1),--north
      anim8.newAnimation(p32(11,5, 2,6),0.1),--east
      anim8.newAnimation(p32(9,5, 13,5),0.1),--south
      anim8.newAnimation(p32(12,5, 3,6),0.1),--west
      anim8.newAnimation(p32(11,5, 2,6),0.1),--northeast
      anim8.newAnimation(p32(11,5, 2,6),0.1),--southeast
      anim8.newAnimation(p32(12,5, 3,6),0.1),--northwest
      anim8.newAnimation(p32(12,5, 3,6),0.1),--southwest
    }
end

function player:update(dt)
  movement[self.direction]:update(dt)
  punching[self.direction]:update(dt)
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

  if love.keyboard.isDown("f") then
    self.fire()
  end


  for i,v in ipairs(self.ability) do
    if v.y < -10 then
      table.remove(self.ability, i)
    elseif v.x < -10 then
      table.remove(self.ability, i)
    elseif v.x > 800 then
      table.remove(self.ability, i)
    elseif v.y > 600 then
      table.remove(self.ability, i)
    end
    if v.direction == 1 then
      v.y = v.y - 5
    elseif v.direction == 2 then
      v.x = v.x + 5
    elseif v.direction == 3 then
      v.y = v.y + 5
    elseif v.direction == 4 then
      v.x = v.x - 5
    elseif v.direction == 5 then
      v.y = v.y - 5
      v.x = v.x + 5
    elseif v.direction == 6 then
      v.y = v.y + 5
      v.x = v.x + 5
    elseif v.direction == 7 then
      v.y = v.y + 5
      v.x = v.x - 5
    elseif v.direction == 8 then
      v.y = v.y - 5
      v.x = v.x - 5
    end
  end

end

function player:draw()
  if(self.isMoving) then
    movement[self.direction]:draw(playerImage, self.x, self.y)
  else
    standing[self.direction]:draw(playerImage, self.x, self.y)
  end
  if love.keyboard.isDown("g") then
    --movement:pause(1)
    punching[self.direction]:draw(playerImage, self.x, self.y)
    --movement:resume()
  end

  for _,v in pairs(self.ability) do
    love.graphics.rectangle("fill", v.x, v.y, 5, 5)
  end
end