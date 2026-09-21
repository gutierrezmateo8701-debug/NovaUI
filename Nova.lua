-- =================================================================
-- LIBRERÍA CUSTOM: WindUI Clone (Framework Base)
-- =================================================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local WindUI = {}
WindUI.Themes = {
    Dark = {
        Background = Color3.fromRGB(18, 18, 22),
        Sidebar = Color3.fromRGB(24, 24, 30),
        Card = Color3.fromRGB(30, 30, 38),
        Text = Color3.fromRGB(240, 240, 245),
        Accent = Color3.fromRGB(0, 170, 255),
    },
    Light = {
        Background = Color3.fromRGB(245, 245, 250),
        Sidebar = Color3.fromRGB(230, 230, 235),
        Card = Color3.fromRGB(255, 255, 255),
        Text = Color3.fromRGB(30, 30, 35),
        Accent = Color3.fromRGB(0, 120, 215),
    }
}
WindUI.CurrentTheme = WindUI.Themes.Dark

-- Sistema de Notificaciones Globales
function WindUI:Notify(data)
    local screenGui = CoreGui:FindFirstChild("WindUINotifications")
    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "WindUINotifications"
        screenGui.Parent = CoreGui
    end

    local notifyFrame = Instance.new("Frame")
    notifyFrame.Size = UDim2.new(0, 280, 0, 70)
    notifyFrame.Position = UDim2.new(1, -300, 1, -90)
    notifyFrame.BackgroundColor3 = WindUI.CurrentTheme.Card
    notifyFrame.BorderSizePixel = 0
    notifyFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notifyFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = WindUI.CurrentTheme.Text
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Text = data.Title or "Notificación"
    titleLabel.Parent = notifyFrame

    local contentLabel = Instance.new("TextLabel")
    contentLabel.Size = UDim2.new(1, -20, 0, 35)
    contentLabel.Position = UDim2.new(0, 10, 0, 30)
    contentLabel.BackgroundTransparency = 1
    contentLabel.TextColor3 = WindUI.CurrentTheme.Text
    contentLabel.TextSize = 12
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextWrapped = true
    contentLabel.Text = data.Content or ""
    contentLabel.Parent = notifyFrame

    task.delay(data.Duration or 3, function()
        notifyFrame:Destroy()
    end)
end

