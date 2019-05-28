--[[directions
  north = 1
  east = 2
  south = 3
  west = 4
  northeast = 5
  southeast = 6
  southwest = 7
  northwest = 8
--]]
player = class('player')

function player:initialize(x, y, w, h)
  self.playerImage = love.graphics.newImage('Sprites/nakedSprite.jpg')

  local p32 = anim8.newGrid(32,32, 416, 416, 0, 0, 0)

  self.isMoving = false
  self.health = 100
  self.direction = 1
  self.x = x
  self.y = y
  self.destX = x
  self.destY = y
  self.w = w
  self.h = h
  self.speed = 100

  -- setup player controls
  self.input = baton.new {
    controls = {
      left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
      right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
      up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
      down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
      fire = {'key:f'}
    },
    pairs = {
      move = {'left', 'right', 'up', 'down'}
    },
    joystick = love.joystick.getJoysticks()[1],
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
  self.punching = {
      anim8.newAnimation(p32(10,5, 1,6),0.1),--north
      anim8.newAnimation(p32(11,5, 2,6),0.1),--east
      anim8.newAnimation(p32(9,5, 13,5),0.1),--south
      anim8.newAnimation(p32(12,5, 3,6),0.1),--west
      anim8.newAnimation(p32(11,5, 2,6),0.1),--northeast
      anim8.newAnimation(p32(11,5, 2,6),0.1),--southeast
      anim8.newAnimation(p32(12,5, 3,6),0.1),--northwest
      anim8.newAnimation(p32(12,5, 3,6),0.1),--southwest
    }

  -- print("player was initialized")
end

function player:update(dt)

	self.input:update()

    local dx, dy = 0, 0

    -- calculate how much player should move
    -- if self.x ~= self.destX then
    --     dx = math.floor((dt*self.speed)*((self.destX-self.x)/math.abs(self.destX-self.x)))
    -- end
    --
    -- if self.y ~= self.destY then
    --     dy = math.floor((dt*self.speed)*((self.destY-self.y)/math.abs(self.destY-self.y)))
    -- end

	x, y = self.input:get('move')

    -- if dx == 0 and dy == 0 then
    dy = y * self.speed * dt
    dx = x * self.speed * dt
    -- end

	-- set player direction
	if (dx == 0) then
		if (dy > 0 ) then self.direction = 3
		elseif (dy < 0) then self.direction = 1 end
	elseif (dx > 0) then
		if (dy > 0 ) then self.direction = 5
		elseif (dy < 0) then self.direction = 6
		else self.direction = 2 end
    else
        if (dy > 0 ) then self.direction = 8
		elseif (dy < 0) then self.direction = 7
		else self.direction = 4 end
	end

    -- move the player if possible
    if dx ~= 0 or dy ~= 0 then
        local cols
        local actualX, actualY, cols, cols_len = world:move(self, self.x + dx, self.y + dy)

        if actualX == self.x and actualY == self.y then
            self.isMoving = false
        else
            self.isMoving = true
        end

        self.x, self.y = actualX, actualY
    else
        self.isMoving = false
    end

    if self.input:pressed 'fire' then
        projectileEngineObj:createProjectile(bullet, self.x, self.y, self.direction)
    end

    self.movement[self.direction]:update(dt)
    self.punching[self.direction]:update(dt)
end

function player:draw()
  if(self.isMoving) then
    self.movement[self.direction]:draw(self.playerImage, self.x, self.y)
  else
    self.standing[self.direction]:draw(self.playerImage, self.x, self.y)
  end

  if love.keyboard.isDown("g") then
    self.punching[self.direction]:draw(self.playerImage, self.x, self.y)
  end

end
