--!nocheck
--[[===========================================================
    NovaUI v2.0  |  Librería de UI para Roblox / Delta
    Sintaxis propia + obfuscación suave
    GitHub: raw.githubusercontent.com/USER/NovaUI/main/NovaUI.lua
===========================================================]]
local _g   = game
local _gs  = _g.GetService
local _P   = _gs(_g,"Players")
local _U   = _gs(_g,"UserInputService")
local _T   = _gs(_g,"TweenService")
local _C   = _gs(_g,"CoreGui")
local _L   = _P.LocalPlayer

local _new  = Instance.new
local _ud2  = UDim2.new
local _udo  = UDim2.fromOffset
local _rgb  = Color3.fromRGB
local _E    = Enum
local _F    = _E.Font

--// LIBRERÍA
local N = {}
N.Flags = {}
N.Theme = {
    A   = _rgb(88,101,242),   -- Accent
    Bg  = _rgb(18,18,22),
    Bg2 = _rgb(28,28,34),
    Bg3 = _rgb(38,38,46),
    Tx  = _rgb(240,240,245),
    Sb  = _rgb(150,150,165),
    Ln  = _rgb(48,48,58),
    Er  = _rgb(237,66,69),
    Ok  = _rgb(59,165,93),
    Wn  = _rgb(250,180,65),
    Ft  = _F.GothamMedium,
}
local TH = N.Theme
local FL = N.Flags

--// PADRE SEGURO
local function _parent()
    if type(gethui)=="function" then
        local ok,r = pcall(gethui); if ok and r then return r end
    end
    local ok,r = pcall(function() return _C end)
    if ok and r then return r end
    return _L:WaitForChild("PlayerGui")
end
local function _protect(gui)
    if type(syn)=="table" and syn.protect_gui then pcall(syn.protect_gui, gui) end
    if type(protect_gui)=="function" then pcall(protect_gui, gui) end
end

--// HELPERS
local function _inst(cls,p)
    local i=_new(cls)
    for k,v in pairs(p or {}) do if k~="Parent" then i[k]=v end end
    if p and p.Parent then i.Parent=p.Parent end
    return i
end
local function _cn(p,r) return _inst("UICorner",{CornerRadius=UDim.new(0,r or 6),Parent=p}) end
local function _st(p,c,t) return _inst("UIStroke",{Color=c or TH.Ln,Thickness=t or 1,ApplyStrokeMode=_E.ApplyStrokeMode.Border,Parent=p}) end
local function _pd(p,x) return _inst("UIPadding",{PaddingTop=UDim.new(0,x),PaddingBottom=UDim.new(0,x),PaddingLeft=UDim.new(0,x),PaddingRight=UDim.new(0,x),Parent=p}) end
local function _tw(o,t,pr) local a=_T:Create(o,TweenInfo.new(t or .15,_E.EasingStyle.Quad,_E.EasingDirection.Out),pr) a:Play() return a end
local function _fk(c) return c.Flag or c.Name or ("_f"..math.random(1,1e8)) end

--=============================================================
--  MÉTODOS DE SECCIÓN
--=============================================================
local S = {}

function S:Label(txt)
    local l=_inst("TextLabel",{
        Size=_ud2(1,0,0,20), BackgroundTransparency=1,
        Text=txt or "Label", TextColor3=TH.Tx, Font=TH.Ft, TextSize=13,
        TextXAlignment=_E.TextXAlignment.Left, Parent=self.Body})
    return { Instance=l, Set=function(_,t) l.Text=t end }
end

function S:Divider()
    _inst("Frame",{Size=_ud2(1,0,0,1),BackgroundColor3=TH.Ln,BorderSizePixel=0,Parent=self.Body})
end