-- =================================================================
-- CREACIÓN DE VENTANA (WINDOW)
-- =================================================================
function WindUI:CreateWindow(config)
    local Window = {}
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WindUI_Window"
    screenGui.Parent = CoreGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = config.Size or UDim2.fromOffset(600, 450)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
    mainFrame.BackgroundColor3 = WindUI.CurrentTheme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame

    -- Barra superior
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.BackgroundColor3 = WindUI.CurrentTheme.Sidebar
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame

    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 10)
    topCorner.Parent = topBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 300, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = WindUI.CurrentTheme.Text
    titleLabel.TextSize = 15
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Text = config.Title or "WindUI Panel"
    titleLabel.Parent = topBar

    -- Contenedor de Pestañas (Sidebar Izquierdo)
    local sidebar = Instance.new("ScrollingFrame")
    sidebar.Size = UDim2.new(0, 160, 1, -40)
    sidebar.Position = UDim2.new(0, 0, 0, 40)
    sidebar.BackgroundColor3 = WindUI.CurrentTheme.Sidebar
    sidebar.BorderSizePixel = 0
    sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sidebar.Parent = mainFrame

    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Padding = UDim.new(0, 5)
    sidebarLayout.Parent = sidebar

    -- Contenedor de Contenido Principal (Derecho)
    local containerHolder = Instance.new("Frame")
    containerHolder.Size = UDim2.new(1, -160, 1, -40)
    containerHolder.Position = UDim2.new(0, 160, 0, 40)
    containerHolder.BackgroundTransparency = 1
    containerHolder.Parent = mainFrame

    -- Manejo de Visibilidad con ToggleKey
    if config.ToggleKey then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if input.KeyCode == config.ToggleKey then
                mainFrame.Visible = not mainFrame.Visible
            end
        end)
    end

    -- Método para crear Diálogos
    function Window:Dialog(dialogConfig)
        local dialogOverlay = Instance.new("Frame")
        dialogOverlay.Size = UDim2.new(1, 0, 1, 0)
        dialogOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        dialogOverlay.BackgroundTransparency = 0.5
        dialogOverlay.Parent = mainFrame

        local dialogBox = Instance.new("Frame")
        dialogBox.Size = UDim2.fromOffset(300, 150)
        dialogBox.Position = UDim2.new(0.5, -150, 0.5, -75)
        dialogBox.BackgroundColor3 = WindUI.CurrentTheme.Card
        dialogBox.BorderSizePixel = 0
        dialogBox.Parent = dialogOverlay

        local dCorner = Instance.new("UICorner")
        dCorner.CornerRadius = UDim.new(0, 8)
        dCorner.Parent = dialogBox

        local dTitle = Instance.new("TextLabel")
        dTitle.Size = UDim2.new(1, -20, 0, 30)
        dTitle.Position = UDim2.new(0, 10, 0, 10)
        dTitle.BackgroundTransparency = 1
        dTitle.TextColor3 = WindUI.CurrentTheme.Text
        dTitle.TextSize = 14
        dTitle.Font = Enum.Font.GothamBold
        dTitle.Text = dialogConfig.Title or "Diálogo"
        dTitle.Parent = dialogBox

        local dContent = Instance.new("TextLabel")
        dContent.Size = UDim2.new(1, -20, 0, 50)
        dContent.Position = UDim2.new(0, 10, 0, 40)
        dContent.BackgroundTransparency = 1
        dContent.TextColor3 = WindUI.CurrentTheme.Text
        dContent.TextSize = 12
        dContent.Font = Enum.Font.Gotham
        dContent.TextWrapped = true
        dContent.Text = dialogConfig.Content or ""
        dContent.Parent = dialogBox

        if dialogConfig.Buttons then
            local btnX = 10
            for _, btnInfo in ipairs(dialogConfig.Buttons) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.fromOffset(130, 30)
                btn.Position = UDim2.new(0, btnX, 1, -40)
                btn.BackgroundColor3 = WindUI.CurrentTheme.Accent
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.TextSize = 12
                btn.Font = Enum.Font.GothamBold
                btn.Text = btnInfo.Title or "Botón"
                btn.Parent = dialogBox

                local bCorner = Instance.new("UICorner")
                bCorner.CornerRadius = UDim.new(0, 6)
                bCorner.Parent = btn

                btn.MouseButton1Click:Connect(function()
                    if btnInfo.Callback then btnInfo.Callback() end
                    dialogOverlay:Destroy()
                end)
                btnX = btnX + 140
            end
        end
    end

    -- Creación de Pestañas (Tabs)
    function Window:Tab(tabConfig)
        local Tab = {}

        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, -10, 0, 35)
        tabButton.Position = UDim2.new(0, 5, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        tabButton.BackgroundTransparency = 1
        tabButton.TextColor3 = WindUI.CurrentTheme.Text
        tabButton.TextSize = 13
        tabButton.Font = Enum.Font.GothamMedium
        tabButton.Text = "  " .. (tabConfig.Title or "Pestaña")
        tabButton.TextXAlignment = Enum.TextXAlignment.Left
        tabButton.Parent = sidebar

        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tabContent.Parent = containerHolder

        local tabLayout = Instance.new("UIListLayout")
        tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabLayout.Padding = UDim.new(0, 8)
        tabLayout.Parent = tabContent

        tabButton.MouseButton1Click:Connect(function()
            for _, child in ipairs(containerHolder:GetChildren()) do
                if child:IsA("ScrollingFrame") then child.Visible = false end
            end
            tabContent.Visible = true
        end)

        -- Creación de Secciones dentro de la Pestaña
        function Tab:Section(secConfig)
            local Section = {}

            local secFrame = Instance.new("Frame")
            secFrame.Size = UDim2.new(1, -20, 0, 30)
            secFrame.BackgroundTransparency = 1
            secFrame.Parent = tabContent

            local secTitle = Instance.new("TextLabel")
            secTitle.Size = UDim2.new(1, 0, 1, 0)
            secTitle.BackgroundTransparency = 1
            secTitle.TextColor3 = WindUI.CurrentTheme.Accent
            secTitle.TextSize = 13
            secTitle.Font = Enum.Font.GothamBold
            secTitle.TextXAlignment = Enum.TextXAlignment.Left
            secTitle.Text = secConfig.Title or "Sección"
            secTitle.Parent = secFrame

            -- 3.1 Paragraph Element
            function Section:Paragraph(pConfig)
                local pFrame = Instance.new("Frame")
                pFrame.Size = UDim2.new(1, -20, 0, 55)
                pFrame.BackgroundColor3 = WindUI.CurrentTheme.Card
                pFrame.BorderSizePixel = 0
                pFrame.Parent = tabContent

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = pFrame

                local title = Instance.new("TextLabel")
                title.Size = UDim2.new(1, -15, 0, 20)
                title.Position = UDim2.new(0, 10, 0, 5)
                title.BackgroundTransparency = 1
                title.TextColor3 = WindUI.CurrentTheme.Text
                title.TextSize = 13
                title.Font = Enum.Font.GothamBold
                title.TextXAlignment = Enum.TextXAlignment.Left
                title.Text = pConfig.Title or ""
                title.Parent = pFrame

                local desc = Instance.new("TextLabel")
                desc.Size = UDim2.new(1, -15, 0, 25)
                desc.Position = UDim2.new(0, 10, 0, 25)
                desc.BackgroundTransparency = 1
                desc.TextColor3 = WindUI.CurrentTheme.Text
                desc.TextSize = 11
                desc.Font = Enum.Font.Gotham
                desc.TextXAlignment = Enum.TextXAlignment.Left
                desc.TextWrapped = true
                desc.Text = pConfig.Content or ""
                desc.Parent = pFrame
            end

            -- 3.2 Button Element
            function Section:Button(bConfig)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -20, 0, 35)
                btn.BackgroundColor3 = WindUI.CurrentTheme.Card
                btn.TextColor3 = WindUI.CurrentTheme.Text
                btn.TextSize = 12
                btn.Font = Enum.Font.GothamMedium
                btn.Text = "  " .. (bConfig.Title or "Botón")
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.Parent = tabContent

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = btn

                btn.MouseButton1Click:Connect(function()
                    if bConfig.Callback then bConfig.Callback() end
                end)
            end

            -- 3.3 Toggle Element
            function Section:Toggle(tConfig)
                local tFrame = Instance.new("Frame")
                tFrame.Size = UDim2.new(1, -20, 0, 35)
                tFrame.BackgroundColor3 = WindUI.CurrentTheme.Card
                tFrame.Parent = tabContent

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = tFrame

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -60, 1, 0)
                label.Position = UDim2.new(0, 10, 0, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = WindUI.CurrentTheme.Text
                label.TextSize = 12
                label.Font = Enum.Font.GothamMedium
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Text = tConfig.Title or "Toggle"
                label.Parent = tFrame

                local switch = Instance.new("TextButton")
                switch.Size = UDim2.fromOffset(40, 20)
                switch.Position = UDim2.new(1, -50, 0.5, -10)
                switch.BackgroundColor3 = tConfig.Default and WindUI.CurrentTheme.Accent or Color3.fromRGB(60, 60, 70)
                switch.Text = ""
                switch.Parent = tFrame

                local sCorner = Instance.new("UICorner")
                sCorner.CornerRadius = UDim.new(1, 0)
                sCorner.Parent = switch

                local state = tConfig.Default or false
                switch.MouseButton1Click:Connect(function()
                    state = not state
                    switch.BackgroundColor3 = state and WindUI.CurrentTheme.Accent or Color3.fromRGB(60, 60, 70)
                    if tConfig.Callback then tConfig.Callback(state) end
                end)
            end

            -- 3.4 Slider Element
            function Section:Slider(sConfig)
                local sFrame = Instance.new("Frame")
                sFrame.Size = UDim2.new(1, -20, 0, 50)
                sFrame.BackgroundColor3 = WindUI.CurrentTheme.Card
                sFrame.Parent = tabContent

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = sFrame

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -20, 0, 25)
                label.Position = UDim2.new(0, 10, 0, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = WindUI.CurrentTheme.Text
                label.TextSize = 12
                label.Font = Enum.Font.GothamMedium
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Text = (sConfig.Title or "Slider") .. ": " .. tostring(sConfig.Default or 50)
                label.Parent = sFrame

                local bar = Instance.new("Frame")
                bar.Size = UDim2.new(1, -20, 0, 6)
                bar.Position = UDim2.new(0, 10, 0, 32)
                bar.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                bar.Parent = sFrame

                local fill = Instance.new("Frame")
                fill.Size = UDim2.new(0.5, 0, 1, 0)
                fill.BackgroundColor3 = WindUI.CurrentTheme.Accent
                fill.Parent = bar
                
                -- Lógica simplificada de Slider interactivo
                local dragging = false
                bar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                        fill.Size = UDim2.new(pos, 0, 1, 0)
                        local val = math.floor(sConfig.Min + (sConfig.Max - sConfig.Min) * pos)
                        label.Text = (sConfig.Title or "Slider") .. ": " .. tostring(val)
                        if sConfig.Callback then sConfig.Callback(val) end
                    end
                end)
            end

            -- 3.5 Dropdown Element
            function Section:Dropdown(dConfig)
                local dBtn = Instance.new("TextButton")
                dBtn.Size = UDim2.new(1, -20, 0, 35)
                dBtn.BackgroundColor3 = WindUI.CurrentTheme.Card
                dBtn.TextColor3 = WindUI.CurrentTheme.Text
                dBtn.TextSize = 12
                dBtn.Font = Enum.Font.GothamMedium
                dBtn.Text = "  " .. (dConfig.Title or "Dropdown") .. ": " .. tostring(dConfig.Default or "")
                dBtn.TextXAlignment = Enum.TextXAlignment.Left
                dBtn.Parent = tabContent

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = dBtn

                dBtn.MouseButton1Click:Connect(function()
                    -- Rotación cíclica básica de valores para simulación compacta
                    if dConfig.Values and #dConfig.Values > 0 then
                        local currentVal = dConfig.Default
                        local nextVal = dConfig.Values[1]
                        for i, v in ipairs(dConfig.Values) do
                            if v == currentVal and dConfig.Values[i+1] then
                                nextVal = dConfig.Values[i+1]
                                break
                            end
                        end
                        dConfig.Default = nextVal
                        dBtn.Text = "  " .. (dConfig.Title or "Dropdown") .. ": " .. tostring(nextVal)
                        if dConfig.Callback then dConfig.Callback(nextVal) end
                    end
                end)
            end

            -- 3.6 ColorPicker Element
            function Section:ColorPicker(cConfig)
                local cBtn = Instance.new("TextButton")
                cBtn.Size = UDim2.new(1, -20, 0, 35)
                cBtn.BackgroundColor3 = WindUI.CurrentTheme.Card
                cBtn.TextColor3 = WindUI.CurrentTheme.Text
                cBtn.TextSize = 12
                cBtn.Font = Enum.Font.GothamMedium
                cBtn.Text = "  " .. (cConfig.Title or "ColorPicker")
                cBtn.TextXAlignment = Enum.TextXAlignment.Left
                cBtn.Parent = tabContent

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = cBtn

                local colorPreview = Instance.new("Frame")
                colorPreview.Size = UDim2.fromOffset(20, 20)
                colorPreview.Position = UDim2.new(1, -30, 0.5, -10)
                colorPreview.BackgroundColor3 = cConfig.Default or Color3.new(1,1,1)
                colorPreview.Parent = cBtn

                cBtn.MouseButton1Click:Connect(function()
                    if cConfig.Callback then cConfig.Callback(colorPreview.BackgroundColor3) end
                end)
            end

            -- 3.7 Keybind Element
            function Section:Keybind(kConfig)
                local kBtn = Instance.new("TextButton")
                kBtn.Size = UDim2.new(1, -20, 0, 35)
                kBtn.BackgroundColor3 = WindUI.CurrentTheme.Card
                kBtn.TextColor3 = WindUI.CurrentTheme.Text
                kBtn.TextSize = 12
                kBtn.Font = Enum.Font.GothamMedium
                kBtn.Text = "  " .. (kConfig.Title or "Keybind") .. " [" .. tostring(kConfig.Default.Name) .. "]"
                kBtn.TextXAlignment = Enum.TextXAlignment.Left
                kBtn.Parent = tabContent

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = kBtn

                kBtn.MouseButton1Click:Connect(function()
                    kBtn.Text = "  Presiona una tecla..."
                    local connection
                    connection = UserInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            kBtn.Text = "  " .. (kConfig.Title or "Keybind") .. " [" .. tostring(input.KeyCode.Name) .. "]"
                            if kConfig.Callback then kConfig.Callback(input.KeyCode) end
                            connection:Disconnect()
                        end
                    end)
                end)
            end

            -- 3.8 Input (Textbox) Element
            function Section:Input(iConfig)
                local iFrame = Instance.new("Frame")
                iFrame.Size = UDim2.new(1, -20, 0, 35)
                iFrame.BackgroundColor3 = WindUI.CurrentTheme.Card
                iFrame.Parent = tabContent

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = iFrame

                local textBox = Instance.new("TextBox")
                textBox.Size = UDim2.new(1, -20, 1, 0)
                textBox.Position = UDim2.new(0, 10, 0, 0)
                textBox.BackgroundTransparency = 1
                textBox.TextColor3 = WindUI.CurrentTheme.Text
                textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
                textBox.PlaceholderText = iConfig.Placeholder or "Escribe aquí..."
                textBox.TextSize = 12
                textBox.Font = Enum.Font.GothamMedium
                textBox.TextXAlignment = Enum.TextXAlignment.Left
                textBox.Text = ""
                textBox.Parent = iFrame

                textBox.FocusLost:Connect(function(enterPressed)
                    if iConfig.Callback then iConfig.Callback(textBox.Text) end
                end)
            end

            return Section
        end

        return Tab
    end

    return Window
end

return WindUI
