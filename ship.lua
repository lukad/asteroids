require "drawable"

class "Ship" {
	rotation = -90;
	vx = 0;
	vy = 0;
	accel = 35;
	friction = 0.09;
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
	if keys["left"] or keys["a"] then self.rotation = self.rotation - self.rotation_speed * dt end
	if keys["right"] or keys["d"] then self.rotation = self.rotation + self.rotation_speed * dt end

	-- Apply forward thrust
	if keys["up"] or keys["w"] then
		self.vx = self.vx + math.cos(math.rad(self.rotation)) * self.accel * dt
		self.vy = self.vy + math.sin(math.rad(self.rotation)) * self.accel * dt
	end

	-- Apply friction
	self.vx = self.vx * math.pow(self.friction, dt)
	self.vy = self.vy * math.pow(self.friction, dt)

	-- Calculate position by adding delta velocity
	self.x = self.x + self.vx
	self.y = self.y + self.vy

	-- Wrap position
	if self.x > width or self.x < 0 then self.x = self.x % width end
	if self.y > height or self.y < 0 then self.y = self.y % height end
end
