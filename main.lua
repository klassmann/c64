
require("graphics")
local utf8 = require("utf8")


output = {}
memory = {}
program = {}
input = {}
top_line = 1
current_line = 0
case_mode = 'upper'
COLUMNS = 41
FONT_SIZE = 18
MAX_ROWS = 28
INITIAL_BUFFER = 30

function process_input(s)
    print(s)
    local prg = string.gmatch(s, "([%d]+)%s(.*)")
    if prg then
        for p in prg do
            print("PRG:", p)
        end
    else
        local repl = s:gmatch("([.]+)")
        local code = repl()
        print("REPL:", code)
    end
end

function incr_line()
    current_line = current_line + 1
end

function toggle_case()
    if case_mode == 'upper' then
        case_mode = 'lower'
    else
        case_mode = 'upper'
    end
end

function format_case(s)
    if case_mode == 'upper' then
        return s:upper()
    end
    return s:lower()
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
            count = 0
        end
    end
    table.insert(output, line)
    -- incr_line()
end

function readline(s)
    if table.getn(input) >= COLUMNS - 1 then
        flush_readline()
    end
    table.insert(input, s)
end

function backspace()
    table.remove(input, table.getn(input))
end

function flush_readline()
    local s = table.concat(input)
    process_input(s)
    write(s)
    incr_line()
    input = {}
end

function get_topline()
    if current_line > MAX_ROWS then
        return current_line - MAX_ROWS
    end
    return 0
end

function love.load()
    font = love.graphics.newFont("C64_Pro_Mono-STYLE.ttf", FONT_SIZE)
    love.graphics.setFont(font)
    love.graphics.setBackgroundColor(get_color(14))
    screenHeight = love.graphics.getHeight()
    screenWidth = love.graphics.getWidth()

    write("**** commodore 64 base v2 ****")
    write("64K ram system   38911 basic bytes free")
    write("ready.")
    write("")
end

function love.draw()
    love.graphics.setColor(get_color(15))
    love.graphics.rectangle('fill', INITIAL_BUFFER, INITIAL_BUFFER, screenWidth - 60, screenHeight - 60)
    love.graphics.setColor(get_color(14))

    last_line = 1
    top_line = get_topline()
    for k, v in ipairs(output) do
        if k > top_line then
            local ws = table.concat(v)
            love.graphics.print(format_case(ws), 
                INITIAL_BUFFER, (FONT_SIZE * (k - top_line)) + INITIAL_BUFFER)
            last_line = (k - top_line)
        end
    end

    local s = table.concat(input) .. "|"
    love.graphics.print(format_case(s), 
        INITIAL_BUFFER, (FONT_SIZE * (last_line + 1)) + INITIAL_BUFFER)
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

    if key == 'tab' then
        toggle_case()
    end

    if key == 'return' then
        flush_readline()
    end
end