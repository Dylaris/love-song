local aris_palette = require("palette")
require("layout")

local aris_progress_bar = {}

function aris_progress_bar:draw(ratio)
    local layout = aris_layout_get(love.graphics.getWidth(), love.graphics.getHeight())
    local progress_bar = layout.progress_bar
    love.graphics.setColor(aris_palette.white)
    love.graphics.rectangle(
        "fill",
        progress_bar.x, progress_bar.y,
        progress_bar.w, progress_bar.h)
    love.graphics.setColor(aris_palette.green)
    love.graphics.rectangle(
        "fill",
        progress_bar.x, progress_bar.y,
        progress_bar.w*ratio, progress_bar.h)
end

return aris_progress_bar
