--class to handle creating and deleting projectiles 
projectileEngine = class('projectileEngine')

function projectileEngine:initialize()
    self.activeProjectiles = {}
    self.deletedProjectiles = {}
    self.test = 10
end

function projectileEngine:createProjectile(projectileClass, x, y, direction)
    if self.deletedProjectiles[projectileClass] == nil or self.deletedProjectiles[projectileClass].getn() == 0 then
        local projectileObj = projectileClass:new(x, y, direction)
        if self.activeProjectiles[projectileClass] == nil then
            table.insert(self.activeProjectiles, projectileClass, stack:new().push(projectileObj))
        else
            self.activeProjectiles[projectileClass].push(projectileObj)
        end
        table.insert(layer.projectiles, projectileObj)
    else
        local projectileObj = self.deletedProjectiles[projectileClass].pop().reInitialize(x, y, direction)
        self.activeProjectiles[projectileClass].push(projectileObj)
        table.insert(layer.projectiles, projectileObj)
    end
end

function projectileEngine:deleteProjectile(projectileClass)
    if self.activeProjectiles[projectileClass] == nil and self.activeProjectiles[projectileClass].getn() == 0 then
        print ("projectile either already deleted or doesnt exist")
    else
        if self.deletedProjectiles[projectileClass] == nil then
            table.insert(self.deletedProjectiles, projectileClass, stack:new().push(self.activeProjectiles[projectileClass].pop()))
        else
            self.deletedProjectiles[projectileClass].push(self.activeProjectiles[projectileClass].pop())
        end
    end
end




