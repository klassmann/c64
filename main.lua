

palette = {
    {0, 0, 0},        -- #000000
    {255, 255, 255},  -- #ffffff
    {98, 98, 98},     -- #626262
    {137, 137, 137},  -- #898989
    {173, 173, 173},  -- #adadad
    {159, 78, 68},    -- #9f4e44
    {203, 126, 117},  -- #cb7e75
    {109, 84, 18},    -- #6d5412
    {161, 104, 60},   -- #a1683c
    {201, 212, 135},  -- #c9d487
    {154, 226, 155},  -- #9ae29b
    {92, 171, 94},    -- #5cab5e
    {106, 191, 198},  -- #6abfc6
    {136, 126, 203},  -- #887ecb
    {80, 69, 155},    -- #50459b
    {160, 87, 163},   -- #a057a3
}

function get_color(index)
    local color = palette[index]
    return {color[1] / 255, color[2] / 255, color[3] / 255}
end


function love.load()
    font = love.graphics.newFont("C64_Pro_Mono-STYLE.ttf", 16)
    love.graphics.setFont(font)
    love.graphics.setBackgroundColor(get_color(14))
    screenHeight = love.graphics.getHeight()
    screenWidth = love.graphics.getWidth()
end

function love.draw()
    
    love.graphics.setColor(get_color(15))
    love.graphics.rectangle('fill', 30, 30, screenWidth - 60, screenHeight - 60)

    love.graphics.setColor(get_color(14))
    love.graphics.print("**** COMMODORE 64 BASIC V2 ****", 110, 60)
    love.graphics.print("64K RAM SYSTEM   38911 BASIC BYTES FREE", 80, 90)
    love.graphics.print("READY.", 30, 120)
end

function love.keypressed(key, scancode, isrepeat)

end