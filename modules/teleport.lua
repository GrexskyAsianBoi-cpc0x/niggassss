local _M = {}

function _M.init(_s)
    local _t = _s.modules.gui.tab("Teleport", Color3.fromRGB(255, 255, 0), "⚡")
    local _p = game:GetService("Players").LocalPlayer

    _t.dropdown("Teleport Mode", {"Instant"}, "Instant", function(_v)
    end)

    local function _tp(_pos)
        local _c = _p.Character
        local _h = _c and _c:FindFirstChild("HumanoidRootPart")
        if not _h then return end
        _h.CFrame = CFrame.new(_pos)
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
