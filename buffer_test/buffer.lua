
Buffer = {}
Buffer.output = {}
Buffer.input = {}
Buffer.current_row = 1
Buffer.row_height = 12

function Buffer:new(cols, rows, row_height)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.cols = cols
    o.rows = rows
    o.row_height = row_height

    return o
end

function Buffer:write(s)
    local count = 0
    local line = {}

    for c in string.gmatch(s, ".") do
        table.insert(line, c)
        count = count + 1
        if count >= self.cols then
            table.insert(self.output, line)
            line = {}
            self.current_row = self.current_row + 1
        end
    end

    table.insert(self.output, line)
    self.current_row = self.current_row + 1
end

function Buffer:readline(s)
    table.insert(self.input, s)
end

function backspace()
    table.remove(self.input, table.getn(self.input))
end

function Buffer:flush()
    self.current_row = self.current_row + 1
    local s = table.concat(self.input)
    self:write(s)
    self.input = {}
end

function Buffer:keyinput(key)
    if key:len() == 1 then
        if key:gmatch('^[0-9a-zA-Z]{1}$') then
            self:readline(key)
        end
    end

    if key == 'space' then
        self:readline(" ")
    end

    if key == 'return' then
        self:flush()
    end
end

function Buffer:draw(x, y)
    local lastline = 0
    local topline = self.current_row % self.rows
    
    for k, v in ipairs(self.output) do
        love.graphics.print(v, x, self.row_height * k + y)
        lastline = k
    end

    local s = table.concat(self.input)
    love.graphics.print(s .. "|", x, self.row_height * (lastline + 1) + y)
end
