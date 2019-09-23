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


local function drawDebug()
    -- Draw collision map for debugging
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", world:getRect(player))
    love.graphics.setLineWidth(lineWidth)

    love.graphics.setColor(1, 0, 0, 0.2)
    love.graphics.rectangle("fill", world:getRect(player))

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", player.x, player.y, 2, 2)
end

-- Main LOVE functions

function love.load()
    -- set size of client window
    love.window.setMode(1024, 1024)

    lineWidth = 1

    -- setup game map
    map = nil
    map = sti("Map/Arena.lua", { "bump" })

    -- prepare physics world
    world = nil
    world = bump.newWorld()

    -- add coustom layer for sprites
    layer = map:addCustomLayer("Sprites", 3)

    -- create projectile engine to handle projectile
    projectileEngineObj = projectileEngine:new()

    -- Get player spawn object
    local playerSpawn, npcSpawn, terrainObject

    for k, object in pairs(map.objects) do
        if object.name == "Player" then
            playerSpawn = object
        elseif object.name == "NPC" then
            npcSpawn = object
        elseif object.name == "Terrain" then
            terrainObject = object
        end
    end

    -- add terrain to world for map
    --local terrain = { terrainObject.x,terrainObject.y, terrainObject.width, terrainObject.height }
    --world:add(terrainObject, terrainObject.x,terrainObject.y, terrainObject.width, terrainObject.height)

    -- make a list for objects in sprite layer
    layer.projectiles = {}
    layer.players = {}

    -- add player to the layer
    --playerDestX, playerDestY = playerSpawn.x, playerSpawn.y
    player = player:new(playerSpawn.x, playerSpawn.y, 32, 32)

    -- layer.player = player
    table.insert(layer.players, player)
    world:add(player, player.x, player.y, player.w, player.h)

    -- add npc to the layer
    npc = mob:new(npcSpawn.x, npcSpawn.y, 32, 32)

    table.insert(layer.players, npc)
    world:add(npc, npc.x, npc.y, npc.w, npc.h)

    -- setup draw function for layer
    layer.draw = function(self)
        for i,v in pairs(self.players) do
            v:draw()
        end

        for i,v in pairs(self.projectiles) do
            v:draw()
        end
    end

    -- set the update function for layer
    layer.update = function(self, dt)
        for i,v in pairs(self.players) do
            v:update(dt)
        end

        for i,v in pairs(self.projectiles) do
            v:update(dt)

            if v.isActive == false then
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
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    map:draw()

    drawDebug()
end
