class = require "Library.middleclass"
anim8 = require "Library.anim8"
baton = require "Library.baton"
bump  = require "Library.bump"
sti = require "sti"
require "Library.stack"
require "Projectiles.projectileEngine"
require "Projectiles.projectile"
require "player"
require "bullet"
require "mob"

map = nil
world = nil

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
  local npcSpawn
    for k, object in pairs(map.objects) do
        if object.name == "Player" then
            playerSpawn = object
        elseif object.name == "npc" then
            npcSpawn = object
        end
    end
  -- make a list for objects in sprite layer
  layer.projectiles = {}
  layer.players = {}

  -- add player to the layer
  local player = player:new(playerSpawn.x, playerSpawn.y, 32, 32)
  -- layer.player = player
  table.insert(layer.players, player)
  world:add(player, player.x, player.y, player.w, player.h)

  -- add npc to the layer
  local npc = mob:new(npcSpawn.x, npcSpawn.y, 32, 32)
  -- layer.npc = ncp
  table.insert(layer.players, npc)
  world:add(npc, npc.x, npc.y, npc.w, npc.h)
  
  -- Draw player
  layer.draw = function(self)
    -- self.player:draw()
    -- self.npc:draw()
    for i,v in pairs(self.players) do
      v:draw()
    end
    for i,v in pairs(self.projectiles) do
      v:draw()
    end
  end

  -- controls for player
  layer.update = function(self, dt)
    -- self.player:update(dt)
    -- self.npc:update(dt)
    for i,v in pairs(self.players) do
      v:update(dt)
    end
    for i,v in pairs(self.projectiles) do
      v:update(dt)
      if v.isActive == false then
        -- world:remove(v)
        projectileEngineObj:deleteProjectile(v.name)
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
  -- test projectile engine
  -- print ("Active:" , projectileEngineObj:getActiveProjectiles())
  -- print ("Deleted:" , projectileEngineObj:getDeletedProjectiles())

  -- Draw world
  -- love.graphics.setColor(255, 255, 255)
  map:draw()

  -- love.graphics.setColor(255, 0, 0)
  -- map:bump_draw()
  --p1:draw()
end