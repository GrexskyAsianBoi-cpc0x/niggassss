local _u = "https://raw.githubusercontent.com/GrexskyAsianBoi-cpc0x/niggassss/main/modules/"

local _m = {
    util = _u .. "util.lua", 
    gui = _u .. "gui.lua",
    packet = _u .. "packet.lua", 
    teleport = _u .. "teleport.lua",
    finder = _u .. "finder.lua"
}
local _s = { modules = {}, version = "1.0" }
getgenv().Shared = _s

local function _l(_n)
    local _p = _m[_n]
    if not _p then return nil end
    local _o, _r = pcall(game.HttpGet, game, _p)
    if not _o or type(_r) ~= "string" or #_r < 10 then return nil end
    local _f, _e = loadstring(_r, "=@" .. _n)
    if not _f then return nil end
    return _f
end

for _, _n in ipairs({"util", "gui", "packet", "teleport", "finder"}) do
    local _f = _l(_n)
    if _f then
        local _o, _r = pcall(_f)
        if _o and type(_r) == "table" then
            _s.modules[_n] = _r
        end
    end
end

local _g = _s.modules["gui"]
if _g and _g.init then
    _g.init(_s)
    for _, _n in ipairs({"packet", "teleport", "finder"}) do
        local _p = _s.modules[_n]
        if _p and _p.init then pcall(_p.init, _s) end
    end
    if _g.selectFirst then _g.selectFirst() end
end
