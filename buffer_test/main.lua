
require("buffer")

function love.load()
    buff = Buffer:new(40, 20, 16)
    buff:write("Hello from Buffer")
    buff:write("Hello from Buffer")
    buff:write("Hello from Buffer")
end

function love.draw()
    buff:draw(10, 10)
end

function love.keypressed(key, scancode, isrepeat)
    buff:keyinput(key)
end