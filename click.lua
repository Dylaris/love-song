_G.progress_bar_click = 1

-- rect = {x, y, w, h}
local function inside_rectangle(x, y, rect)
    return x >= rect.x and
           x <= rect.x + rect.w and
           y >= rect.y and
           y <= rect.y + rect.h
end

-- circle = {x, y, r}
local function inside_circle(x, y, circle)
    local dx = x - circle.x
    local dy = y - circle.y
    return (dx * dx + dy * dy) <= (circle.r * circle.r)
end

function aris_click_get(layout, mouse_x, mouse_y)
    local progress_bar = layout.progress_bar
    if inside_rectangle(mouse_x, mouse_y, progress_bar) then
        return _G.progress_bar_click
    end
end
