local aris_palette = require("palette")
local aris_music = require("music")
local aris_player = require("player")
require("click")

function love.load()
    love.graphics.setBackgroundColor(aris_palette.black)
    aris_player:add_music(aris_music.new("assets/Khalil Fong - Love Song.mp3"))
end

function love.update()
    aris_player:update()
end

function love.keypressed(key)
    if key == "space" then
        if aris_player:is_playing() then
            aris_player:pause_music()
        else
            aris_player:play_music()
        end
    end
end

function love.draw()
    aris_player:draw()
end

function love.mousepressed(x, y, btn, istouch)
    local layout = aris_layout_get(love.graphics.getWidth(), love.graphics.getHeight())
    local click_type = aris_click_get(layout, x, y)
    if click_type == _G.progress_bar_click then
        print("click progress bar")
    end
end
