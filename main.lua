class = require "Library.middleclass"
anim8 = require "Library.anim8"
baton = require "Library.baton"
bump  = require "Library.bump"
Input = require "Library.input"
sti = require "sti"
require "Library.stack"
require "Projectiles.projectileEngine"
require "Projectiles.projectile"
require "player"
require "bullet"
require "mob"
require "bar"



function love.load()
  -- set size of client window
  love.window.setMode(640, 640)

  lineWidth = 1

  -- setup loading screen

  -- setup menu screen

  -- setup game map
  map = nil
  world = nil

  map = sti("Map/map.lua", { "bump" })

  -- prepare physics world
  world = bump.newWorld()



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
  layer.bars = {}

  -- testing health bar.
  local healthBar = bar:new(100, 20, 100, 20, 100)

  table.insert(layer.bars, healthBar)

  -- add player to the layer
  --playerDestX, playerDestY = playerSpawn.x, playerSpawn.y
  player = player:new(playerSpawn.x, playerSpawn.y, 32, 32)

  -- layer.player = player
  table.insert(layer.players, player)
  world:add(player, player.x, player.y, player.w, player.h)

  -- add npc to the layer
  npc = mob:new(npcSpawn.x, npcSpawn.y, 32, 32)
  -- layer.npc = ncp
  table.insert(layer.players, npc)
  world:add(npc, npc.x, npc.y, npc.w, npc.h)

  -- setup draw function for layer
  layer.draw = function(self)
    -- self.player:draw()
    -- self.npc:draw()
    for i,v in pairs(self.players) do
      v:draw()
    end
    for i,v in pairs(self.projectiles) do
      v:draw()
    end
    for i,v in pairs(self.bars) do
      v:draw()
    end
  end

  -- set the update function for layer
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

  -- prepare collision objects
  map:bump_init(world)

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
  love.graphics.setColor(1, 1, 1)
  map:draw()

  -- Draw collision map for debugging
  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle("line", world:getRect(player))
  love.graphics.setLineWidth(lineWidth)

  love.graphics.setColor(1, 0, 0, 0.2)
  love.graphics.rectangle("fill", world:getRect(player))

  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", player.x, player.y, 2, 2)
end

function love.mousepressed(x, y, button)
    if button == 2 then
        player.destX, player.destY = x,y
    end
end
