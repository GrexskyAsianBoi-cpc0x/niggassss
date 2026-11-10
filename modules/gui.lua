local _GU = {}
local _S, _M, _C, _B
local _T = {}
local _A

local _RN = game:GetService("RunService")
local _TW = game:GetService("TweenService")
local _UI = game:GetService("UserInputService")

local _H = {
    bg = Color3.fromRGB(10, 12, 18), panel = Color3.fromRGB(18, 22, 32), row = Color3.fromRGB(26, 32, 46),
    acc = Color3.fromRGB(80, 160, 255), bad = Color3.fromRGB(255, 80, 100),
    txt = Color3.fromRGB(255, 255, 255), sub = Color3.fromRGB(150, 160, 180), str = Color3.fromRGB(40, 50, 70),
}
local _F = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local function _N(c, p, ch)
    local i = Instance.new(c)
    for k, v in pairs(p or {}) do i[k] = v end
    for _, x in ipairs(ch or {}) do x.Parent = i end
    return i
end

function _GU.init(shared)
    _S = shared
    local _g = Instance.new("ScreenGui")
    _g.Name = "Hub_" .. math.random(1000, 9999)
    _g.ResetOnSpawn = false
    _g.IgnoreGuiInset = true
    pcall(function() _g.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
    if not _g.Parent then _g.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end

    local _WW, _WH, _TH, _SW = 400, 300, 36, 50
    _M = _N("Frame", {
        Name="Main", Size=UDim2.fromOffset(0,0), Position=UDim2.new(0.5,-_WW/2,0.5,-_WH/2),
        BackgroundColor3=_H.bg, BorderSizePixel=0, ClipsDescendants=true, Parent=_g})
    _N("UICorner", {CornerRadius=UDim.new(0,8), Parent=_M})
    
    local _stroke = _N("UIStroke", {Color=_H.acc, Thickness=1.5, ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Parent=_M})
    local _strokeG = _N("UIGradient", {Color=ColorSequence.new{ColorSequenceKeypoint.new(0, _H.acc), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 80, 255))}, Parent=_stroke})

    _TW:Create(_M, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size=UDim2.fromOffset(_WW, _WH)}):Play()

    local _tb = _N("Frame", {Size=UDim2.new(1,-12,0,28), Position=UDim2.fromOffset(6,6), BackgroundColor3=_H.panel, BorderSizePixel=0, ZIndex=2, Parent=_M})
    _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=_tb})
    
    _N("TextLabel", {Text="0xC76B", Font=Enum.Font.GothamBlack, TextSize=12, TextColor3=_H.acc, TextXAlignment=Enum.TextXAlignment.Left, BackgroundTransparency=1, Position=UDim2.fromOffset(10,0), Size=UDim2.new(0, 50, 1, 0), ZIndex=3, Parent=_tb})
    _N("TextLabel", {Text="| Hub Edition", Font=Enum.Font.GothamBold, TextSize=9, TextColor3=_H.sub, TextXAlignment=Enum.TextXAlignment.Left, BackgroundTransparency=1, Position=UDim2.fromOffset(60,0), Size=UDim2.new(1,-120,1,0), ZIndex=3, Parent=_tb})

    local function _btn(t, xOff)
        local b = _N("TextButton", {Text=t, Font=Enum.Font.GothamBold, TextSize=14, TextColor3=_H.sub, BackgroundColor3=_H.row, AutoButtonColor=false, Size=UDim2.fromOffset(24,24), Position=UDim2.new(1,xOff,0.5,-12), ZIndex=3, Parent=_tb})
        _N("UICorner", {CornerRadius=UDim.new(0,4), Parent=b})
        return b
    end
    local _min = _btn("—", -58)
    local _cls = _btn("×", -30)

    _RN.Heartbeat:Connect(function(dt)
        _strokeG.Rotation = (_strokeG.Rotation + dt * 60) % 360
    end)

    _cls.MouseButton1Click:Connect(function()
        local tw = _TW:Create(_M, _F, {Size=UDim2.fromOffset(0,0)})
        tw:Play(); tw.Completed:Wait(); _g:Destroy()
    end)

    local _dr, _ds, _dp = false, nil, nil
    _tb.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            _dr = true; _ds = i.Position; _dp = _M.Position
            i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then _dr = false end end)
        end
    end)
    _UI.InputChanged:Connect(function(i)
        if _dr and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - _ds
            _M.Position = UDim2.new(_dp.X.Scale, _dp.X.Offset + d.X, _dp.Y.Scale, _dp.Y.Offset + d.Y)
        end
    end)

    _B = _N("Frame", {Size=UDim2.new(0, _SW, 1, -(_TH+16)), Position=UDim2.fromOffset(6, _TH+6), BackgroundColor3=_H.panel, BorderSizePixel=0, ZIndex=2, Parent=_M})
    _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=_B})
    _N("UIListLayout", {Padding=UDim.new(0,6), HorizontalAlignment=Enum.HorizontalAlignment.Center, SortOrder=Enum.SortOrder.LayoutOrder, Parent=_B})
    _N("UIPadding", {PaddingTop=UDim.new(0,10), Parent=_B})

    _C = _N("Frame", {Size=UDim2.new(1, -(_SW+24), 1, -(_TH+16)), Position=UDim2.fromOffset(_SW+16, _TH+6), BackgroundTransparency=1, ZIndex=2, Parent=_M})

    local _mi = false
    _min.MouseButton1Click:Connect(function()
        _mi = not _mi
        if _mi then
            _C.Visible = false; _B.Visible = false; _min.Text = "+"
            _TW:Create(_M, _F, {Size=UDim2.fromOffset(_WW, _TH+8)}):Play()
        else
            _TW:Create(_M, _F, {Size=UDim2.fromOffset(_WW, _WH)}):Play()
            task.wait(0.2)
            _C.Visible = true; _B.Visible = true; _min.Text = "—"
        end
    end)
