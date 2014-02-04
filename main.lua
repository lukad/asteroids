require "32log"
require "ship"
require "laser"
require "asteroid"

keys = {}
lasers = {}
asteroids = {}

function love.load()
	-- Load images
	img = {
		["ship"] = love.graphics.newImage("assets/img/ship.png"),
		["laser"] = love.graphics.newImage("assets/img/laser.png"),
		["asteroid"] = love.graphics.newImage("assets/img/asteroid.png")
	}

	-- Load sounds
	sounds = {
		["laser"] = love.audio.newSource("assets/sound/laser.wav"),
		["explosion"] = love.audio.newSource("assets/sound/explosion.wav")
	}

	-- Seed random
	math.randomseed(os.time())

	-- Get height and width
	height = love.window.getHeight()
	width = love.window.getWidth()

	-- Create player ship
	ship = Ship:new(img["ship"], width/2, height/2)

	table.insert(asteroids, Asteroid:new(img["asteroid"], 50, 50))
end

function love.draw()
	ship:draw()
	for _, laser in pairs(lasers) do
		laser:draw()
	end

	-- Draw asteroids
	for _, asteroid in pairs(asteroids) do
		asteroid:draw()
	end
end

function love.update(dt)
	ship:update(dt, keys)

	-- Update asteroids
	for _, asteroid in pairs(asteroids) do
		asteroid:update(dt)
	end

	local now = love.timer.getTime()
	for i, laser in pairs(lasers) do
		if now - laser.created_at > laser.lifetime then
			table.remove(lasers, i)
			goto continue
		end

		laser:update(dt)

		-- Check for collision with asteroids
		for j, asteroid in pairs(asteroids) do
			if laser:collides_with(asteroid) then
				love.audio.play(sounds["explosion"])
				table.remove(asteroids, j)
				table.remove(lasers, i)
				goto continue
			end
		end

		::continue::
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
	last_laser = now
	local x = ship.x + math.cos(math.rad(ship.rotation))
	local y = ship.y + math.sin(math.rad(ship.rotation))
	local speed = math.sqrt(ship.vx*ship.vx + ship.vy*ship.vy)/love.timer.getDelta()
	table.insert(lasers, Laser:new(img["laser"], x, y, ship.rotation, speed))

	love.audio.play(sounds["laser"])
end
