
require("graphics")


output = {}
memory = {}
input = {}
current_line = 1

COLUMNS = 40

function incr_line()
    current_line = current_line + 1
end

function write(s)
    local count = 0
    local line = {}
    for c in s:gmatch(".") do
        table.insert(line, c)
        count = count + 1
        if count >= COLUMNS then
            table.insert(output, line)
            line = {}
            incr_line()
        end
    end
    table.insert(output, line)
    incr_line()
end

function readline(s)
    table.insert(input, s)
end

function backspace()
    table.remove(input, table.getn(input))
end

function flush_readline()
    write(table.concat(input))
    input = {}
end

function love.load()
    font = love.graphics.newFont("C64_Pro_Mono-STYLE.ttf", 16)
    love.graphics.setFont(font)
    love.graphics.setBackgroundColor(get_color(14))
    screenHeight = love.graphics.getHeight()
    screenWidth = love.graphics.getWidth()

    write("**** COMMODORE 64 BASIC V2 ****")
    write("64K RAM SYSTEM   38911 BASIC BYTES FREE")
    write("READY.")
    write("")
end

function love.draw()
    love.graphics.setColor(get_color(15))
    love.graphics.rectangle('fill', 30, 30, screenWidth - 60, screenHeight - 60)
    love.graphics.setColor(get_color(14))
    for k, v in ipairs(output) do
        love.graphics.print(v, 30, 16 * k + 30)
    end

    local s = table.concat(input) .. "�"
    love.graphics.print(s, 30, current_line * 16 + 30)
end

function love.keypressed(key, scancode, isrepeat)

    if key:len() == 1 then
        if key:gmatch('^[0-9a-zA-Z]{1}$') then
            readline(key)
        end
    end

    if key == 'space' then
        readline(" ")
    end

    if key == 'backspace' then
        backspace()
    end

    if key == 'return' then
        flush_readline()
    end
end