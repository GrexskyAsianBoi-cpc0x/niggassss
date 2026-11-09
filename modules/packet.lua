local _M = {}
local _S
local _A = false
local _TR, _FR, _TO = 0.03, 0.03, 3
local _SS = 1
local _P = game:GetService("Players")
local _RS = game:GetService("ReplicatedStorage")
local _L = _P.LocalPlayer

local _PE = _RS:WaitForChild("AddonEvents"):WaitForChild("PaketEvent")

local _GS, _GI = {}, 0
local _AS, _AI = {}, 0

local function _iaD(_c)
    local _h = _c:WaitForChild("Humanoid", 5)
    if not _h then return end
    _h.BreakJointsOnDeath = false
    pcall(function() _h:SetStateEnabled(Enum.HumanoidStateType.Seated, false) end)
    _h.HealthChanged:Connect(function(_v) if _A and _v < _h.MaxHealth then _h.Health = _h.MaxHealth end end)
    _h.Seated:Connect(function(_s) if _s then task.wait(0.05); _h.Sit = false; _h.Jump = true end end)
end
_L.CharacterAdded:Connect(_iaD)
if _L.Character then _iaD(_L.Character) end

local function _ftUI()
    local _pg = _L:FindFirstChild("PlayerGui")
    if not _pg then return nil end
    for _, _v in ipairs(_pg:GetDescendants()) do
        if _v:IsA("TextLabel") and _v.Visible then
            local _tx = _v.Text or ""
            if _tx:find("Antar") or _tx:find("Package") or _tx:find("Target") then
                for _, _pl in ipairs(_P:GetPlayers()) do
                    if _pl ~= _L then
                        if _tx:find(_pl.Name, 1, true) or (_pl.DisplayName ~= "" and _tx:find(_pl.DisplayName, 1, true)) then return _pl end
                    end
                end
            end
        end
    end
    return nil
end

local function _gtCF(_t)
    if not _t then return nil end
    local _mc = _L.Character
    local _mp = (_mc and _mc:FindFirstChild("HumanoidRootPart")) and _mc.HumanoidRootPart.Position or Vector3.zero
    local _tc = _t.Character
    if _tc then
        local _th = _tc:FindFirstChild("HumanoidRootPart")
        if _th then return _th.CFrame end
        local _h = _tc:FindFirstChildOfClass("Humanoid")
        if _h and _h.RootPart then return _h.RootPart.CFrame end
        local _ap = _tc:FindFirstChildWhichIsA("BasePart", true)
        if _ap then return _ap.CFrame end
        local _o, _pv = pcall(function() return _tc:GetPivot() end)
        if _o and _pv and _pv.Position.Magnitude > 0 then return _pv end
    end
    local _wt = workspace:FindFirstChild(_t.Name, true)
    if _wt then
        if _wt:IsA("Model") then 
            local _o, _pv = pcall(function() return _wt:GetPivot() end)
            if _o and _pv and _pv.Position.Magnitude > 0 then return _pv end
        elseif _wt:IsA("BasePart") then return _wt.CFrame end
    end
    for _, _v in ipairs(workspace:GetDescendants()) do
        if _v:IsA("Beam") then
            local _p0 = _v.Attachment0 and _v.Attachment0.WorldPosition
            local _p1 = _v.Attachment1 and _v.Attachment1.WorldPosition
            if _p0 and _p1 then
                local _d0, _d1 = (_p0 - _mp).Magnitude, (_p1 - _mp).Magnitude
                if math.max(_d0, _d1) > 100 then return CFrame.new(_d0 > _d1 and _p0 or _p1) end
            elseif _p0 then if (_p0 - _mp).Magnitude > 100 then return CFrame.new(_p0) end
            elseif _p1 then if (_p1 - _mp).Magnitude > 100 then return CFrame.new(_p1) end end
        end
    end
    for _, _v in ipairs(workspace:GetDescendants()) do
        if _v:IsA("BasePart") and _v.Color == Color3.fromRGB(255, 255, 0) and (_v.Position - _mp).Magnitude > 100 then return _v.CFrame end
    end
    local _pg = _L:FindFirstChild("PlayerGui")
    if _pg then
        for _, _v in ipairs(_pg:GetDescendants()) do
            if _v:IsA("TextLabel") and _v.Text:lower():find("antar ke") then
                local _at = _v:GetAttributes()
                for _, _vl in pairs(_at) do
                    if typeof(_vl) == "Vector3" then return CFrame.new(_vl) end
                    if typeof(_vl) == "CFrame" then return _vl end
                end
            end
        end
    end
    for _, _v in ipairs(_RS:GetDescendants()) do
        if (_v:IsA("Vector3Value") or _v:IsA("CFrameValue")) and (_v.Name:lower():find(_t.Name:lower()) or _v.Name:lower():find("target") or _v.Name:lower():find("pos")) then
            if _v:IsA("Vector3Value") then return CFrame.new(_v.Value) else return _v.Value end
        end
    end
    return nil
end

local function _sC(_st)
    local _c = _L.Character
    if not _c then return end
    for _, _p in ipairs(_c:GetDescendants()) do
        if _p:IsA("BasePart") then pcall(function() _p.CanCollide = _st end) end
    end
end

