class = require 'Library.middleclass'
anim8 = require 'Library.anim8'
require 'Projectiles.projectile'
require 'player'
require 'bullet'


local sti = require "sti"
local map
local world

function love.load()

  -- load map
  map = sti("map/map.lua", { "bump" })

  --prepare physics world
  -- world = love.physics.newWorld(0, 0)

  -- prepare collision objects
  -- map:box2d_init(world)

  -- add coustom layer for sprites
  -- map:addCustomLayer("Sprite Layer", 3)

  -- Add data to Custom Layer
  -- local spriteLayer = map.layers["Sprite Layer"]
  -- spriteLayer.sprites = {
  --   --player1 = player:new()

  -- }
   --p1 = player:new()

   
   -- Update callback for Custom Layer
	-- function spriteLayer:update(dt)
	-- 	for _, sprite in pairs(self.sprites) do
	-- 		sprite.r = sprite.r + math.rad(90 * dt)
	-- 	end
  -- end
  

end

function love.update(dt)
  map:update(dt)
  --p1:update(dt)
end

function love.draw()
  map:draw()
  --p1:draw()
end