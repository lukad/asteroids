class "Drawable" {}

function Drawable:__init(img)
	self.img = img
	self.w = self.img:getWidth()
	self.h = self.img:getHeight()
end

function Drawable:draw_overlapping(x, y, rotation)
	if x - self.w/2 < 0 then
		love.graphics.draw(self.img, width + x, y, math.rad(rotation+90), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
	elseif x + self.w/2 > width then
		love.graphics.draw(self.img, x - width, y, math.rad(rotation+90), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
	end
	if y - self.h/2 < 0 then
		love.graphics.draw(self.img, x, height + y, math.rad(rotation+90), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
	elseif y + self.h/2 > height then
		love.graphics.draw(self.img, x, y - height, math.rad(rotation+90), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
	end
end

function Drawable:draw(x, y, rotation)
	love.graphics.draw(self.img, x, y, math.rad(rotation+90), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
	self:draw_overlapping(x, y, rotation)
end