function S:Button(c)
    c=c or {}
    local b=_inst("TextButton",{
        Size=_ud2(1,0,0,30), BackgroundColor3=TH.Bg3,
        Text=c.Name or "Button", TextColor3=TH.Tx, Font=TH.Ft, TextSize=13,
        AutoButtonColor=false, Parent=self.Body})
    _cn(b,6)
    b.MouseEnter:Connect(function() _tw(b,.12,{BackgroundColor3=TH.A}) end)
    b.MouseLeave:Connect(function() _tw(b,.12,{BackgroundColor3=TH.Bg3}) end)
    b.InputBegan:Connect(function(i)
        if i.UserInputType==_E.UserInputType.Touch then _tw(b,.1,{BackgroundColor3=TH.A}) end
    end)
    b.InputEnded:Connect(function(i)
        if i.UserInputType==_E.UserInputType.Touch then _tw(b,.1,{BackgroundColor3=TH.Bg3}) end
    end)
    b.MouseButton1Click:Connect(function() if c.Callback then task.spawn(c.Callback) end end)
    return { Instance=b }
end

function S:Toggle(c)
    c=c or {}
    local k = _fk(c)
    local st = c.Default and true or false

    local h=_inst("Frame",{Size=_ud2(1,0,0,26),BackgroundTransparency=1,Parent=self.Body})
    _inst("TextLabel",{Size=_ud2(1,-50,1,0),BackgroundTransparency=1,Text=c.Name or "Toggle",
        TextColor3=TH.Tx,Font=TH.Ft,TextSize=13,TextXAlignment=_E.TextXAlignment.Left,Parent=h})

    local sw=_inst("TextButton",{Size=_ud2(0,36,0,18),Position=_ud2(1,-36,.5,-9),
        BackgroundColor3=st and TH.A or TH.Bg3,Text="",AutoButtonColor=false,Parent=h})
    _cn(sw,9)
    local kn=_inst("Frame",{Size=_ud2(0,14,0,14),
        Position=st and _ud2(1,-16,.5,-7) or _ud2(0,2,.5,-7),
        BackgroundColor3=TH.Tx,BorderSizePixel=0,Parent=sw})
    _cn(kn,7)

    local o={Value=st}
    local function set(v,sil)
        o.Value=v; FL[k]=v
        _tw(sw,.15,{BackgroundColor3=v and TH.A or TH.Bg3})
        _tw(kn,.15,{Position=v and _ud2(1,-16,.5,-7) or _ud2(0,2,.5,-7)})
        if not sil and c.Callback then task.spawn(c.Callback,v) end
    end
    sw.MouseButton1Click:Connect(function() set(not o.Value) end)
    function o:Set(v) set(v,true) end
    function o:Get() return o.Value end
    set(st,true)
    return o
end

function S:Slider(c)
    c=c or {}
    local k=_fk(c); local mn=c.Min or 0; local mx=c.Max or 100
    local v=c.Default or mn; local dc=c.Decimals or 0

    local h=_inst("Frame",{Size=_ud2(1,0,0,44),BackgroundTransparency=1,Parent=self.Body})
    _inst("TextLabel",{Size=_ud2(1,-60,0,18),BackgroundTransparency=1,Text=c.Name or "Slider",
        TextColor3=TH.Tx,Font=TH.Ft,TextSize=13,TextXAlignment=_E.TextXAlignment.Left,Parent=h})
    local vl=_inst("TextLabel",{Size=_ud2(0,60,0,18),Position=_ud2(1,-60,0,0),BackgroundTransparency=1,
        Text=tostring(v)..(c.Suffix or ""),TextColor3=TH.Sb,Font=TH.Ft,TextSize=13,
        TextXAlignment=_E.TextXAlignment.Right,Parent=h})

    local br=_inst("TextButton",{Size=_ud2(1,0,0,6),Position=_ud2(0,0,0,30),
        BackgroundColor3=TH.Bg3,Text="",AutoButtonColor=false,BorderSizePixel=0,Parent=h})
    _cn(br,3)
    local fl=_inst("Frame",{Size=_ud2((v-mn)/(mx-mn),0,1,0),
        BackgroundColor3=TH.A,BorderSizePixel=0,Parent=br})
    _cn(fl,3)
    local kn=_inst("Frame",{Size=_ud2(0,14,0,14),AnchorPoint=Vector2.new(.5,.5),
        Position=_ud2((v-mn)/(mx-mn),0,.5,0),BackgroundColor3=TH.Tx,BorderSizePixel=0,ZIndex=2,Parent=br})
    _cn(kn,7)

    local o={Value=v}; local drag=false
    local function commit(x)
        x=math.clamp(x,mn,mx); local r=(x-mn)/(mx-mn)
        o.Value=x; FL[k]=x
        fl.Size=_ud2(r,0,1,0); kn.Position=_ud2(r,0,.5,0)
        vl.Text=tostring(x)..(c.Suffix or "")
        if c.Callback then task.spawn(c.Callback,x) end
    end
    local function fx(x)
        local r=math.clamp((x-br.AbsolutePosition.X)/br.AbsoluteSize.X,0,1)
        local raw=mn+r*(mx-mn); local m=10^dc
        commit(math.floor(raw*m+.5)/m)
    end
    br.InputBegan:Connect(function(i)
        if i.UserInputType==_E.UserInputType.MouseButton1 or i.UserInputType==_E.UserInputType.Touch then
            drag=true; fx(i.Position.X)
        end
    end)
    _U.InputChanged:Connect(function(i)
        if drag and (i.UserInputType==_E.UserInputType.MouseMovement or i.UserInputType==_E.UserInputType.Touch) then
            fx(i.Position.X)
        end
    end)
    _U.InputEnded:Connect(function(i)
        if i.UserInputType==_E.UserInputType.MouseButton1 or i.UserInputType==_E.UserInputType.Touch then drag=false end
    end)
    function o:Set(x) commit(x) end
    function o:Get() return o.Value end
    FL[k]=v
    return o
