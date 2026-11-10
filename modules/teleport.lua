local _M = {}

function _M.init(_s)
    local _t = _s.modules.gui.tab("Teleport", Color3.fromRGB(255, 255, 0), "⚡")
    local _p = game:GetService("Players").LocalPlayer
    local _ts = game:GetService("TweenService")
    
    local _mode = "Instant"
    local _tOn = false
    local _tSpd = 100
    
    _t.dropdown("Teleport Mode", {"Instant", "Tween"}, "Instant", function(_v)
        _mode = _v
    end)
    
    _t.toggle("Tween Mode", false, function(_v)
        _tOn = _v
    end)
    
    _t.slider("Tween Speed", 10, 500, 100, function(_v)
        _tSpd = _v
    end)
    
    local function _tp(_pos)
        local _c = _p.Character
        local _h = _c and _c:FindFirstChild("HumanoidRootPart")
        if not _h then return end
        
        local _cf = CFrame.new(_pos)
        if _mode == "Tween" and _tOn then
            local _d = (_h.Position - _pos).Magnitude
            local _ti = TweenInfo.new(_d / _tSpd, Enum.EasingStyle.Linear)
            _ts:Create(_h, _ti, {CFrame = _cf}):Play()
        else
            _h.CFrame = _cf
        end
    end
    
    local _locs = {
        {n = "Toko sepeda(Biasa)", p = Vector3.new(667.18, 4.05, 3410.70)},
        {n = "Tempat Modif", p = Vector3.new(851.32, 3.63, 2717.79)},
        {n = "Toko Sepeda(Polygon)", p = Vector3.new(1368.19, 4.95, 3776.99)},
        {n = "Tempat Jual Sepeda", p = Vector3.new(1201.90, 3.96, 4764.67)},
        {n = "Tempat Balapan", p = Vector3.new(-751.27, 3.80, -2039.42)},
        {n = "Tempat Beli Bahan Freestyle", p = Vector3.new(-963.22, 4.93, -927.09)},
        {n = "Kerja Montir", p = Vector3.new(51.51, 3.98, 3262.49)}
    }
    
    for _, _l in ipairs(_locs) do
        _t.button("Tp To " .. _l.n, function()
            _tp(_l.p)
        end)
    end
end

return _M
