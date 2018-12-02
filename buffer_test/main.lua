
require("buffer")

function love.load()
    buff = Buffer:new(80, 10, 14)
end

function love.draw()
    buff:draw(10, 10)
end

function love.keypressed(key, scancode, isrepeat)
    buff:keyinput(key)
end