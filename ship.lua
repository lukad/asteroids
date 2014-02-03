require "drawable"

class "Ship" {
	rotation = -90;
	vx = 0;
	vy = 0;
	speed = 15;
	rotation_speed = 360;
}

function Ship:__init(img, x, y)
	self.x = x
	self.y = y
	self.img = img
	self.drawable = Drawable:new(img)
end


function Ship:draw()
	self.drawable:draw(self.x, self.y, self.rotation)
end

function Ship:update(dt, keys)
	-- Calculate rotation
	if keys["left"] then self.rotation = self.rotation - self.rotation_speed * dt end
	if keys["right"] then self.rotation = self.rotation + self.rotation_speed * dt end

	-- Apply forward thrust
	if keys["up"] then
		self.vx = self.vx + math.cos(math.rad(self.rotation)) * 40 * dt
		self.vy = self.vy + math.sin(math.rad(self.rotation)) * 40 * dt
	end

	-- Apply friction
	self.vx = self.vx * math.pow(0.05, dt)
	self.vy = self.vy * math.pow(0.05, dt)

	-- Calculate position by adding delta velcity
	self.x = self.x + self.vx
	self.y = self.y + self.vy

	-- Wrap position
	if self.x > width or self.x < 0 then self.x = self.x % width end
	if self.y > height or self.y < 0 then self.y = self.y % height end
end
