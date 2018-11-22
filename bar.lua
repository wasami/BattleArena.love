-- Class to represent a health bar
bar = class('bar')

local border_thickness = 2

function bar:initialize(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.percentage = 100
    self.fill_space = self.w - border_thickness

    self.outline_colour = {0, 0, 0, 255}
end

function bar:set(percentage)
    self.percentage = math.max(0, math.min(percentage, 100))
end

function bar:draw()
    local r, g, b, a = love.graphics.getColor()

    -- The bar inside colour
    local fillamount = self.fill_space * self.percentage / 100
    if fillamount > 25 then
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.rectangle("fill", self.x - self.w / 2 + border_thickness, self.y - self.h / 2, fillamount, self.h, 2, 2)
    elseif fillamount > 0 then
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.rectangle("fill", self.x - self.w / 2 + border_thickness, self.y - self.h / 2, fillamount, self.h, 2, 2)
    end

    --The bar outline
    love.graphics.setLineWidth(border_thickness)
    love.graphics.setColor(unpack(self.outline_colour))
    love.graphics.rectangle("line", self.x - self.w / 2, self.y - self.h / 2, self.w, self.h, 2, 2)
    love.graphics.setLineWidth(lineWidth)
    
end