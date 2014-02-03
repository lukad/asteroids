require "drawable"

class "Laser" {
	speed = 450;
	lifetime = 1.5;
}

function Laser:__init(img, x, y, rotation)
	self.img = img
	self.x = x
	self.y = y
	self.rotation = rotation
	self.created_at = love.timer.getTime()
	self.drawable = Drawable:new(self.img)
end

function Laser:update(dt)
	self.x = self.x + math.cos(math.rad(self.rotation)) * self.speed * dt
	self.y = self.y + math.sin(math.rad(self.rotation)) * self.speed * dt

	-- Wrap position
	if self.x > width or self.x < 0 then self.x = self.x % width end
	if self.y > height or self.y < 0 then self.y = self.y % height end
end

function Laser:draw()
	self.drawable:draw(self.x, self.y, self.rotation)
end
