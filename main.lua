class = require "Library.middleclass"
anim8 = require "Library.anim8"
require "Projectiles.projectile"
require "player"
require "bullet"
require "Projectiles.projectileEngine"


local sti = require "sti"
local map
local world

function love.load()
  -- set size of client window
  love.window.setMode(640, 640)

  -- load map
  map = sti("Map/map.lua", { "bump" })

  -- prepare physics world
  -- world = love.physics.newWorld(0, 0)

  -- prepare collision objects
  -- map:box2d_init(world)

  -- add coustom layer for sprites
  local layer = map:addCustomLayer("Sprites", 3)

  -- create projectile engine to handle projectile
  local projectileEngine = projectileEngine:new()

  -- Get player spawn object
  local playerSpawn
    for k, object in pairs(map.objects) do
        if object.name == "Player" then
            playerSpawn = object
            break
        end
    end
  
  
  layer.player = player:new(playerSpawn.x, playerSpawn.y)

  -- Draw player
  layer.draw = function(self)
    self.player:draw()
  end

  -- controls for player
  layer.update = function(self, dt)
    self.player:update(dt)
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
  local player = map.layers["Sprites"].player
  -- print(player.x)
  local tx = math.floor(player.x - love.graphics.getWidth() / 2)
  local ty = math.floor(player.y - love.graphics.getHeight() / 2)
  -- print(tx)
  love.graphics.translate(-tx, -ty)

  -- Draw world
  map:draw()
  --p1:draw()
end