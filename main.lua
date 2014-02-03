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
end

function love.keypressed(key, isrepeat)
	keys[key] = true
	if key == "rctrl" then
		debug.debug()
	elseif key == " " then
		fire_laser()
	end
end

function love.keyreleased(key)
	keys[key] = false
	for _, laser in pairs(lasers) do
		laser:draw()
	end
end

function fire_laser()
	local x = ship.x + math.cos(math.rad(ship.rotation))
	local y = ship.y + math.sin(math.rad(ship.rotation))
	table.insert(lasers, Laser:new(img["laser"], x, y, ship.rotation))
end
