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
local anim8 = require 'Library.anim8'
local Player = require 'Player'

function love.load()

  image = love.graphics.newImage('sprites/planesprite.png')

  local g32 = anim8.newGrid(32, 32, 1024, 768, 3, 3, 1)

  spinning = {
                    --type, frames,              delay
    anim8.newAnimation(g32('1-8',1),              0.1),
    anim8.newAnimation(g32(18,'8-11',18,'10-7'),  0.2),
    anim8.newAnimation(g32('1-8',2),              0.3),
    anim8.newAnimation(g32(19,'8-11', 19,'10-7'), 0.4),
    anim8.newAnimation(g32('1-8',3),              0.5),
    anim8.newAnimation(g32(20,'8-11', 20,'10-7'), 0.6),
    anim8.newAnimation(g32('1-8',4),              0.7),
    anim8.newAnimation(g32(21,'8-11', 21,'10-7'), 0.8),
    anim8.newAnimation(g32('1-8',5),              0.9)
  }
  movement = {

    anim8.newAnimation(g32('5-5',1), 0.1),--north
    anim8.newAnimation(g32('3-3',1), 0.1),--east
    anim8.newAnimation(g32('1-1',1), 0.1),--south
    anim8.newAnimation(g32('7-7',1), 0.1),--west
    anim8.newAnimation(g32('4-4',1), 0.1),--northeast
    anim8.newAnimation(g32('2-2',1), 0.1),--southeast
    anim8.newAnimation(g32('8-8',1), 0.1),--southwest
    anim8.newAnimation(g32('6-6',1), 0.1)--northwest

  }


  player = {}
  player.direction = 1 
  player.x = 0
  player.y = 10
  player.speed = 100
  player.ability = {}
  player.fire = function()
    bullet = {}
    bullet.x = player.x
    bullet.y = player.y
    bullet.direction = player.direction
    table.insert(player.ability, bullet)
  end
end

function love.update(dt)
  diagSpeed = (player.speed * player.speed) + (player.speed * player.speed)

  if love.keyboard.isDown("up") and love.keyboard.isDown("right") then
    player.direction = 5
    player.y = player.y - (player.speed * dt)--((math.sqrt(diagSpeed) * dt)/2)
    player.x = player.x + (player.speed * dt)--((math.sqrt(diagSpeed) * dt)/2)
  elseif love.keyboard.isDown("down") and love.keyboard.isDown("right") then
    player.direction = 6
    player.y = player.y + (player.speed * dt)--((math.sqrt(diagSpeed) * dt)/2)
    player.x = player.x + (player.speed * dt)--((math.sqrt(diagSpeed) * dt)/2)
  elseif love.keyboard.isDown("down") and love.keyboard.isDown("left") then
    player.direction = 7
    player.y = player.y + (player.speed * dt)--((math.sqrt(diagSpeed) * dt)/2)
    player.x = player.x - (player.speed * dt)--((math.sqrt(diagSpeed) * dt)/2)
  elseif love.keyboard.isDown("up") and love.keyboard.isDown("left") then
    player.direction = 8
    player.y = player.y - (player.speed * dt)--((math.sqrt(diagSpeed) * dt)/2)
    player.x = player.x - (player.speed * dt)--((math.sqrt(diagSpeed) * dt)/2)
  elseif love.keyboard.isDown("right") then
    player.x = player.x + (player.speed * dt)
    player.direction = 2
  elseif love.keyboard.isDown("left") then
    player.x = player.x - (player.speed * dt)
    player.direction = 4
  elseif love.keyboard.isDown("down") then
    player.y = player.y + (player.speed * dt)
    player.direction = 3
  elseif love.keyboard.isDown("up") then
    player.y = player.y - (player.speed * dt)
    player.direction = 1
  end

  if love.keyboard.isDown("f") then
    player.fire()
  end

  for i,v in ipairs(player.ability) do
    if v.y < -10 then
      table.remove(player.ability, i)
    elseif v.x < -10 then
      table.remove(player.ability, i)
    elseif v.x > 800 then
      table.remove(player.ability, i)
    elseif v.y > 600 then
      table.remove(player.ability, i)
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

  for i=1,#spinning do
    spinning[i]:update(dt)
  end
end

function love.draw()
  for i=1,#spinning do
    spinning[i]:draw(image, i*75, i*50)
  end

  --love.graphics.setColor(255,255,255)
  --love.graphics.rectangle("fill", player.x, player.y, 10, 10)
  movement[player.direction]:draw(image, player.x, player.y)


  -- love.graphics.setColor(0,0,255)
  for _,v in pairs(player.ability) do
    love.graphics.rectangle("fill", v.x, v.y, 5, 5)
  end
end