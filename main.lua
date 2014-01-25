require "32log"
require "ship"

local keys = {}

function love.load()
	ship_img = love.graphics.newImage("assets/ship.png")
	ship = Ship:new(ship_img)
end

function love.draw()
	ship:draw()
end

function love.update(dt)
	ship:update(dt, keys)
end

function love.keypressed(key, isrepeat)
	keys[key] = true
	if key == "rctrl" then
		debug.debug()
	end
end

function love.keyreleased(key)
	keys[key] = false
end
