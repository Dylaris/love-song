local Player = {}
Player.__index = Player

function Player.new()
    local obj = {}
    setmetatable(obj, Player)

    -- init
    obj.playing = false
    obj.volume = 0.5
    obj.playlist = {}
    obj.current_music = nil
    obj.current_index = 1

    return obj
end

function Player:load_music_from_file(filepath)
    if not filepath:match("%.mp3$") then return end
    local source = love.audio.newSource(filepath, "stream")
    table.insert(self.playlist, {
        name = filepath:match("[^\\/]+$"),
        path = filepath,
        source = source,
        duration = source:getDuration()
    })
end

function Player:dump_playlist()
    for _, music in ipairs(self.playlist) do
        print(music.name, music.duration)
    end
end

function Player:play(index)
    if self.current_music then self.current_music:stop() end
    index = index or self.current_index
    if index < 1 then index = #self.playlist
    elseif index > #self.playlist then index = 1 end

    self.current_index = index
    self.current_music = self.playlist[self.current_index].source
    self.current_music:setVolume(self.volume)
    self.current_music:setLooping(false)
    self.current_music:play()
    self.playing = true
end

function Player:pause()
    if self.current_music then
        self.current_music:pause()
        self.playing = false
    end
end

function Player:resume()
    if self.current_music and not self.playing then
        self.current_music:play()
        self.playing = true
    end
end

function Player:stop()
    if self.current_music then
        self.current_music:stop()
        self.playing = false
    end
end

function Player:next()
    self:play(self.current_index + 1)
end

function Player:previous()
    self:play(self.current_index - 1)
end

function Player:set_volume(vol)
    self.volume = math.max(0, math.min(1, vol))
    if self.current_music then
        self.current_music:setVolume(self.volume)
    end
end

function Player:inc_volume()
    self:set_volume(self.volume + 0.1)
end

function Player:dec_volume()
    self:set_volume(self.volume - 0.1)
end

function Player:update()
    if self.playing and self.music and not self.music:isPlaying() then
        self:next()
    end
end

return Player
