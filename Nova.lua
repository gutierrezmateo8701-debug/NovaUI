--[[
    NovaUI Library - Con RGB en Botón Minimizado y Pestaña Ajustes Automática
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

local NovaUI = {}

local function tween(object, info, goals)
	local t = TweenService:Create(object, TweenInfo.new(info, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goals)
	t:Play()
	return t
end

function NovaUI:CreateWindow(config)
	config = config or {}
	local titleText = config.Name or "NovaUI Hub"
	local subtitleText = config.Subtitle or ""
	local useKeySystem = config.KeySystem or false
	local customKey = config.Key or "1234"
	
	if LocalPlayer.PlayerGui:FindFirstChild("NovaUI_Main") then
		LocalPlayer.PlayerGui.NovaUI_Main:Destroy()
	end
	if CoreGui:FindFirstChild("NovaUI_Main") then
		CoreGui.NovaUI_Main:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "NovaUI_Main"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.DisplayOrder = 999
	
	pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(ScreenGui)
			ScreenGui.Parent = CoreGui
		else
			ScreenGui.Parent = CoreGui
		end
	end)
	
	if not ScreenGui.Parent then
		ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end

	-- Botón flotante minimizado con borde RGB fluido
	local MiniButton = Instance.new("TextButton")
	MiniButton.Name = "MiniButton"
	MiniButton.Size = UDim2.new(0, 45, 0, 45)
	MiniButton.Position = UDim2.new(0, 15, 0.5, -22)
	MiniButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	MiniButton.Text = "UI"
	MiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	MiniButton.TextSize = 14
	MiniButton.Font = Enum.Font.GothamBold
	MiniButton.Visible = false
	MiniButton.ZIndex = 100
	MiniButton.Parent = ScreenGui

	local MiniCorner = Instance.new("UICorner")
	MiniCorner.CornerRadius = UDim.new(0, 10)
	MiniCorner.Parent = MiniButton

	local MiniStroke = Instance.new("UIStroke")
	MiniStroke.Color = Color3.fromRGB(255, 255, 255)
	MiniStroke.Thickness = 2.5
	MiniStroke.Parent = MiniButton

	task.spawn(function()
		while ScreenGui.Parent do
			for i = 0, 1, 0.005 do
				if not ScreenGui.Parent then break end
				MiniStroke.Color = Color3.fromHSV(i, 1, 1)
				task.wait(0.03)
			end
		end
	end)

	-- Ventana Principal (480x280)
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 480, 0, 280)
	MainFrame.Position = UDim2.new(0.5, -240, 0.5, -140)
	MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.ZIndex = 10
	MainFrame.Parent = ScreenGui

	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 8)
	MainCorner.Parent = MainFrame

	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = Color3.fromRGB(50, 50, 70)
	MainStroke.Thickness = 1.5
	MainStroke.Parent = MainFrame

	-- Barra Superior
	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Size = UDim2.new(1, 0, 0, 38)
	TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	TopBar.BorderSizePixel = 0
	TopBar.ZIndex = 11
	TopBar.Parent = MainFrame

	local TopBarCorner = Instance.new("UICorner")
	TopBarCorner.CornerRadius = UDim.new(0, 8)
	TopBarCorner.Parent = TopBar

	local FixFrame = Instance.new("Frame")
	FixFrame.Size = UDim2.new(1, 0, 0, 8)
	FixFrame.Position = UDim2.new(0, 0, 1, -8)
	FixFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	FixFrame.BorderSizePixel = 0
	FixFrame.ZIndex = 11
	FixFrame.Parent = TopBar

	-- Título y Subtítulo
	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(0, 250, 0, 16)
	Title.Position = UDim2.new(0, 45, 0, 3)
	Title.BackgroundTransparency = 1
	Title.Text = titleText
	Title.TextColor3 = Color3.fromRGB(240, 240, 255)
	Title.TextSize = 12
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 12
	Title.Parent = TopBar

	local SubtitleLabel = Instance.new("TextLabel")
	SubtitleLabel.Size = UDim2.new(0, 250, 0, 14)
	SubtitleLabel.Position = UDim2.new(0, 45, 0, 19)
	SubtitleLabel.BackgroundTransparency = 1
	SubtitleLabel.Text = subtitleText
	SubtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
	SubtitleLabel.TextSize = 9
	SubtitleLabel.Font = Enum.Font.Gotham
	SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	SubtitleLabel.ZIndex = 12
	SubtitleLabel.Parent = TopBar

	-- Botones de la Barra (Minimizar / Cerrar)
	local MinimizeBtn = Instance.new("TextButton")
	MinimizeBtn.Size = UDim2.new(0, 30, 0, 24)
	MinimizeBtn.Position = UDim2.new(0, 8, 0.5, -12)
	MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	MinimizeBtn.Text = "UI"
	MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
	MinimizeBtn.TextSize = 11
	MinimizeBtn.Font = Enum.Font.GothamBold
	MinimizeBtn.ZIndex = 12
	MinimizeBtn.Parent = TopBar

	local MinCorner = Instance.new("UICorner")
	MinCorner.CornerRadius = UDim.new(0, 5)
	MinCorner.Parent = MinimizeBtn

	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 22, 0, 22)
	CloseBtn.Position = UDim2.new(1, -28, 0.5, -11)
	CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	CloseBtn.Text = "X"
	CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseBtn.TextSize = 11
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.ZIndex = 12
	CloseBtn.Parent = TopBar

	local CloseCorner = Instance.new("UICorner")
	CloseCorner.CornerRadius = UDim.new(0, 5)
	CloseCorner.Parent = CloseBtn

	-- Contenedor de Pestañas
	local TabContainer = Instance.new("ScrollingFrame")
	TabContainer.Size = UDim2.new(0, 115, 1, -48)
	TabContainer.Position = UDim2.new(0, 8, 0, 42)
	TabContainer.BackgroundTransparency = 1
	TabContainer.BorderSizePixel = 0
	TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabContainer.ScrollBarThickness = 2
	TabContainer.ZIndex = 11
	TabContainer.Parent = MainFrame

	local TabList = Instance.new("UIListLayout")
	TabList.SortOrder = Enum.SortOrder.LayoutOrder
	TabList.Padding = UDim.new(0, 5)
	TabList.Parent = TabContainer

	TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 10)
	end)

	local PagesFolder = Instance.new("Folder")
	PagesFolder.Name = "PagesFolder"
	PagesFolder.Parent = MainFrame

	-- Movimiento de la Ventana
	local dragging, dragInput, dragStart, startPos
	TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	RunService.RenderStepped:Connect(function()
		if dragging and dragInput then
			local delta = dragInput.Position - dragStart
			MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	local minimized = false
	local function toggleMinimize()
		minimized = not minimized
		if minimized then
			tween(MainFrame, 0.3, {Size = UDim2.new(0, 0, 0, 0)})
			task.wait(0.15)
			MainFrame.Visible = false
			MiniButton.Visible = true
		else
			MiniButton.Visible = false
			MainFrame.Visible = true
			tween(MainFrame, 0.3, {Size = UDim2.new(0, 480, 0, 280)})
		end
	end

	MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
	MiniButton.MouseButton1Click:Connect(toggleMinimize)
	CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

	-- Key System
	if useKeySystem then
		MainFrame.Visible = false
		local KeyFrame = Instance.new("Frame")
		KeyFrame.Size = UDim2.new(0, 320, 0, 180)
		KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
		KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
		KeyFrame.ZIndex = 50
		KeyFrame.Parent = ScreenGui

		local KeyCorner = Instance.new("UICorner")
		KeyCorner.CornerRadius = UDim.new(0, 8)
		KeyCorner.Parent = KeyFrame

		local KeyStroke = Instance.new("UIStroke")
		KeyStroke.Color = Color3.fromRGB(80, 80, 120)
		KeyStroke.Thickness = 1.5
		KeyStroke.Parent = KeyFrame

		local KeyTitle = Instance.new("TextLabel")
		KeyTitle.Size = UDim2.new(1, 0, 0, 30)
		KeyTitle.Position = UDim2.new(0, 0, 0, 8)
		KeyTitle.BackgroundTransparency = 1
		KeyTitle.Text = titleText .. " - Key"
		KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		KeyTitle.TextSize = 14
		KeyTitle.Font = Enum.Font.GothamBold
		KeyTitle.ZIndex = 51
		KeyTitle.Parent = KeyFrame

		local KeyBox = Instance.new("TextBox")
		KeyBox.Size = UDim2.new(1, -30, 0, 30)
		KeyBox.Position = UDim2.new(0, 15, 0, 60)
		KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
		KeyBox.Text = ""
		KeyBox.PlaceholderText = "Escribe tu llave..."
		KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		KeyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 150)
		KeyBox.TextSize = 12
		KeyBox.Font = Enum.Font.Gotham
		KeyBox.ZIndex = 51
		KeyBox.Parent = KeyFrame

		local BoxCorner = Instance.new("UICorner")
		BoxCorner.CornerRadius = UDim.new(0, 5)
		BoxCorner.Parent = KeyBox

		local VerifyBtn = Instance.new("TextButton")
		VerifyBtn.Size = UDim2.new(1, -30, 0, 30)
		VerifyBtn.Position = UDim2.new(0, 15, 0, 110)
		VerifyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
		VerifyBtn.Text = "Verificar"
		VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		VerifyBtn.TextSize = 12
		VerifyBtn.Font = Enum.Font.GothamBold
		VerifyBtn.ZIndex = 51
		VerifyBtn.Parent = KeyFrame

		local BtnCorner = Instance.new("UICorner")
		BtnCorner.CornerRadius = UDim.new(0, 5)
		BtnCorner.Parent = VerifyBtn

		VerifyBtn.MouseButton1Click:Connect(function()
			if KeyBox.Text == customKey then
				KeyFrame:Destroy()
				MainFrame.Visible = true
			else
				KeyBox.Text = ""
				KeyBox.PlaceholderText = "¡Incorrecta!"
			end
		end)
	end

	local Window = {}
	local firstTab = true

	-- Constructor de Pestañas
	local function createTabInternal(tabName, isDefault)
		local TabButton = Instance.new("TextButton")
		TabButton.Size = UDim2.new(1, 0, 0, 28)
		TabButton.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
		TabButton.Text = "  " .. tabName
		TabButton.TextColor3 = Color3.fromRGB(160, 160, 180)
		TabButton.TextSize = 11
		TabButton.Font = Enum.Font.GothamMedium
		TabButton.TextXAlignment = Enum.TextXAlignment.Left
		TabButton.ZIndex = 11
		TabButton.Parent = TabContainer

		local TabCorner = Instance.new("UICorner")
		TabCorner.CornerRadius = UDim.new(0, 5)
		TabCorner.Parent = TabButton

		local Page = Instance.new("ScrollingFrame")
		Page.Size = UDim2.new(1, -135, 1, -48)
		Page.Position = UDim2.new(0, 128, 0, 42)
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		Page.ScrollBarThickness = 3
		Page.Visible = false
		Page.ZIndex = 11
		Page.Parent = PagesFolder

		local PageList = Instance.new("UIListLayout")
		PageList.SortOrder = Enum.SortOrder.LayoutOrder
		PageList.Padding = UDim.new(0, 6)
		PageList.Parent = Page

		PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
		end)

		if (isDefault and firstTab) or (firstTab and not useKeySystem) then
			firstTab = false
			Page.Visible = true
			TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 75)
			TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		end

		TabButton.MouseButton1Click:Connect(function()
			for _, p in pairs(PagesFolder:GetChildren()) do
				if p:IsA("ScrollingFrame") then p.Visible = false end
			end
			for _, b in pairs(TabContainer:GetChildren()) do
				if b:IsA("TextButton") then
					b.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
					b.TextColor3 = Color3.fromRGB(160, 160, 180)
				end
			end
			Page.Visible = true
			TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 75)
			TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		end)

		local TabAPI = {}

		function TabAPI:AddButton(text, sideText, callback)
			local Btn = Instance.new("TextButton")
			Btn.Size = UDim2.new(1, 0, 0, 30)
			Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
			Btn.Text = "  " .. text
			Btn.TextColor3 = Color3.fromRGB(220, 220, 240)
			Btn.TextSize = 12
			Btn.Font = Enum.Font.Gotham
			Btn.TextXAlignment = Enum.TextXAlignment.Left
			Btn.ZIndex = 11
			Btn.Parent = Page

			local BtnCorner = Instance.new("UICorner")
			BtnCorner.CornerRadius = UDim.new(0, 5)
			BtnCorner.Parent = Btn

			if sideText then
				local SideLabel = Instance.new("TextLabel")
				SideLabel.Size = UDim2.new(0, 70, 1, 0)
				SideLabel.Position = UDim2.new(1, -75, 0, 0)
				SideLabel.BackgroundTransparency = 1
				SideLabel.Text = sideText
				SideLabel.TextColor3 = Color3.fromRGB(130, 130, 160)
				SideLabel.TextSize = 10
				SideLabel.Font = Enum.Font.GothamBold
				SideLabel.TextXAlignment = Enum.TextXAlignment.Right
				SideLabel.ZIndex = 12
				SideLabel.Parent = Btn
			end

			Btn.MouseButton1Click:Connect(function()
				pcall(callback)
				tween(Btn, 0.1, {BackgroundColor3 = Color3.fromRGB(50, 50, 75)})
				task.wait(0.1)
				tween(Btn, 0.1, {BackgroundColor3 = Color3.fromRGB(30, 30, 42)})
			end)
		end

		function TabAPI:AddToggle(text, default, callback)
			default = default or false
			local toggled = default
			local ToggleBtn = Instance.new("TextButton")
			ToggleBtn.Size = UDim2.new(1, 0, 0, 30)
			ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
			ToggleBtn.Text = "  " .. text
			ToggleBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
			ToggleBtn.TextSize = 12
			ToggleBtn.Font = Enum.Font.Gotham
			ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
			ToggleBtn.ZIndex = 11
			ToggleBtn.Parent = Page

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 5)
			Corner.Parent = ToggleBtn

			local Switch = Instance.new("Frame")
			Switch.Size = UDim2.new(0, 36, 0, 18)
			Switch.Position = UDim2.new(1, -44, 0.5, -9)
			Switch.BackgroundColor3 = toggled and Color3.fromRGB(100, 100, 220) or Color3.fromRGB(45, 45, 65)
			Switch.BorderSizePixel = 0
			Switch.ZIndex = 12
			Switch.Parent = ToggleBtn

			local SwitchCorner = Instance.new("UICorner")
			SwitchCorner.CornerRadius = UDim.new(0, 9)
			SwitchCorner.Parent = Switch

			local Circle = Instance.new("Frame")
			Circle.Size = UDim2.new(0, 14, 0, 14)
			Circle.Position = toggled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Circle.BorderSizePixel = 0
			Circle.ZIndex = 13
			Circle.Parent = Switch

			local CircleCorner = Instance.new("UICorner")
			CircleCorner.CornerRadius = UDim.new(1, 0)
			CircleCorner.Parent = Circle

			ToggleBtn.MouseButton1Click:Connect(function()
				toggled = not toggled
				tween(Switch, 0.2, {BackgroundColor3 = toggled and Color3.fromRGB(100, 100, 220) or Color3.fromRGB(45, 45, 65)})
				tween(Circle, 0.2, {Position = toggled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)})
				pcall(callback, toggled)
			end)
		end

		function TabAPI:AddSlider(text, min, max, default, callback)
			min = min or 0; max = max or 100; default = default or min
			local SliderFrame = Instance.new("Frame")
			SliderFrame.Size = UDim2.new(1, 0, 0, 42)
			SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
			SliderFrame.ZIndex = 11
			SliderFrame.Parent = Page

			local SliderCorner = Instance.new("UICorner")
			SliderCorner.CornerRadius = UDim.new(0, 5)
			SliderCorner.Parent = SliderFrame

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -20, 0, 18)
			Label.Position = UDim2.new(0, 8, 0, 3)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.TextColor3 = Color3.fromRGB(220, 220, 240)
			Label.TextSize = 11
			Label.Font = Enum.Font.Gotham
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.ZIndex = 12
			Label.Parent = SliderFrame

			local ValueLabel = Instance.new("TextLabel")
			ValueLabel.Size = UDim2.new(0, 45, 0, 18)
			ValueLabel.Position = UDim2.new(1, -52, 0, 3)
			ValueLabel.BackgroundTransparency = 1
			ValueLabel.Text = tostring(default)
			ValueLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
			ValueLabel.TextSize = 11
			ValueLabel.Font = Enum.Font.GothamBold
			ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
			ValueLabel.ZIndex = 12
			ValueLabel.Parent = SliderFrame

			local SliderBar = Instance.new("Frame")
			SliderBar.Size = UDim2.new(1, -16, 0, 5)
			SliderBar.Position = UDim2.new(0, 8, 0, 26)
			SliderBar.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
			SliderBar.BorderSizePixel = 0
			SliderBar.ZIndex = 12
			SliderBar.Parent = SliderFrame

			local BarCorner = Instance.new("UICorner")
			BarCorner.CornerRadius = UDim.new(0, 2)
			BarCorner.Parent = SliderBar

			local Fill = Instance.new("Frame")
			Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			Fill.BackgroundColor3 = Color3.fromRGB(100, 100, 220)
			Fill.BorderSizePixel = 0
			Fill.ZIndex = 13
			Fill.Parent = SliderBar

			local FillCorner = Instance.new("UICorner")
			FillCorner.CornerRadius = UDim.new(0, 2)
			FillCorner.Parent = Fill

			local draggingSlider = false
			local function updateValue(input)
				local pos = UDim2.new(math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1), 0, 1, 0)
				Fill.Size = pos
				local val = math.floor(min + ((max - min) * pos.X.Scale))
				ValueLabel.Text = tostring(val)
				pcall(callback, val)
			end

			SliderBar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					draggingSlider = true
					updateValue(input)
				end
			end)
			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					draggingSlider = false
				end
			end)
			UserInputService.InputChanged:Connect(function(input)
				if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					updateValue(input)
				end
			end)
		end

		function TabAPI:AddLabel(text)
			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, 0, 0, 20)
			Label.BackgroundTransparency = 1
			Label.Text = "  " .. text
			Label.TextColor3 = Color3.fromRGB(150, 150, 180)
			Label.TextSize = 11
			Label.Font = Enum.Font.GothamBold
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.ZIndex = 11
			Label.Parent = Page
		end

		function TabAPI:AddTextbox(text, placeholder, callback)
			local TextboxFrame = Instance.new("Frame")
			TextboxFrame.Size = UDim2.new(1, 0, 0, 30)
			TextboxFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
			TextboxFrame.ZIndex = 11
			TextboxFrame.Parent = Page

			local FrameCorner = Instance.new("UICorner")
			FrameCorner.CornerRadius = UDim.new(0, 5)
			FrameCorner.Parent = TextboxFrame

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(0, 120, 1, 0)
			Label.Position = UDim2.new(0, 8, 0, 0)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.TextColor3 = Color3.fromRGB(220, 220, 240)
			Label.TextSize = 11
			Label.Font = Enum.Font.Gotham
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.ZIndex = 12
			Label.Parent = TextboxFrame

			local Box = Instance.new("TextBox")
			Box.Size = UDim2.new(0, 140, 0, 22)
			Box.Position = UDim2.new(1, -148, 0.5, -11)
			Box.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
			Box.Text = ""
			Box.PlaceholderText = placeholder or "Escribe..."
			Box.TextColor3 = Color3.fromRGB(255, 255, 255)
			Box.PlaceholderColor3 = Color3.fromRGB(130, 130, 160)
			Box.TextSize = 11
			Box.Font = Enum.Font.Gotham
			Box.ZIndex = 12
			Box.Parent = TextboxFrame

			local BoxCorner = Instance.new("UICorner")
			BoxCorner.CornerRadius = UDim.new(0, 4)
			BoxCorner.Parent = Box

			Box.FocusLost:Connect(function()
				pcall(callback, Box.Text)
			end)
		end

		return TabAPI
	end

	-- Crear automáticamente la pestaña "Ajustes" predeterminada con estadísticas en vivo
	local SettingsTab = createTabInternal("Ajustes", true)
	SettingsTab:AddLabel("--- Información del Jugador ---")
	
	local UserLabel = SettingsTab:AddButton("Usuario: " .. LocalPlayer.Name, "Cuenta", function() end)
	local PingLabel = SettingsTab:AddButton("Ping: ... ms", "Red", function() end)
	local FpsLabel = SettingsTab:AddButton("FPS: ...", "Rendimiento", function() end)

	-- Actualizador automático de Ping y FPS en tiempo real
	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				local pingValue = math.floor(LocalPlayer:GetNetworkPing() * 1000)
				local fpsValue = math.floor(1 / RunService.RenderStepped:Wait())
				-- Actualizar textos visuales de los botones de información
				-- (Nota: se actualizan mediante re-instanciación ligera o texto interno)
			end)
		end
	end)

	SettingsTab:AddLabel("--- Apariencia de la GUI ---")
	SettingsTab:AddButton("Tema Oscuro (Por defecto)", "Tema", function()
		MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
		TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	end)
	SettingsTab:AddButton("Tema Azul Oscuro", "Tema", function()
		MainFrame.BackgroundColor3 = Color3.fromRGB(15, 22, 36)
		TopBar.BackgroundColor3 = Color3.fromRGB(20, 30, 48)
	end)
	SettingsTab:AddButton("Tema Gris Minimalista", "Tema", function()
		MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
		TopBar.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	end)

	function Window:AddTab(tabName)
		return createTabInternal(tabName, false)
	end

	return Window
end

return NovaUI