end

local function _sel(name)
    for _k, o in pairs(_T) do
        o._p.Visible = (_k == name)
        o._s.Transparency = (_k == name) and 1 or 0.5
        o._s.Color = (_k == name) and o._col or _H.str
        o._i.TextColor3 = (_k == name) and o._col or _H.sub
    end
    _A = name
end

function _GU.tab(name, color, icon)
    if _T[name] then return _T[name] end
    local _p = _N("ScrollingFrame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, Visible=false, Parent=_C, ScrollBarThickness=2, CanvasSize=UDim2.new(0,0,0,0), AutomaticCanvasSize=Enum.AutomaticSize.Y, ScrollingDirection=Enum.ScrollingDirection.Y})
    _N("UIListLayout", {Padding=UDim.new(0,8), SortOrder=Enum.SortOrder.LayoutOrder, Parent=_p})

    local _tb = _N("TextButton", {Size=UDim2.fromOffset(36,36), BackgroundColor3=_H.bg, Text="", AutoButtonColor=false, LayoutOrder=#_T+1, ZIndex=3, Parent=_B})
    _N("UICorner", {CornerRadius=UDim.new(0,8), Parent=_tb})
    local _s = _N("UIStroke", {Color=_H.str, Thickness=1, Transparency=0.5, Parent=_tb})
    local _i = _N("TextLabel", {Text=icon or "⚡", Font=Enum.Font.GothamBold, TextSize=20, TextColor3=_H.sub, BackgroundTransparency=1, Size=UDim2.fromScale(1,1), ZIndex=3, Parent=_tb})

    _tb.MouseButton1Click:Connect(function() _sel(name) end)

    local _api = { _p = _p, _tb = _tb, _s = _s, _i = _i, _col = color }

    function _api.button(text, cb)
        local b = _N("TextButton", {Text=text, Font=Enum.Font.GothamBold, TextSize=13, TextColor3=_H.txt, BackgroundColor3=_H.row, AutoButtonColor=false, Size=UDim2.new(1,0,0,38), ZIndex=2, Parent=_p})
        _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=b})
        _N("UIStroke", {Color=_H.str, Transparency=0.5, Parent=b})
        b.MouseButton1Click:Connect(cb)
        return b
    end

    function _api.toggle(text, def, cb)
        local b = _N("TextButton", {Text="", BackgroundColor3=_H.row, AutoButtonColor=false, Size=UDim2.new(1,0,0,38), ZIndex=2, Parent=_p})
        _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=b})
        _N("UIStroke", {Color=_H.str, Transparency=0.5, Parent=b})
        _N("TextLabel", {Text=text, Font=Enum.Font.GothamBold, TextSize=13, TextColor3=_H.txt, BackgroundTransparency=1, Position=UDim2.fromOffset(12,0), Size=UDim2.new(1,-60,1,0), TextXAlignment=Enum.TextXAlignment.Left, ZIndex=3, Parent=b})
        
        local bgInd = _N("Frame", {Size=UDim2.fromOffset(36,18), Position=UDim2.new(1,-48,0.5,-9), BackgroundColor3=def and _H.acc or Color3.fromRGB(60,70,90), ZIndex=3, Parent=b})
        _N("UICorner", {CornerRadius=UDim.new(1,0), Parent=bgInd})
        local dot = _N("Frame", {Size=UDim2.fromOffset(14,14), Position=def and UDim2.new(1,-16,0.5,-7) or UDim2.fromOffset(2,2), BackgroundColor3=Color3.new(1,1,1), ZIndex=4, Parent=bgInd})
        _N("UICorner", {CornerRadius=UDim.new(1,0), Parent=dot})
        
        local st = def
        b.MouseButton1Click:Connect(function()
            st = not st
            _TW:Create(bgInd, _F, {BackgroundColor3 = st and _H.acc or Color3.fromRGB(60,70,90)}):Play()
            _TW:Create(dot, _F, {Position = st and UDim2.new(1,-16,0.5,-7) or UDim2.fromOffset(2,2)}):Play()
            cb(st)
        end)
        return b
    end

    function _api.slider(text, min, max, def, cb)
        local b = _N("Frame", {BackgroundColor3=_H.row, Size=UDim2.new(1,0,0,46), ZIndex=2, Parent=_p})
        _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=b})
        _N("UIStroke", {Color=_H.str, Transparency=0.5, Parent=b})
        _N("TextLabel", {Text=text, Font=Enum.Font.GothamBold, TextSize=12, TextColor3=_H.txt, BackgroundTransparency=1, Position=UDim2.fromOffset(12,4), Size=UDim2.new(1,-60,0,20), TextXAlignment=Enum.TextXAlignment.Left, ZIndex=3, Parent=b})
        local vl = _N("TextLabel", {Text=tostring(def), Font=Enum.Font.GothamBlack, TextSize=12, TextColor3=_H.acc, BackgroundTransparency=1, Position=UDim2.new(1,-50,0,4), Size=UDim2.new(0,40,0,20), TextXAlignment=Enum.TextXAlignment.Right, ZIndex=3, Parent=b})
        
        local tr = _N("Frame", {Size=UDim2.new(1,-24,0,6), Position=UDim2.new(0,12,1,-14), BackgroundColor3=Color3.fromRGB(40,48,65), ZIndex=3, Parent=b})
        _N("UICorner", {CornerRadius=UDim.new(1,0), Parent=tr})
        local fl = _N("Frame", {Size=UDim2.new((def-min)/(max-min),0,1,0), BackgroundColor3=_H.acc, ZIndex=4, Parent=tr})
        _N("UICorner", {CornerRadius=UDim.new(1,0), Parent=fl})
        local thumb = _N("Frame", {Size=UDim2.fromOffset(12,12), AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.new((def-min)/(max-min),0,0.5,0), BackgroundColor3=Color3.new(1,1,1), ZIndex=5, Parent=tr})
        _N("UICorner", {CornerRadius=UDim.new(1,0), Parent=thumb})
        
        local drag = false
        local function upd(x)
            local r = math.clamp((x - tr.AbsolutePosition.X) / tr.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + (max-min)*r + 0.5)
            fl.Size = UDim2.new(r,0,1,0)
            thumb.Position = UDim2.new(r,0,0.5,0)
            vl.Text = tostring(v)
            cb(v)
        end
        tr.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true; upd(i.Position.X) end end)
        _UI.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then upd(i.Position.X) end end)
        _UI.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end end)
        return b
    end

    function _api.dropdown(text, opts, def, cb)
        local b = _N("TextButton", {Text="", BackgroundColor3=_H.row, AutoButtonColor=false, Size=UDim2.new(1,0,0,38), ZIndex=2, Parent=_p})
        _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=b})
        _N("UIStroke", {Color=_H.str, Transparency=0.5, Parent=b})
        _N("TextLabel", {Text=text, Font=Enum.Font.GothamBold, TextSize=12, TextColor3=_H.txt, BackgroundTransparency=1, Position=UDim2.fromOffset(12,0), Size=UDim2.new(0.5,0,1,0), TextXAlignment=Enum.TextXAlignment.Left, ZIndex=3, Parent=b})
        local sl = _N("TextLabel", {Text=tostring(def) .. " ▼", Font=Enum.Font.GothamBold, TextSize=11, TextColor3=_H.acc, BackgroundTransparency=1, Position=UDim2.new(0.5,0,0,0), Size=UDim2.new(0.5,-12,1,0), TextXAlignment=Enum.TextXAlignment.Right, ZIndex=3, Parent=b})
        
        local mn = _N("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundColor3=Color3.fromRGB(20,25,35), Visible=false, ZIndex=4, Parent=_p})
        _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=mn})
        _N("UIStroke", {Color=_H.acc, Transparency=0.5, Parent=mn})
        _N("UIListLayout", {Padding=UDim.new(0,4), Parent=mn})
        _N("UIPadding", {PaddingTop=UDim.new(0,4), PaddingBottom=UDim.new(0,4), Parent=mn})
        
        for _, o in ipairs(opts) do
            local ob = _N("TextButton", {Text=" " .. o, Font=Enum.Font.GothamBold, TextSize=12, TextColor3=_H.txt, BackgroundColor3=_H.row, TextXAlignment=Enum.TextXAlignment.Left, Size=UDim2.new(1,-8,0,32), ZIndex=5, Parent=mn})
            _N("UICorner", {CornerRadius=UDim.new(0,4), Parent=ob})
            ob.MouseButton1Click:Connect(function()
                sl.Text = o .. " ▼"
                mn.Visible = false
                cb(o)
            end)
        end
        
        b.MouseButton1Click:Connect(function() mn.Visible = not mn.Visible end)
        return b
    end

    _T[name] = _api
    return _api
end

function _GU.selectFirst()
    if _T["Packet"] then _sel("Packet") else local f = next(_T) if f then _sel(f) end end
end

return _GU
