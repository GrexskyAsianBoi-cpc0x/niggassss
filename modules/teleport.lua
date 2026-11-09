local _M = {}

function _M.init(_s)
    local _t = _s.modules.gui.tab("Teleport", "rbxassetid://6031091051")
    
    local _l = Instance.new("TextLabel")
    _l.Size = UDim2.new(1, 0, 1, 0)
    _l.BackgroundTransparency = 1
    _l.Text = "Coming Soon..."
    _l.TextColor3 = Color3.fromRGB(135,155,200)
    _l.Font = Enum.Font.GothamBold
    _l.TextSize = 16
    _l.TextTransparency = 0.3
    _l.Parent = _t._p
end

return _M 
