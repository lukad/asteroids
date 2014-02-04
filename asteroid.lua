class "Asteroid" {}

function Asteroid:__init(img, x, y)
	self.x = x
	self.y = y
	self.speed = 30 + math.random(100)
	self.rotation = math.random(360)
	self.img_rotation = math.random(360)
	self.drawable = Drawable:new(img)
end

function Asteroid:draw()
	self.drawable:draw(self.x, self.y, self.img_rotation)
end

function Asteroid:update(dt)
	-- Move the asteroid
	self.x = self.x + math.cos(math.rad(self.rotation)) * self.speed * dt
	self.y = self.y + math.sin(math.rad(self.rotation)) * self.speed * dt

	-- Wrap position
	if self.x > width or self.x < 0 then self.x = self.x % width end
	if self.y > height or self.y < 0 then self.y = self.y % height end
end


