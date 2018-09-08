class = require "Library.middleclass"
anim8 = require "Library.anim8"
require "Library.stack"
require "Projectiles.projectileEngine"
require "Projectiles.projectile"
require "player"
require "bullet"



local sti = require "sti"
local map
local world

function love.load()
  -- set size of client window
  love.window.setMode(640, 640)

  -- load map
  map = sti("Map/map.lua", { "bump" })

  -- prepare physics world
  world = bump.newWorld()

  -- prepare collision objects
  map:bump_init(world)

  -- add coustom layer for sprites
  layer = map:addCustomLayer("Sprites", 3)

  -- create projectile engine to handle projectile
  projectileEngineObj = projectileEngine:new()

  -- Get player spawn object
  local playerSpawn
    for k, object in pairs(map.objects) do
        if object.name == "Player" then
            playerSpawn = object
            break
        end
    end
  -- make a list for objects in sprite layer
  layer.projectiles = {}

  -- add player to the layer
  layer.player = player:new(playerSpawn.x, playerSpawn.y)
  

  -- Draw player
  layer.draw = function(self)
    self.player:draw()
    for i,v in pairs(self.projectiles) do
      v:draw()
    end
  end

  -- controls for player
  layer.update = function(self, dt)
    self.player:update(dt)
    for i,v in pairs(self.projectiles) do
      v:update(dt)
      if v.isActive == false then
        table.remove(layer.projectiles, i)
      end
    end
  end

  -- Remove unneeded object layer
  map:removeLayer("Spawn Point")
  
end

function love.update(dt)
  map:update(dt)
  --p1:update(dt)
end

function love.draw()
  -- Translate world so that player is always centred
  -- local player = map.layers["Sprites"].player

  -- local tx = math.floor(player.x - love.graphics.getWidth() / 2)
  -- local ty = math.floor(player.y - love.graphics.getHeight() / 2)

  -- love.graphics.translate(-tx, -ty)

  -- Draw world
  map:draw()
  --p1:draw()
end