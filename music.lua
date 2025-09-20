local aris_palette = require("palette")

local aris_music = {}
aris_music.__index = aris_music

local PLAYING  = 1
local PAUSED   = 2
local FINISHED = 3

local function round_to_two_decimals(num)
    return math.floor(num * 100 + 0.5) / 100
end

function aris_music.new(filename)
    local obj = {}
    setmetatable(obj, aris_music)
    obj.name = filename
    obj.source = love.audio.newSource(filename, "stream")
    obj.source:setVolume(0.5)
    obj.source:setLooping(false)
    obj.state = PAUSED
    obj.play_duration = 0
    obj.total_duration = round_to_two_decimals(obj.source:getDuration())
    return obj
end

function aris_music:play()
    if self.state ~= PLAYING then
        self.state = PLAYING
        love.audio.play(self.source)
    end
end

function aris_music:pause()
    if self.state == PLAYING then
        self.state = PAUSED
        love.audio.pause(self.source)
    end
end

function aris_music:stop()
    self.state = PAUSED
    love.audio.stop(self.source)
    self.play_duration = 0
end

function aris_music:is_playing()
    return self.state == PLAYING and true or false
end

function aris_music:is_paused()
    return self.state == PAUSED and true or false
end

function aris_music:is_finished()
    return self.state == FINISHED and true or false
end

function aris_music:update()
    self.play_duration = round_to_two_decimals(self.source:tell())
    if self.total_duration - self.play_duration < 0.1 then
        self.state = FINISHED
    end
end

function aris_music:get_ratio()
    return self.play_duration / self.total_duration
end

function aris_music:set_volume(volume)
    self.source:setVolume(volume)
end

return aris_music
