require("palette")
require("winsize")
local Player = require("player")
local UI = require("ui")

local player = Player.new()
local ui = UI.new(player)

function love.load()
    love.graphics.setBackgroundColor(_G.palette.bg)
    player:load_music_from_file("assets/Khalil Fong - Love Song.mp3")
    player:load_music_from_file("assets/王铮亮 - 不凡.mp3")
end

function love.keypressed(key)
    if key == "space" then
        if player.playing then player:pause()
        else player:play() end
    end

    if key == "left" then player:next()
    elseif key == "right" then player:previous() end

    if key == "up" then player:inc_volume()
    elseif key == "down" then player:dec_volume() end
end

function love.resize(w, h)
    _G.screen_width = w
    _G.screen_height = h
end

function love.update()
    player:update()
    ui:update()
end

function love.draw()
    ui:draw()
end
