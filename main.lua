require "32log"
require "ship"

keys = {}
lasers = {}
width = love.window.getWidth()
height = love.window.getHeight()

function love.load()
	ship_img = love.graphics.newImage("assets/ship.png")
	ship = Ship:new(ship_img, width/2, height/2)
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
