print("[Hub] Memulai...")
local _u = "https://raw.githubusercontent.com/GrexskyAsianBoi-cpc0x/niggassss/main/modules/"

local _m = {
    util = _u .. "util.lua", gui = _u .. "gui.lua",
    packet = _u .. "packet.lua", teleport = _u .. "teleport.lua"
}
local _s = { modules = {}, version = "1.0" }
getgenv().Shared = _s

local function _l(_n)
    local _p = _m[_n]
    if not _p then return nil end
    print("[Hub] Mengambil: " .. _n)
    local _o, _r = pcall(game.HttpGet, game, _p)
    if not _o then 
        print("[Hub] GAGAL HTTP: " .. tostring(_r)) 
        return nil 
    end
    if type(_r) ~= "string" or #_r < 10 then 
        print("[Hub] FILE KOSONG / 404: " .. _n .. " (Panjang: " .. tostring(#_r) .. ")") 
        return nil 
    end
    local _f, _e = loadstring(_r, "=@" .. _n)
    if not _f then 
        print("[Hub] ERROR SYNTAX: " .. _n .. " | " .. tostring(_e)) 
        return nil 
    end
    return _f
end

for _, _n in ipairs({"util", "gui", "packet", "teleport"}) do
    local _f = _l(_n)
    if _f then
        local _o, _r = pcall(_f)
        if _o and type(_r) == "table" then
            _s.modules[_n] = _r
            print("[Hub] SUKSES LOAD: " .. _n)
        elseif not _o then
            print("[Hub] ERROR RUNTIME DI " .. _n .. ": " .. tostring(_r))
        end
    end
end

local _g = _s.modules["gui"]
if _g and _g.init then
    print("[Hub] Membuka GUI...")
    _g.init(_s)
    for _, _n in ipairs({"packet", "teleport"}) do
        local _p = _s.modules[_n]
        if _p and _p.init then pcall(_p.init, _s) end
    end
    if _g.selectFirst then _g.selectFirst() end
    print("[Hub] Selesai.")
else
    print("[Hub] GAGAL: Modul gui.lua tidak pernah ke-load.")
end
