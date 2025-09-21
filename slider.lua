local Slider = {}
Slider.__index = Slider

function Slider.new(rx, ry, rw, rh, value, color)
    local obj = {}
    setmetatable(obj, Slider)

    -- init
    obj.rx = rx
    obj.ry = ry
    obj.rw = rw
    obj.rh = rh
    obj.value = value
    obj.color = color -- {bg, fg}

    return obj
end

function Slider:draw(screen_width, screen_height)
    love.graphics.setColor(self.color.bg)
    love.graphics.rectangle(
        "fill",
        self.rx*screen_width, self.ry*screen_height,
        self.rw*screen_width, self.rh*screen_height
    )
    love.graphics.setColor(self.color.fg)
    love.graphics.rectangle(
        "fill",
        self.rx*screen_width, self.ry*screen_height,
        self.value*self.rw*screen_width, self.rh*screen_height
    )
end

return Slider
