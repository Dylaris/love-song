require("winsize")
require("palette")
local Slider = require("slider")

local UI = {}
UI.__index = UI

function UI.new(player)
    local obj = {}
    setmetatable(obj, UI)

    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    -- init
    obj.font = love.graphics.newFont(14)
    obj.player = player
    obj.buttons = {}
    obj.sliders = {
        volume = Slider.new(8.5/10, 18/20, 1/10, 1/80, 0,
                            {bg = _G.palette.volume_slider_bg, fg = _G.palette.volume_slider_fg}),
        music = Slider.new(1/10, 18/20, 7/10, 1/80, 0,
                            {bg = _G.palette.music_slider_bg, fg = _G.palette.music_slider_fg}),
    }

    return obj
end


function UI:draw()
    for _, slider in pairs(self.sliders) do
        slider:draw(_G.screen_width, _G.screen_height)
    end
end

function UI:update()
    self.sliders.volume.value = self.player.volume
    self.sliders.music.value = self.player.current_music and
        self.player.current_music:tell()/self.player.current_music:getDuration() or 0
end

return UI