local function _isC()
    local _c = _L.Character
    if not _c then return false end
    if _c:FindFirstChildOfClass("Tool") then return true end
    local _bp = _L:FindFirstChild("Backpack")
    if _bp and _bp:FindFirstChildOfClass("Tool") then return true end
    for _, _v in ipairs(_c:GetDescendants()) do
        if _v:IsA("BasePart") or _v:IsA("Model") or _v:IsA("Accessory") then
            local _n = _v.Name:lower()
            if _n:find("paket") or _n:find("package") or _n:find("box") or _n:find("kardus") then return true end
        end
    end
    for _, _v in ipairs(_c:GetDescendants()) do
        if _v:IsA("BillboardGui") then
            local _tx = _v:FindFirstChildWhichIsA("TextLabel", true)
            if _tx and _tx.Text:lower():find("paket") then return true end
        end
    end
    return false
end

local function _sM(_kw)
    local _fd = {}
    for _, _v in ipairs(workspace:GetDescendants()) do
        if _v:IsA("BasePart") or _v:IsA("Model") then
            local _n = _v.Name:lower()
            for _, _k in ipairs(_kw) do
                if _n:find(_k, 1, true) then
                    local _p = _v:IsA("BasePart") and _v or _v:FindFirstChildWhichIsA("BasePart", true)
                    if _p then table.insert(_fd, _p) break end
                end
            end
        end
    end
    return _fd
end

local function _tTN(_sp, _ix, _bt, _lb, _cl)
    if #_sp == 0 or _ix >= #_sp then
        local _kw = _lb == "GEMBOK" and {"gembok", "lock", "padlock", "vault", "kunci"} or {"anomali", "glitch", "error", "hidden", "secret", "weird", "rare"}
        _sp = _sM(_kw); _ix = 1
    else _ix = _ix + 1 end

    if #_sp == 0 then
        _bt.Text = _lb .. " NOT FOUND!"
        task.delay(2, function() _bt.Text = _lb .. " FINDER" end)
        return _sp, _ix
    end
    local _tg = _sp[_ix]
    local _c = _L.Character
    if _c and _c:FindFirstChild("HumanoidRootPart") then
        _c:PivotTo(_tg.CFrame * CFrame.new(0, 5, 5))
        _bt.Text = _lb .. " (" .. _ix .. "/" .. #_sp .. ")"
        if not _tg:FindFirstChild("FinderHL") then
            local _hl = Instance.new("Highlight")
            _hl.Name = "FinderHL"; _hl.FillColor = _cl; _hl.OutlineColor = _cl
            _hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; _hl.Adornee = _tg; _hl.Parent = _tg
        end
    end
    return _sp, _ix
end

task.spawn(function()
    while true do
        task.wait(_TR)
        if _A then
            pcall(function()
                local _c = _L.Character
                local _h = _c and _c:FindFirstChild("HumanoidRootPart")
                local _hm = _c and _c:FindFirstChildOfClass("Humanoid")
                if not _h or not _hm then return end
                if _hm.Health < _hm.MaxHealth then _hm.Health = _hm.MaxHealth end
                if _hm.Sit then _hm.Sit = false; _hm.Jump = true end
                if _isC() then
                    local _tg = _ftUI()
                    local _cf = _gtCF(_tg)
                    if not _cf then return end
                    if (_h.Position - _cf.Position).Magnitude > 400 then task.spawn(function() pcall(function() _L:RequestStreamAroundAsync(_cf.Position) end) end) end
                    _SS = -_SS
                    _h.CFrame = _cf * CFrame.new(0, 1.5, _SS * _TO)
                    _h.Velocity = Vector3.zero; _h.AssemblyLinearVelocity = Vector3.zero
                    if _hm:GetState() == Enum.HumanoidStateType.Freefall or _hm:GetState() == Enum.HumanoidStateType.FallingDown then _hm:ChangeState(Enum.HumanoidStateType.GettingUp) end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(_FR)
        if _A then pcall(function() _PE:FireServer("Accept") end) end
    end
end)

function _M.init(shared)
    _S = shared
    local _t = _S.modules.gui.tab("Packet", "rbxassetid://6031091004")
    
    local _tb
    _tb = _t.button("AUTO DELIVER  [OFF]", function()
        _A = not _A
        if _A then
            _tb.Text = "AUTO DELIVER  [ON]"
            _tb.BackgroundColor3 = Color3.fromRGB(240,90,110)
            _sC(false)
        else
            _tb.Text = "AUTO DELIVER  [OFF]"
            _tb.BackgroundColor3 = Color3.fromRGB(14,27,62)
            pcall(function() _PE:FireServer("Cancel") end)
            _sC(true)
        end
    end)
    
    local _gb
    _gb = _t.button("GEMBOK FINDER", function()
        _GS, _GI = _tTN(_GS, _GI, _gb, "GEMBOK", Color3.fromRGB(255, 255, 0))
    end)
    
    local _ab
    _ab = _t.button("ANOMALI FINDER", function()
        _AS, _AI = _tTN(_AS, _AI, _ab, "ANOMALI", Color3.fromRGB(255, 0, 255))
    end)

    local _cb
    _cb = _t.button("CLEAR HIGHLIGHTS", function()
        for _, _v in ipairs(workspace:GetDescendants()) do
            if _v:IsA("Highlight") and _v.Name == "FinderHL" then _v:Destroy() end
        end
        _GS, _GI = {}, 0
        _AS, _AI = {}, 0
        _gb.Text = "GEMBOK FINDER"
        _ab.Text = "ANOMALI FINDER"
        _cb.Text = "CLEARED!"
        task.delay(1, function() _cb.Text = "CLEAR HIGHLIGHTS" end)
    end)
end

return _M 
