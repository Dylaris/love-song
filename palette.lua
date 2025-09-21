local bit = require("bit")

local function convert(color)
    local r = bit.band(bit.rshift(color, 8*3), 0xff) / 255
    local g = bit.band(bit.rshift(color, 8*2), 0xff) / 255
    local b = bit.band(bit.rshift(color, 8*1), 0xff) / 255
    local a = bit.band(bit.rshift(color, 8*0), 0xff) / 255
    return {r, g, b, a}
end

_G.palette = {
    bg = convert(0x181818ff),
    volume_slider_bg = convert(0x505050ff),
    volume_slider_fg = convert(0xffffffff),
    music_slider_bg = convert(0x505050ff),
    music_slider_fg = convert(0xffffffff)
}
