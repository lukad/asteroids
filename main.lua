require "32log"
require "ship"
require "laser"

keys = {}
lasers = {}

function love.load()
	-- Load images
	img = {
		["ship"] = love.graphics.newImage("assets/ship.png"),
		["laser"] = love.graphics.newImage("assets/laser.png")
	}

	-- Get height and width
	height = love.window.getHeight()
	width = love.window.getWidth()

	-- Create player ship
	ship = Ship:new(img["ship"], width/2, height/2)
end

function love.draw()
	ship:draw()
	for _, laser in pairs(lasers) do
		laser:draw()
	end
end

function love.update(dt)
	ship:update(dt, keys)
	local now = love.timer.getTime()
	for i, laser in pairs(lasers) do
		laser:update(dt)
		if now - laser.created_at > laser.lifetime then
			table.remove(lasers, i)
		end
	end

	-- Fire lasers
	if keys[" "] then
		fire_laser()
	end
end

function love.keypressed(key, isrepeat)
	keys[key] = true
	if key == "rctrl" then
		debug.debug()
	end
end

function love.keyreleased(key)
	keys[key] = false
	for _, laser in pairs(lasers) do
		laser:draw()
	end
end

last_laser = 0
LASERS_PER_SECOND = 4
function fire_laser()
	local now = love.timer.getTime()
	if now - last_laser <= 1.0/LASERS_PER_SECOND then
		return
	end
	local x = ship.x + math.cos(math.rad(ship.rotation))
	local y = ship.y + math.sin(math.rad(ship.rotation))
	local speed = math.sqrt(ship.vx*ship.vx + ship.vy*ship.vy)/love.timer.getDelta()
	table.insert(lasers, Laser:new(img["laser"], x, y, ship.rotation, speed))
	last_laser = now
end
