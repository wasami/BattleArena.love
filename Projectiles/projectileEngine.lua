--class to handle creating and deleting projectiles 
projectileEngine = class('projectileEngine')

function projectileEngine:initialize()
    self.activeProjectiles = {}
    self.deletedProjectiles = {}
    self.test = 10
end

function projectileEngine:createProjectile(projectileClass, x, y, direction)
    local className = projectileClass.name
    if self.deletedProjectiles[className] == nil or self.deletedProjectiles[className]:getn() == 0 then
        local projectileObj = projectileClass:new(x, y, direction)
        if self.activeProjectiles[className] == nil then
            -- table.insert(self.activeProjectiles, projectileClass, stack:new())
            self.activeProjectiles[className] = stack:new()
            self.activeProjectiles[className]:push(projectileObj)
        else
            self.activeProjectiles[className]:push(projectileObj)
        end
        world:add(projectileObj, x, y, projectileObj.w, projectileObj.h)
        table.insert(layer.projectiles, projectileObj)
    else
        -- print(className)
        -- print(self.deletedProjectiles[className]:getn())
        local projectileObj = self.deletedProjectiles[className]:pop()
        -- print(projectileObj.name)
        projectileObj:reInitialize(x, y, direction)
        world:add(projectileObj, x, y, projectileObj.w, projectileObj.h)
        self.activeProjectiles[className]:push(projectileObj)
        table.insert(layer.projectiles, projectileObj)
    end
end

function projectileEngine:deleteProjectile(className)
    -- print(className)
    -- print(self.activeProjectiles[className]:getn())
    if self.activeProjectiles[className] == nil and self.activeProjectiles[className]:getn() == 0 then
        print ("projectile either already deleted or doesnt exist")
    else
        if self.deletedProjectiles[className] == nil then
            -- table.insert(self.deletedProjectiles, projectileClass, stack:new())
            self.deletedProjectiles[className] = stack:new()
            local projectileObj = self.activeProjectiles[className]:pop()
            -- print(projectileObj.name)
            self.deletedProjectiles[className]:push(projectileObj)
        else
            local projectileObj = self.activeProjectiles[className]:pop()
            -- print(projectileObj.name)
            self.deletedProjectiles[className]:push(projectileObj)
        end
    end
end

function projectileEngine:getActiveProjectiles()
    local total = 0
    for i,v in pairs(self.activeProjectiles) do
        if v ~= nil then
            total = total + v:getn()
        end
    end
    return total
end

function projectileEngine:getDeletedProjectiles()
    local total = 0
    for i,v in pairs(self.deletedProjectiles) do
        if v ~= nil then
            -- print("--", i ,"--")
            total = total + v:getn()
        end
    end
    return total
end



