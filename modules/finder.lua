local _M = {}
local _P = game:GetService("Players")
local _L = _P.LocalPlayer

function _M.init(_s)
    local _t = _s.modules.gui.tab("Finder", Color3.fromRGB(255, 80, 80), "⚡")
    
    local _lw = Instance.new("TextLabel")
    _lw.Size = UDim2.new(1, 0, 0, 40)
    _lw.BackgroundTransparency = 1
    _lw.Text = "Menunggu Event Meteor/Lasers"
    _lw.TextColor3 = Color3.fromRGB(150, 160, 180)
    _lw.Font = Enum.Font.GothamBold
    _lw.TextSize = 14
    _lw.Parent = _t._p
    
    local _cn = Instance.new("Frame")
    _cn.Size = UDim2.new(1, 0, 0, 0)
    _cn.AutomaticSize = Enum.AutomaticSize.Y
    _cn.BackgroundTransparency = 1
    _cn.Parent = _t._p
    
    local _ly = Instance.new("UIListLayout")
    _ly.Padding = UDim.new(0, 6)
    _ly.Parent = _cn
    
    local _map = {}
    
    local function _clr()
        for _k, _v in pairs(_map) do _v.g:Destroy() end
        _map = {}
    end
    
    local function _bld(_pt, _idx)
        local _r = Instance.new("Frame")
        _r.Size = UDim2.new(1, 0, 0, 40)
        _r.BackgroundColor3 = Color3.fromRGB(26, 32, 46)
        _r.Parent = _cn
        local _c = Instance.new("UICorner"); _c.CornerRadius = UDim.new(0, 6); _c.Parent = _r
        local _s = Instance.new("UIStroke"); _s.Color = Color3.fromRGB(40, 50, 70); _s.Transparency = 0.5; _s.Parent = _r
        
        local _tx = Instance.new("TextLabel")
        _tx.Size = UDim2.new(1, -70, 1, 0)
        _tx.Position = UDim2.fromOffset(12, 0)
        _tx.BackgroundTransparency = 1
        _tx.TextColor3 = Color3.fromRGB(255, 255, 255)
        _tx.Font = Enum.Font.GothamBold
        _tx.TextSize = 12
        _tx.TextXAlignment = Enum.TextXAlignment.Left
        _tx.Text = "Laser #" .. _idx .. " | Menghitung..."
        _tx.Parent = _r
        
        local _b = Instance.new("TextButton")
        _b.Size = UDim2.new(0, 44, 1, -12)
        _b.Position = UDim2.new(1, -50, 0, 6)
        _b.BackgroundColor3 = Color3.fromRGB(80, 160, 255)
        _b.Text = "TP"
        _b.TextColor3 = Color3.fromRGB(255, 255, 255)
        _b.Font = Enum.Font.GothamBold
        _b.TextSize = 12
        _b.Parent = _r
        local _bc = Instance.new("UICorner"); _bc.CornerRadius = UDim.new(0, 4); _bc.Parent = _b
        
        _b.MouseButton1Click:Connect(function()
            local _ch = _L.Character
            local _h = _ch and _ch:FindFirstChild("HumanoidRootPart")
            if _h and _pt.Parent then
                _h.CFrame = CFrame.new(_pt.Position + Vector3.new(0, 5, 0))
            end
        end)
        
        return { g = _r, t = _tx }
    end
    
    task.spawn(function()
        while true do
            task.wait(1.5)
            local _ch = _L.Character
            local _h = _ch and _ch:FindFirstChild("HumanoidRootPart")
            local _fd = {}
            
            for _, _v in ipairs(workspace:GetDescendants()) do
                if _v.Name:lower():find("laserlimitedtitik") and (_v:IsA("BasePart") or _v:IsA("Model")) then
                    local _pt = _v:IsA("BasePart") and _v or _v:FindFirstChildWhichIsA("BasePart", true)
                    if _pt then table.insert(_fd, _pt) end
                end
            end
            
            if #_fd == 0 then
                if not _lw.Visible then
                    _lw.Visible = true
                    _clr()
                end
            else
                _lw.Visible = false
                
                for _k, _v in pairs(_map) do
                    if not _k.Parent or not table.find(_fd, _k) then
                        _v.g:Destroy()
                        _map[_k] = nil
                    end
                end
                
                for _i, _pt in ipairs(_fd) do
                    if not _map[_pt] then
                        _map[_pt] = _bld(_pt, _i)
                    end
                    local _ui = _map[_pt]
                    if _h then
                        _ui.t.Text = "Laser #" .. _i .. " | Jarak: " .. math.floor((_pt.Position - _h.Position).Magnitude) .. " studs"
                    else
                        _ui.t.Text = "Laser #" .. _i .. " | Jarak: -"
                    end
                end
            end
        end
    end)
end

return _M
