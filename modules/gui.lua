local _G = {}
local _S, _M, _C, _B
local _T = {}
local _A

local _R = game:GetService("RunService")
local _W = game:GetService("TweenService")
local _I = game:GetService("UserInputService")

local _H = {
    bg = Color3.fromRGB(6,11,28), panel = Color3.fromRGB(10,19,46), row = Color3.fromRGB(14,27,62),
    acc = Color3.fromRGB(58,118,255), acc2 = Color3.fromRGB(125,195,255),
    bad = Color3.fromRGB(240,90,110), txt = Color3.fromRGB(230,238,255), 
    sub = Color3.fromRGB(135,155,200), str = Color3.fromRGB(28,48,108),
}
local _F = TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local function _N(c, p, ch)
    local i = Instance.new(c)
    for k, v in pairs(p or {}) do i[k] = v end
    for _, x in ipairs(ch or {}) do x.Parent = i end
    return i
end

function _G.init(shared)
    _S = shared
    local _g = Instance.new("ScreenGui")
    _g.Name = "Grexsky_" .. math.random(1000, 9999)
    _g.ResetOnSpawn = false
    _g.IgnoreGuiInset = true
    pcall(function() _g.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
    if not _g.Parent then _g.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end

    local _WW, _WH, _TH, _SW = 360, 280, 34, 48
    _M = _N("Frame", {
        Name="Main", Size=UDim2.fromOffset(0,0), Position=UDim2.new(0.5,-_WW/2,0.5,-_WH/2),
        BackgroundColor3=_H.bg, BorderSizePixel=0, ClipsDescendants=true, Parent=_g})
    _N("UICorner", {CornerRadius=UDim.new(0,8), Parent=_M})

    local _bg = _N("Frame", {Size=UDim2.fromScale(1,1), BackgroundColor3=Color3.new(1,1,1), BorderSizePixel=0, ZIndex=0, Parent=_M})
    _N("UICorner", {CornerRadius=UDim.new(0,8), Parent=_bg})
    _N("UIGradient", {Color=ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(3,7,20)), ColorSequenceKeypoint.new(1, Color3.fromRGB(13,30,76))}, Rotation=90, Parent=_bg})

    local _ol = _N("UIStroke", {Color=Color3.new(1,1,1), Thickness=1.2, ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Parent=_M})
    local _olg = _N("UIGradient", {Color=ColorSequence.new{ColorSequenceKeypoint.new(0, _H.acc), ColorSequenceKeypoint.new(0.3, Color3.new(1,1,1)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(8,16,44)), ColorSequenceKeypoint.new(1, _H.acc)}, Parent=_ol})

    _W:Create(_M, TweenInfo.new(0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size=UDim2.fromOffset(_WW, _WH)}):Play()

    local _tb = _N("Frame", {Size=UDim2.new(1,-8,0,26), Position=UDim2.fromOffset(4,4), BackgroundColor3=_H.panel, BackgroundTransparency=0.1, BorderSizePixel=0, ZIndex=2, Parent=_M})
    _N("UICorner", {CornerRadius=UDim.new(0,5), Parent=_tb})
    
    local _tt = _N("TextLabel", {Text="0xC76B", Font=Enum.Font.GothamBlack, TextSize=11, TextColor3=Color3.new(1,1,1), TextXAlignment=Enum.TextXAlignment.Left, BackgroundTransparency=1, Position=UDim2.fromOffset(8,0), Size=UDim2.new(0, 45, 1, 0), ZIndex=3, Parent=_tb})
    local _ttg = _N("UIGradient", {Color=ColorSequence.new{ColorSequenceKeypoint.new(0, _H.acc2), ColorSequenceKeypoint.new(1, _H.acc)}, Parent=_tt})
    
    local _mb = _N("TextLabel", {Text="| Made By Skiee China boi", Font=Enum.Font.GothamBold, TextSize=8, TextColor3=Color3.new(1,1,1), TextXAlignment=Enum.TextXAlignment.Left, BackgroundTransparency=1, Position=UDim2.fromOffset(52,0), Size=UDim2.new(1,-100,1,0), ZIndex=3, Parent=_tb})
    local _mbg = _N("UIGradient", {Color=ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))}, Parent=_mb})

    local function _btn(t, xOff)
        local b = _N("TextButton", {Text=t, Font=Enum.Font.GothamBold, TextSize=14, TextColor3=_H.sub, BackgroundColor3=_H.row, AutoButtonColor=false, Size=UDim2.fromOffset(24,24), Position=UDim2.new(1,xOff,0.5,-12), ZIndex=3, Parent=_tb})
        _N("UICorner", {CornerRadius=UDim.new(0,4), Parent=b})
        return b
    end
    local _min = _btn("—", -56)
    local _cls = _btn("×", -28)

    _R.Heartbeat:Connect(function(dt)
        _olg.Rotation = (_olg.Rotation + dt * 140) % 360
        _ttg.Rotation = (_ttg.Rotation + dt * 90) % 360
        _mbg.Offset = Vector2.new((_mbg.Offset.X + dt * 0.15) % 1, 0)
    end)

    _cls.MouseButton1Click:Connect(function()
        local tw = _W:Create(_M, _F, {Size=UDim2.fromOffset(0,0)})
        tw:Play(); tw.Completed:Wait(); _g:Destroy()
    end)

    local _dr, _ds, _dp = false, nil, nil
    _tb.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            _dr = true; _ds = i.Position; _dp = _M.Position
            i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then _dr = false end end)
        end
    end)
    _I.InputChanged:Connect(function(i)
        if _dr and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - _ds
            _M.Position = UDim2.new(_dp.X.Scale, _dp.X.Offset + d.X, _dp.Y.Scale, _dp.Y.Offset + d.Y)
        end
    end)

    _B = _N("Frame", {Size=UDim2.new(0, _SW, 1, -(_TH+14)), Position=UDim2.fromOffset(6, _TH+6), BackgroundColor3=_H.panel, BorderSizePixel=0, ZIndex=2, Parent=_M})
    _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=_B})
    _N("UIListLayout", {Padding=UDim.new(0,6), HorizontalAlignment=Enum.HorizontalAlignment.Center, SortOrder=Enum.SortOrder.LayoutOrder, Parent=_B})
    _N("UIPadding", {PaddingTop=UDim.new(0,8), Parent=_B})

    _C = _N("Frame", {Size=UDim2.new(1, -(_SW+18), 1, -(_TH+14)), Position=UDim2.fromOffset(_SW+12, _TH+6), BackgroundTransparency=1, ZIndex=2, Parent=_M})

    local _mi = false
    _min.MouseButton1Click:Connect(function()
        _mi = not _mi
        if _mi then
            _C.Visible = false; _B.Visible = false; _min.Text = "+"
            _W:Create(_M, _F, {Size=UDim2.fromOffset(_WW, _TH+8)}):Play()
        else
            _W:Create(_M, _F, {Size=UDim2.fromOffset(_WW, _WH)}):Play()
            task.wait(0.15)
            _C.Visible = true; _B.Visible = true; _min.Text = "—"
        end
    end)
