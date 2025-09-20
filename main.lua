local palette = require("palette")
local aris_music = require("music")
local player = require("player")
require("click")

function love.load()
    love.graphics.setBackgroundColor(palette.black)
    player:add_music(aris_music.new("assets/王铮亮 - 不凡.mp3"))
    player:add_music(aris_music.new("assets/Khalil Fong - Love Song.mp3"))
end

function love.update()
    player:update()
end

function love.keypressed(key)
    -- play/pause music
    if key == "space" then
        if player:is_playing() then
            player:pause_music()
        else
            player:play_music()
        end
    end

    -- control volume
    if key == "up" then
        player:increse_volume()
    elseif key == "down" then
        player:reduce_volume()
    end

    -- play order
    if key == "left" then
        player:play_prev_music()
    elseif key == "right" then
        player:play_next_music()
    end
end

function love.draw()
    player:draw()
end

function love.mousepressed(x, y, btn, istouch)
    local layout = aris_layout_get(love.graphics.getWidth(), love.graphics.getHeight())
    local click_type = aris_click_get(layout, x, y)
    if click_type == _G.progress_bar_click then
        print("click progress bar")
    end
end