end

function S:Dropdown(c)
    c=c or {}
    local k=_fk(c); local opts=c.Options or {}; local sel=c.Default or opts[1]

    -- contenedor para que UIListLayout no rompa el dropdown abierto
    local wrap=_inst("Frame",{Size=_ud2(1,0,0,26),BackgroundTransparency=1,Parent=self.Body})
    wrap.AutomaticSize = _E.AutomaticSize.Y

    local row=_inst("Frame",{Size=_ud2(1,0,0,26),BackgroundTransparency=1,Parent=wrap})
    _inst("TextLabel",{Size=_ud2(1,-130,1,0),BackgroundTransparency=1,Text=c.Name or "Dropdown",
        TextColor3=TH.Tx,Font=TH.Ft,TextSize=13,TextXAlignment=_E.TextXAlignment.Left,Parent=row})
    local bt=_inst("TextButton",{Size=_ud2(0,120,0,24),Position=_ud2(1,-120,.5,-12),
        BackgroundColor3=TH.Bg3,Text=" "..tostring(sel).."  ▾",TextColor3=TH.Tx,
        Font=TH.Ft,TextSize=12,TextXAlignment=_E.TextXAlignment.Left,AutoButtonColor=false,Parent=row})
    _cn(bt,5)

    local ls=_inst("ScrollingFrame",{Size=_ud2(1,0,0,0),Position=_ud2(0,0,0,28),
        BackgroundColor3=TH.Bg3,BorderSizePixel=0,Visible=false,ScrollBarThickness=2,
        ScrollBarImageColor3=TH.A,CanvasSize=_ud2(0,0,0,0),
        AutomaticCanvasSize=_E.AutomaticSize.Y,Parent=wrap})
    _cn(ls,5); _pd(ls,4)
    _inst("UIListLayout",{SortOrder=_E.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=ls})

    local o={Value=sel}
    local function set(v,sil)
        o.Value=v; FL[k]=v; bt.Text=" "..tostring(v).."  ▾"
        if not sil and c.Callback then task.spawn(c.Callback,v) end
    end
    local function build()
        for _,x in ipairs(opts) do
            local ob=_inst("TextButton",{Size=_ud2(1,0,0,22),BackgroundTransparency=1,
                Text=tostring(x),TextColor3=TH.Tx,Font=TH.Ft,TextSize=12,AutoButtonColor=true,Parent=ls})
            ob.MouseButton1Click:Connect(function()
                set(x); ls.Visible=false; ls.Size=_ud2(1,0,0,0)
                wrap.Size=_ud2(1,0,0,26)
            end)
        end
    end
    build()

    bt.MouseButton1Click:Connect(function()
        local opening=not ls.Visible
        ls.Visible=opening
        ls.Size = opening and _ud2(1,0,0,math.min(#opts*24+8,140)) or _ud2(1,0,0,0)
        wrap.Size = opening and _ud2(1,0,0,26+math.min(#opts*24+8,140)+4) or _ud2(1,0,0,26)
    end)
    function o:Set(v) set(v,true) end
    function o:Get() return o.Value end
    function o:Refresh(nw)
        opts=nw
        for _,ch in ipairs(ls:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
        build()
    end
    set(sel,true)
    return o
end

function S:Input(c)
    c=c or {}
    local k=_fk(c)
    local r=_inst("Frame",{Size=_ud2(1,0,0,26),BackgroundTransparency=1,Parent=self.Body})
    _inst("TextLabel",{Size=_ud2(1,-130,1,0),BackgroundTransparency=1,Text=c.Name or "Input",
        TextColor3=TH.Tx,Font=TH.Ft,TextSize=13,TextXAlignment=_E.TextXAlignment.Left,Parent=r})
    local bx=_inst("TextBox",{Size=_ud2(0,120,0,24),Position=_ud2(1,-120,.5,-12),
        BackgroundColor3=TH.Bg3,Text=c.Default or "",PlaceholderText=c.Placeholder or "Escribe...",
        TextColor3=TH.Tx,PlaceholderColor3=TH.Sb,Font=TH.Ft,TextSize=12,
        ClearTextOnFocus=false,Parent=r})
    _cn(bx,5)
    local o={Value=c.Default or ""}
    bx.FocusLost:Connect(function()
        o.Value=bx.Text; FL[k]=bx.Text
        if c.Callback then task.spawn(c.Callback,bx.Text) end
    end)
    function o:Set(v) bx.Text=v; o.Value=v; FL[k]=v end
    function o:Get() return o.Value end
    FL[k]=o.Value
    return o
end

function S:Keybind(c)
    c=c or {}
    local k=_fk(c); local cur=c.Default or _E.KeyCode.RightControl; local lis=false
    local r=_inst("Frame",{Size=_ud2(1,0,0,26),BackgroundTransparency=1,Parent=self.Body})
    _inst("TextLabel",{Size=_ud2(1,-100,1,0),BackgroundTransparency=1,Text=c.Name or "Keybind",
        TextColor3=TH.Tx,Font=TH.Ft,TextSize=13,TextXAlignment=_E.TextXAlignment.Left,Parent=r})
    local bt=_inst("TextButton",{Size=_ud2(0,90,0,24),Position=_ud2(1,-90,.5,-12),
        BackgroundColor3=TH.Bg3,Text=cur.Name,TextColor3=TH.Tx,Font=TH.Ft,TextSize=12,
        AutoButtonColor=false,Parent=r})
    _cn(bt,5)

    local o={Value=cur}
    bt.MouseButton1Click:Connect(function()
        lis=true; bt.Text="..."; bt.BackgroundColor3=TH.A
    end)
    _U.InputBegan:Connect(function(i,g)
        if g then return end
        if lis then
            if i.UserInputType==_E.UserInputType.Keyboard then
                cur=i.KeyCode; o.Value=cur; bt.Text=cur.Name
                bt.BackgroundColor3=TH.Bg3; lis=false; FL[k]=cur
                if c.Callback then task.spawn(c.Callback,cur) end
            end
        elseif i.KeyCode==cur then
            if c.OnPressed then task.spawn(c.OnPressed) end
        end
    end)
    FL[k]=cur
    return o
end

-- Alias cortos (sintaxis propia)
S.Btn = S.Button
S.Tg  = S.Toggle
S.Sl  = S.Slider
S.Dd  = S.Dropdown
S.In  = S.Input
S.Kb  = S.Keybind
S.Lb  = S.Label
S.Dv  = S.Divider

--=============================================================
--  VENTANA
--=============================================================
function N:CreateWindow(c)
    c=c or {}
    local parent=_parent()

    local sg=_inst("ScreenGui",{
        Name="NovaUI_"..tostring(math.random(1000,9999)),
        ResetOnSpawn=false, IgnoreGuiInset=true,
        ZIndexBehavior=_E.ZIndexBehavior.Sibling,
        DisplayOrder=999, Parent=parent})
    _protect(sg)

    N.Screens = N.Screens or {}
    table.insert(N.Screens, sg)
    N.Screen = sg

    -- Tamaño
    local w,h = 580,380
    if c.Size then
        w = c.Size.X.Offset > 0 and c.Size.X.Offset or w
        h = c.Size.Y.Offset > 0 and c.Size.Y.Offset or h
    end
    local fullSize = _udo(w,h)
    local minSize  = _udo(w,38)

    local main=_inst("Frame",{
        Name="Main", Size=fullSize,
        Position=_ud2(.5,0,.5,0), AnchorPoint=Vector2.new(.5,.5),
        BackgroundColor3=TH.Bg, BorderSizePixel=0, Parent=sg})
    _cn(main,10); _st(main,TH.Ln,1)

    -- Topbar
    local tb=_inst("Frame",{Size=_ud2(1,0,0,38),BackgroundColor3=TH.Bg2,BorderSizePixel=0,Parent=main})
    _cn(tb,10)
    _inst("Frame",{Size=_ud2(1,0,0,10),Position=_ud2(0,0,1,-10),
        BackgroundColor3=TH.Bg2,BorderSizePixel=0,Parent=tb})
    _inst("TextLabel",{Size=_ud2(1,-90,1,0),Position=_ud2(0,16,0,0),BackgroundTransparency=1,
        Text=c.Title or "NovaUI", TextColor3=TH.Tx, Font=_F.GothamBold, TextSize=15,
        TextXAlignment=_E.TextXAlignment.Left, Parent=tb})

    -- Botón MINIMIZAR
    local minB=_inst("TextButton",{Size=_ud2(0,28,0,28),Position=_ud2(1,-70,.5,-14),
        BackgroundColor3=TH.Bg3,Text="—",TextColor3=TH.Tx,Font=_F.GothamBold,TextSize=16,
        AutoButtonColor=false,Parent=tb})
    _cn(minB,6)

    -- Botón ELIMINAR/CERRAR
    local clsB=_inst("TextButton",{Size=_ud2(0,28,0,28),Position=_ud2(1,-36,.5,-14),
        BackgroundColor3=TH.Er,Text="×",TextColor3=TH.Tx,Font=_F.GothamBold,TextSize=18,
        AutoButtonColor=false,Parent=tb})
    _cn(clsB,6)

    -- Sidebar
    local sb=_inst("Frame",{Size=_ud2(0,150,1,-38),Position=_ud2(0,0,0,38),
        BackgroundColor3=TH.Bg,BorderSizePixel=0,Parent=main})
    local tl=_inst("ScrollingFrame",{Size=_ud2(1,-10,1,-10),Position=_ud2(0,5,0,5),
        BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,
        ScrollBarImageColor3=TH.A,CanvasSize=_ud2(0,0,0,0),
        AutomaticCanvasSize=_E.AutomaticSize.Y,Parent=sb})
    _inst("UIListLayout",{SortOrder=_E.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=tl})

    -- Contenido
    local ct=_inst("Frame",{Size=_ud2(1,-150,1,-38),Position=_ud2(0,150,0,38),
        BackgroundTransparency=1,Parent=main})

    -- DRAG
    local dr,ds,dp
    tb.InputBegan:Connect(function(i)
        if i.UserInputType==_E.UserInputType.MouseButton1 or i.UserInputType==_E.UserInputType.Touch then
            dr=true; ds=i.Position; dp=main.Position
        end
    end)
    _U.InputChanged:Connect(function(i)
        if dr and (i.UserInputType==_E.UserInputType.MouseMovement or i.UserInputType==_E.UserInputType.Touch) then
            local d=i.Position-ds
            main.Position=_ud2(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y)
        end
    end)
    _U.InputEnded:Connect(function(i)
        if i.UserInputType==_E.UserInputType.MouseButton1 or i.UserInputType==_E.UserInputType.Touch then dr=false end
    end)

    -- MINIMIZAR
    local min=false
    minB.MouseButton1Click:Connect(function()
        min=not min
        _tw(main,.2,{Size=min and minSize or fullSize})
    end)

    -- CERRAR
    clsB.MouseButton1Click:Connect(function()
        _tw(main,.15,{BackgroundTransparency=1})
        task.wait(.18); sg:Destroy()
        for i,v in ipairs(N.Screens) do if v==sg then table.remove(N.Screens,i) break end end
    end)

    -- Toggle con RightShift
    _U.InputBegan:Connect(function(i,g)
        if g then return end
        if i.KeyCode==_E.KeyCode.RightShift then sg.Enabled=not sg.Enabled end
    end)

    -- BOTÓN "UI" FLOTANTE A LA IZQUIERDA
    local uiB=_inst("TextButton",{
        Name="UI_Toggle",
        Size=_udo(38,38),
        Position=_ud2(0,10,.15,0),
        BackgroundColor3=TH.A,
        BackgroundTransparency=.15,
        Text="UI", TextColor3=TH.Tx,
        Font=_F.GothamBold, TextSize=13,
        AutoButtonColor=false, Parent=sg})
    _cn(uiB,19); _st(uiB,TH.Ln,1)

    uiB.MouseEnter:Connect(function() _tw(uiB,.12,{BackgroundTransparency=0}) end)
    uiB.MouseLeave:Connect(function() _tw(uiB,.12,{BackgroundTransparency=.15}) end)

    -- drag del botón UI
    local udr,uds,udp,dragMoved=false,nil,nil,false
    uiB.InputBegan:Connect(function(i)
        if i.UserInputType==_E.UserInputType.MouseButton1 or i.UserInputType==_E.UserInputType.Touch then
            udr=true; uds=i.Position; udp=uiB.Position; dragMoved=false
        end
    end)
    _U.InputChanged:Connect(function(i)
        if udr and (i.UserInputType==_E.UserInputType.MouseMovement or i.UserInputType==_E.UserInputType.Touch) then
            local d=i.Position-uds
            if d.Magnitude>4 then dragMoved=true end
            uiB.Position=_ud2(udp.X.Scale,udp.X.Offset+d.X,udp.Y.Scale,udp.Y.Offset+d.Y)
        end
    end)
    _U.InputEnded:Connect(function(i)
        if i.UserInputType==_E.UserInputType.MouseButton1 or i.UserInputType==_E.UserInputType.Touch then udr=false end
    end)
    uiB.MouseButton1Click:Connect(function()
        if not dragMoved then main.Visible=not main.Visible end
    end)

    -- API de ventana
    local W={Gui=sg, Main=main, Tabs={}, UIToggle=uiB}

    function W:CreateTab(name)
        local b=_inst("TextButton",{Size=_ud2(1,0,0,32),
            BackgroundColor3=TH.Bg,BackgroundTransparency=.4,
            Text="  "..(name or "Tab"),TextColor3=TH.Sb,
            Font=_F.GothamMedium,TextSize=13,TextXAlignment=_E.TextXAlignment.Left,
            AutoButtonColor=false,Parent=tl})
        _cn(b,6)

        local ctr=_inst("ScrollingFrame",{Size=_ud2(1,-20,1,-20),Position=_ud2(0,10,0,10),
            BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,
            ScrollBarImageColor3=TH.A,CanvasSize=_ud2(0,0,0,0),
            AutomaticCanvasSize=_E.AutomaticSize.Y,Visible=false,Parent=ct})
        _inst("UIListLayout",{SortOrder=_E.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=ctr})

        local Tb={Button=b,Container=ctr}

        b.MouseButton1Click:Connect(function()
            for _,t in ipairs(W.Tabs) do
                t.Button.BackgroundColor3=TH.Bg
                t.Button.BackgroundTransparency=.4
                t.Button.TextColor3=TH.Sb
                t.Container.Visible=false
            end
            b.BackgroundColor3=TH.A; b.BackgroundTransparency=0
            b.TextColor3=TH.Tx; ctr.Visible=true
        end)

        function Tb:CreateSection(sName)
            local sf=_inst("Frame",{Size=_ud2(1,0,0,0),BackgroundTransparency=1,Parent=ctr})
            sf.AutomaticSize=_E.AutomaticSize.Y

            _inst("TextLabel",{Size=_ud2(1,0,0,20),BackgroundTransparency=1,
                Text=sName or "Section",TextColor3=TH.Sb,Font=_F.GothamBold,
                TextSize=12,TextXAlignment=_E.TextXAlignment.Left,Parent=sf})

            local body=_inst("Frame",{Size=_ud2(1,0,0,0),Position=_ud2(0,0,0,24),
                BackgroundColor3=TH.Bg2,BorderSizePixel=0,Parent=sf})
            _cn(body,8); _st(body,TH.Ln,1); _pd(body,8)
            body.AutomaticSize=_E.AutomaticSize.Y
            _inst("UIListLayout",{SortOrder=_E.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=body})

            return setmetatable({Body=body},{__index=S})
        end

        table.insert(W.Tabs,Tb)
        if #W.Tabs==1 then
            b.BackgroundColor3=TH.A; b.BackgroundTransparency=0
            b.TextColor3=TH.Tx; ctr.Visible=true
        end
        return Tb
    end

    N.Window=W
    return W
end

-- Alias corto de ventana (sintaxis propia)
N.W = N.CreateWindow

--=============================================================
--  NOTIFICACIONES
--=============================================================
function N:Notify(c)
    c=c or {}
    local sg=N.Screen; if not sg then return end

    if not N.NotifHolder or not N.NotifHolder.Parent then
        N.NotifHolder=_inst("Frame",{Name="Notifs",
            Size=_ud2(0,280,0,400),Position=_ud2(1,-20,0,20),
            AnchorPoint=Vector2.new(1,0),BackgroundTransparency=1,Parent=sg})
        _inst("UIListLayout",{SortOrder=_E.SortOrder.LayoutOrder,Padding=UDim.new(0,8),
            HorizontalAlignment=_E.HorizontalAlignment.Right,
            VerticalAlignment=_E.VerticalAlignment.Top,Parent=N.NotifHolder})
    end

    local ac=TH.A
    if c.Type=="Success" then ac=TH.Ok
    elseif c.Type=="Warning" then ac=TH.Wn
    elseif c.Type=="Error" then ac=TH.Er end

    local cg=_inst("CanvasGroup",{Size=_udo(280,62),BackgroundTransparency=1,Parent=N.NotifHolder})
    cg.GroupTransparency=1

    local fr=_inst("Frame",{Size=_ud2(1,0,1,0),BackgroundColor3=TH.Bg2,
        BorderSizePixel=0,Parent=cg})
    _cn(fr,8); _st(fr,TH.Ln,1)

    local bar=_inst("Frame",{Size=_ud2(0,3,1,-16),Position=_ud2(0,8,0,8),
        BackgroundColor3=ac,BorderSizePixel=0,Parent=fr})
    _cn(bar,2)

    _inst("TextLabel",{Size=_ud2(1,-30,0,18),Position=_ud2(0,20,0,8),
        BackgroundTransparency=1,Text=c.Title or "Notificación",
        TextColor3=TH.Tx,Font=_F.GothamBold,TextSize=13,
        TextXAlignment=_E.TextXAlignment.Left,Parent=fr})
    _inst("TextLabel",{Size=_ud2(1,-30,0,30),Position=_ud2(0,20,0,26),
        BackgroundTransparency=1,Text=c.Content or "",
        TextColor3=TH.Sb,Font=TH.Ft,TextSize=12,TextWrapped=true,
        TextXAlignment=_E.TextXAlignment.Left,TextYAlignment=_E.TextYAlignment.Top,Parent=fr})

    _tw(cg,.28,{GroupTransparency=0})
    task.delay(c.Duration or 3,function()
        _tw(cg,.28,{GroupTransparency=1})
        task.wait(.35); cg:Destroy()
    end)
end

N.Nf = N.Notify
return N
