class "Ship" {
	x = 0;
	y = 0;
	rotation = 0;
	vx = 0;
	vy = 0;
	speed = 15;
	rotation_speed = 360;
}

function Ship:__init(img)
	self.img = img
end

function Ship:draw()
	love.graphics.draw(self.img, self.x, self.y, math.rad(self.rotation+90), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
end

function Ship:update(dt, keys)
	if keys["left"] then self.rotation = self.rotation - self.rotation_speed * dt end
	if keys["right"] then self.rotation = self.rotation + self.rotation_speed * dt end

	if keys["up"] then
		self.vx = self.vx + math.cos(math.rad(self.rotation)) * 40 * dt
		self.vy = self.vy + math.sin(math.rad(self.rotation)) * 40 * dt
	else
		self.vx = self.vx * 0.5 * dt
		self.vy = self.vy * 0.5 * dt
	end

	self.x = self.x + self.vx
	self.y = self.y + self.vy
end
