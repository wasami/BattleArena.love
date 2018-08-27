--class to handle creating and deleting projectiles 
projectileEngine = class('projectileEngine')

function projectileEngine:initialize()
    self.activeProjectiles = {}
    self.deletedProjectiles = {}
end

function projecttileEngine:createProjectile(projectile, x, y, direction)
    if self.deletedProjectiles[projectile] = nil or self.deletedProjectiles[projectile].getn() = 0 then
        local projectileObj = projectile:new(x, y, direction)
        if self.activeProjectiles[projectile] == nil then
            table.insert(self.activeProjectiles[projectile], Stack:new().push(projectileObj))
        else
            self.activeProjectiles[projectile].push(projectileObj)
        end
    else
        local projectileObj = self.deletedProjectiles[projectile].pop().reInitialize(x, y, direction)
        self.activeProjectiles[projectile].push(projectileObj)
    end
end

function projectileEngine:deleteProjectile(projectile)
    if self.activeProjectiles[projectile] = nil or self.activeProjectiles[projectile].getn() = 0 then
        print ("projectile either already deleted or doesnt exist")
    else
        if self.deletedProjectiles[projectile] = nil then
            table.insert(self.deletedProjectiles[projectile], Stack:new().push(self.activeProjectiles[projectile].pop())
        else
            self.deletedProjectiles[projectile].push(self.activeProjectiles[projectile].pop())
        end
    end
end




