class = require 'Library.middleclass'
anim8 = require 'Library.anim8'
Player = require 'Player'

function love.load()
   p1 = player:new()
end

function love.update(dt)
  p1:update(dt)
end

function love.draw()
  p1:draw()
end