end

local function _sel(name)
    for _k, o in pairs(_T) do
        o._p.Visible = (_k == name)
        o._s.Color = (_k == name) and _H.acc or _H.str
        o._s.Thickness = (_k == name) and 2 or 1
        o._i.ImageColor3 = (_k == name) and _H.txt or _H.sub
    end
    _A = name
end

function _G.tab(name, icon)
    if _T[name] then return _T[name] end
    local _p = _N("ScrollingFrame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, Visible=false, Parent=_C, ScrollBarThickness=2, CanvasSize=UDim2.new(0,0,0,0), AutomaticCanvasSize=Enum.AutomaticSize.Y})
    _N("UIListLayout", {Padding=UDim.new(0,6), SortOrder=Enum.SortOrder.LayoutOrder, Parent=_p})

    local _tb = _N("TextButton", {Size=UDim2.fromOffset(36,36), BackgroundColor3=_H.bg, Text="", AutoButtonColor=false, LayoutOrder=#_T+1, ZIndex=3, Parent=_B})
    _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=_tb})
    local _s = _N("UIStroke", {Color=_H.str, Thickness=1, Parent=_tb})
    local _i = _N("ImageLabel", {Size=UDim2.fromOffset(22,22), Position=UDim2.fromScale(0.5,0.5), AnchorPoint=Vector2.new(0.5,0.5), BackgroundTransparency=1, Image=icon, ImageColor3=_H.sub, ZIndex=3, Parent=_tb})

    _tb.MouseButton1Click:Connect(function() _sel(name) end)

    local _api = { _p = _p, _tb = _tb, _s = _s, _i = _i }

    function _api.button(text, cb)
        local b = _N("TextButton", {Text=text, Font=Enum.Font.GothamBlack, TextSize=13, TextColor3=Color3.new(1,1,1), BackgroundColor3=_H.row, AutoButtonColor=false, Size=UDim2.new(1,0,0,36), ZIndex=2, Parent=_p})
        _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=b})
        b.MouseButton1Click:Connect(cb)
        return b
    end

    function _api.toggle(text, def, cb)
        local b = _N("TextButton", {Text="", BackgroundColor3=_H.row, AutoButtonColor=false, Size=UDim2.new(1,0,0,36), ZIndex=2, Parent=_p})
        _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=b})
        _N("TextLabel", {Text=text, Font=Enum.Font.GothamBlack, TextSize=12, TextColor3=Color3.new(1,1,1), BackgroundTransparency=1, Position=UDim2.fromOffset(10,0), Size=UDim2.new(1,-50,1,0), TextXAlignment=Enum.TextXAlignment.Left, Parent=b})
        
        local ind = _N("Frame", {Size=UDim2.fromOffset(30,14), Position=UDim2.new(1,-40,0.5,-7), BackgroundColor3=def and _H.acc or Color3.fromRGB(50,50,58), Parent=b})
        _N("UICorner", {CornerRadius=UDim.new(1,0), Parent=ind})
        
        local st = def
        b.MouseButton1Click:Connect(function()
            st = not st
            ind.BackgroundColor3 = st and _H.acc or Color3.fromRGB(50,50,58)
            cb(st)
        end)
        return b
    end

    function _api.slider(text, min, max, def, cb)
        local b = _N("TextButton", {Text="", BackgroundColor3=_H.row, AutoButtonColor=false, Size=UDim2.new(1,0,0,40), ZIndex=2, Parent=_p})
        _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=b})
        _N("TextLabel", {Text=text, Font=Enum.Font.GothamBlack, TextSize=11, TextColor3=Color3.new(1,1,1), BackgroundTransparency=1, Position=UDim2.fromOffset(10,2), Size=UDim2.new(1,-50,0,20), TextXAlignment=Enum.TextXAlignment.Left, Parent=b})
        local vl = _N("TextLabel", {Text=tostring(def), Font=Enum.Font.GothamBold, TextSize=11, TextColor3=_H.acc, BackgroundTransparency=1, Position=UDim2.new(1,-50,0,2), Size=UDim2.new(0,40,0,20), TextXAlignment=Enum.TextXAlignment.Right, Parent=b})
        
        local tr = _N("Frame", {Size=UDim2.new(1,-20,0,4), Position=UDim2.new(0,10,1,-10), BackgroundColor3=Color3.fromRGB(50,50,58), Parent=b})
        _N("UICorner", {CornerRadius=UDim.new(1,0), Parent=tr})
        local fl = _N("Frame", {Size=UDim2.new((def-min)/(max-min),0,1,0), BackgroundColor3=_H.acc, Parent=tr})
        _N("UICorner", {CornerRadius=UDim.new(1,0), Parent=fl})
        
        local drag = false
        local function upd(x)
            local r = math.clamp((x - tr.AbsolutePosition.X) / tr.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + (max-min)*r + 0.5)
            fl.Size = UDim2.new(r,0,1,0)
            vl.Text = tostring(v)
            cb(v)
        end
        tr.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true; upd(i.Position.X) end end)
        _I.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then upd(i.Position.X) end end)
        _I.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end end)
        return b
    end

    function _api.dropdown(text, opts, def, cb)
        local b = _N("TextButton", {Text="", BackgroundColor3=_H.row, AutoButtonColor=false, Size=UDim2.new(1,0,0,36), ZIndex=2, Parent=_p})
        _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=b})
        _N("TextLabel", {Text=text, Font=Enum.Font.GothamBlack, TextSize=12, TextColor3=Color3.new(1,1,1), BackgroundTransparency=1, Position=UDim2.fromOffset(10,0), Size=UDim2.new(0.5,0,1,0), TextXAlignment=Enum.TextXAlignment.Left, Parent=b})
        local sl = _N("TextLabel", {Text=tostring(def), Font=Enum.Font.GothamBold, TextSize=11, TextColor3=_H.acc, BackgroundTransparency=1, Position=UDim2.new(0.5,0,0,0), Size=UDim2.new(0.5,-10,1,0), TextXAlignment=Enum.TextXAlignment.Right, Parent=b})
        
        local mn = _N("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundColor3=Color3.fromRGB(20,20,25), Visible=false, Parent=_p})
        _N("UICorner", {CornerRadius=UDim.new(0,6), Parent=mn})
        _N("UIListLayout", {Padding=UDim.new(0,2), Parent=mn})
        
        for _, o in ipairs(opts) do
            local ob = _N("TextButton", {Text=o, Font=Enum.Font.Gotham, TextSize=11, TextColor3=_H.txt, BackgroundColor3=_H.row, Size=UDim2.new(1,0,0,28), Parent=mn})
            _N("UICorner", {CornerRadius=UDim.new(0,4), Parent=ob})
            ob.MouseButton1Click:Connect(function()
                sl.Text = o
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

function _G.selectFirst()
    if _T["Packet"] then _sel("Packet") else local f = next(_T) if f then _sel(f) end end
end

return _G
