mob = class('mob')

function mob:initialize(x, y, w, h)
    self.mobImage = love.graphics.newImage('Sprites/nakedSprite.jpg')
    local p32 = anim8.newGrid(32,32, 416, 416, 0, 0, 0)

    self.isMoving = false
    self.currentHealth = 100
    self.maxHealth = 100
    self.direction = 1 
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.name = mob.name

    self.healthBar = bar:new(x + w / 2, y, w, 5, (self.currentHealth/self.maxHealth) * 100)

    self.standing = {
        anim8.newAnimation(p32(2,1),0.1),
        anim8.newAnimation(p32(3,1),0.1),
        anim8.newAnimation(p32(1,1),0.1),
        anim8.newAnimation(p32(4,1),0.1),
        anim8.newAnimation(p32(3,1),0.1),
        anim8.newAnimation(p32(3,1),0.1),
        anim8.newAnimation(p32(4,1),0.1),
        anim8.newAnimation(p32(4,1),0.1),
      }

    self.movement = {
        anim8.newAnimation(p32(4,3, 13,2, 8,3, 12,3),0.1),--north
        anim8.newAnimation(p32(13,3, 1,3, 5,3, 9,3), 0.1),--east
        anim8.newAnimation(p32(3,3, 12,2, 7,3, 11,3), 0.1),--south
        anim8.newAnimation(p32(1,4, 2,3, 6,3, 10,3), 0.1),--west
        anim8.newAnimation(p32(13,3, 1,3, 5,3, 9,3), 0.1),--northeast
        anim8.newAnimation(p32(13,3, 1,3, 5,3, 9,3), 0.1),--southeast
        anim8.newAnimation(p32(1,4, 2,3, 6,3, 10,3), 0.1),--northwest
        anim8.newAnimation(p32(1,4, 2,3, 6,3, 10,3), 0.1),--southwest
    }
end

function mob:update(dt)
end

function mob:draw()
    if(self.isMoving) then
        self.movement[self.direction]:draw(self.mobImage, self.x, self.y)
    else
        self.standing[self.direction]:draw(self.mobImage, self.x, self.y)
    end
    self.healthBar:draw()
end
