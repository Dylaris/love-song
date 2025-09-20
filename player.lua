local aris_palette = require("palette")

local aris_player = {
    playlist = {},
    current_music_idx = 0,
    progress_bar = require("progress_bar"),
    volume = 0.5
}

local function get_current_music(player)
    if #player.playlist == 0 then return end
    return player.playlist[player.current_music_idx]
end

function aris_player:add_music(music)
    table.insert(self.playlist, music)
    if self.current_music_idx == 0 then
        self.current_music_idx = 1
    end
end

function aris_player:play_music()
    if #self.playlist == 0 then return end

    local music = get_current_music(self)
    music:play()
end

function aris_player:play_next_music()
    if #self.playlist == 0 then return end

    -- stop current music
    local music = get_current_music(self)
    music:stop()

    -- play next music
    self.current_music_idx = self.current_music_idx + 1
    if self.current_music_idx > #self.playlist then
        self.current_music_idx = 1
    end
    music = get_current_music(self)
    music:play()
end

function aris_player:play_prev_music()
    if #self.playlist == 0 then return end

    -- stop current music
    local music = get_current_music(self)
    music:stop()

    self.current_music_idx = self.current_music_idx - 1
    if self.current_music_idx < 1 then
        self.current_music_idx = #self.playlist
    end
    music = get_current_music(self)
    music:play()
end

function aris_player:pause_music()
    if #self.playlist == 0 then return end

    local music = get_current_music(self)
    music:pause()
end

function aris_player:draw()
    if #self.playlist == 0 then return end

    local music = get_current_music(self)
    self.progress_bar:draw(music:get_ratio())
end

function aris_player:update()
    if #self.playlist == 0 then return end

    local music = get_current_music(self)
    music:update()
    if music:is_finished() then
        self:play_next_music() -- auto play next music
    end
end

function aris_player:is_playing()
    if #self.playlist == 0 then return end

    local music = get_current_music(self)
    return music:is_playing()
end

function aris_player:is_paused()
    if #self.playlist == 0 then return end

    local music = get_current_music(self)
    return music:is_paused()
end

function aris_player:increse_volume()
    self.volume = self.volume + 0.1
    if self.volume > 1 then self.volume = 1 end
    local music = get_current_music(self)
    music:set_volume(self.volume)
end

function aris_player:reduce_volume()
    self.volume = self.volume - 0.1
    if self.volume < 0 then self.volume = 0 end
    local music = get_current_music(self)
    music:set_volume(self.volume)
end

return aris_player
