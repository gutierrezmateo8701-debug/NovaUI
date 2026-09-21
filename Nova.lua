--[[
    NovaUI Library - Versión Completa (Pestañas, Sliders, Horizontal)
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local NovaUI = {}

local function tween(object, info, goals)
	local t = TweenService:Create(object, TweenInfo.new(info, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goals)
	t:Play()
	return t
end

function NovaUI:Create(config)
	config = config or {}
	local titleText = config.Name or "NovaUI Hub"
	
	if LocalPlayer.PlayerGui:FindFirstChild("NovaUI_Main") then
		LocalPlayer.PlayerGui.NovaUI_Main:Destroy()
	end
	if CoreGui:FindFirstChild("NovaUI_Main") then
		CoreGui.NovaUI_Main:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "NovaUI_Main"
	ScreenGui.ResetOnSpawn = false
	
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

	-- Botón flotante minimizado ("UI" Izquierda)
	local MiniButton = Instance.new("TextButton")
	MiniButton.Name = "MiniButton"
	MiniButton.Size = UDim2.new(0, 50, 0, 50)
	MiniButton.Position = UDim2.new(0, 20, 0.5, -25)
	MiniButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	MiniButton.Text = "UI"
	MiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	MiniButton.TextSize = 16
	MiniButton.Font = Enum.Font.GothamBold
	MiniButton.Visible = false
	MiniButton.ZIndex = 10
	MiniButton.Parent = ScreenGui

	local MiniCorner = Instance.new("UICorner")
	MiniCorner.CornerRadius = UDim.new(0, 12)
	MiniCorner.Parent = MiniButton

	local MiniStroke = Instance.new("UIStroke")
	MiniStroke.Color = Color3.fromRGB(80, 80, 120)
	MiniStroke.Thickness = 2
	MiniStroke.Parent = MiniButton

	-- Ventana Principal (Gui acostada / Ancha: 580x340)
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 580, 0, 340)
	MainFrame.Position = UDim2.new(0.5, -290, 0.5, -170)
	MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.ZIndex = 5
	MainFrame.Parent = ScreenGui

	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 8)
	MainCorner.Parent = MainFrame

	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = Color3.fromRGB(50, 50, 70)
	MainStroke.Thickness = 1.5
	MainStroke.Parent = MainFrame

	-- Barra Superior (Topbar)
	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Size = UDim2.new(1, 0, 0, 40)
	TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	TopBar.BorderSizePixel = 0
	TopBar.ZIndex = 6
	TopBar.Parent = MainFrame

	local TopBarCorner = Instance.new("UICorner")
	TopBarCorner.CornerRadius = UDim.new(0, 8)
	TopBarCorner.Parent = TopBar

	local FixFrame = Instance.new("Frame")
	FixFrame.Size = UDim2.new(1, 0, 0, 10)
	FixFrame.Position = UDim2.new(0, 0, 1, -10)
	FixFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	FixFrame.BorderSizePixel = 0
	FixFrame.ZIndex = 6
	FixFrame.Parent = TopBar

	-- Título
	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(0, 200, 1, 0)
	Title.Position = UDim2.new(0, 55, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Text = titleText
	Title.TextColor3 = Color3.fromRGB(240, 240, 255)
	Title.TextSize = 14
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 7
	Title.Parent = TopBar

	-- Botón Minimizar "UI" (Izquierda)
	local MinimizeBtn = Instance.new("TextButton")
	MinimizeBtn.Size = UDim2.new(0, 35, 0, 26)
	MinimizeBtn.Position = UDim2.new(0, 10, 0.5, -13)
	MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	MinimizeBtn.Text = "UI"
	MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
	MinimizeBtn.TextSize = 12
	MinimizeBtn.Font = Enum.Font.GothamBold
	MinimizeBtn.ZIndex = 7
	MinimizeBtn.Parent = TopBar

	local MinCorner = Instance.new("UICorner")
	MinCorner.CornerRadius = UDim.new(0, 6)
	MinCorner.Parent = MinimizeBtn

	-- Botón Eliminar / Cerrar (Derecha)
	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 26, 0, 26)
	CloseBtn.Position = UDim2.new(1, -35, 0.5, -13)
	CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	CloseBtn.Text = "X"
	CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseBtn.TextSize = 12
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.ZIndex = 7
	CloseBtn.Parent = TopBar

	local CloseCorner = Instance.new("UICorner")
	CloseCorner.CornerRadius = UDim.new(0, 6)
	CloseCorner.Parent = CloseBtn

	-- Contenedor de Pestañas (Lateral Izquierdo)
	local TabContainer = Instance.new("ScrollingFrame")
	TabContainer.Size = UDim2.new(0, 130, 1, -55)
	TabContainer.Position = UDim2.new(0, 10, 0, 45)
	TabContainer.BackgroundTransparency = 1
	TabContainer.BorderSizePixel = 0
	TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabContainer.ScrollBarThickness = 2
	TabContainer.ZIndex = 6
	TabContainer.Parent = MainFrame

	local TabList = Instance.new("UIListLayout")
	TabList.SortOrder = Enum.SortOrder.LayoutOrder
	TabList.Padding = UDim.new(0, 6)
	TabList.Parent = TabContainer

	TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 10)
	end)

	-- Contenedor de Páginas (Derecha)
	local PagesFolder = Instance.new("Folder")
	PagesFolder.Name = "PagesFolder"
	PagesFolder.Parent = MainFrame

	-- Arrastrar ventana
	local dragging, dragInput, dragStart, startPos
	TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	game:GetService("RunService").RenderStepped:Connect(function()
		if dragging and dragInput then
			local delta = dragInput.Position - dragStart
			MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	-- Minimizar / Restaurar
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
			tween(MainFrame, 0.3, {Size = UDim2.new(0, 580, 0, 340)})
		end
	end

	MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
	MiniButton.MouseButton1Click:Connect(toggleMinimize)

	-- Eliminar
	CloseBtn.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	-- API de Pestañas y Componentes
	local Window = {}
	local firstTab = true

	function Window:AddTab(tabName)
		local TabButton = Instance.new("TextButton")
		TabButton.Size = UDim2.new(1, 0, 0, 32)
		TabButton.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
		TabButton.Text = "  " .. tabName
		TabButton.TextColor3 = Color3.fromRGB(160, 160, 180)
		TabButton.TextSize = 12
		TabButton.Font = Enum.Font.GothamMedium
		TabButton.TextXAlignment = Enum.TextXAlignment.Left
		TabButton.ZIndex = 6
		TabButton.Parent = TabContainer

		local TabCorner = Instance.new("UICorner")
		TabCorner.CornerRadius = UDim.new(0, 6)
		TabCorner.Parent = TabButton

		-- Página de contenido para esta pestaña
		local Page = Instance.new("ScrollingFrame")
		Page.Size = UDim2.new(1, -155, 1, -55)
		Page.Position = UDim2.new(0, 150, 0, 45)
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		Page.ScrollBarThickness = 4
		Page.Visible = false
		Page.ZIndex = 6
		Page.Parent = MainFrame

		local PageList = Instance.new("UIListLayout")
		PageList.SortOrder = Enum.SortOrder.LayoutOrder
		PageList.Padding = UDim.new(0, 8)
		PageList.Parent = Page

		PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
		end)

		if firstTab then
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

		-- Botón con etiqueta al costado derecho ("Button")
		function TabAPI:AddButton(text, sideText, callback)
			local Btn = Instance.new("TextButton")
			Btn.Size = UDim2.new(1, 0, 0, 35)
			Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
			Btn.Text = "  " .. text
			Btn.TextColor3 = Color3.fromRGB(220, 220, 240)
			Btn.TextSize = 13
			Btn.Font = Enum.Font.Gotham
			Btn.TextXAlignment = Enum.TextXAlignment.Left
			Btn.ZIndex = 6
			Btn.Parent = Page

			local BtnCorner = Instance.new("UICorner")
			BtnCorner.CornerRadius = UDim.new(0, 6)
			BtnCorner.Parent = Btn

			if sideText then
				local SideLabel = Instance.new("TextLabel")
				SideLabel.Size = UDim2.new(0, 80, 1, 0)
				SideLabel.Position = UDim2.new(1, -85, 0, 0)
				SideLabel.BackgroundTransparency = 1
				SideLabel.Text = sideText
				SideLabel.TextColor3 = Color3.fromRGB(130, 130, 160)
				SideLabel.TextSize = 11
				SideLabel.Font = Enum.Font.GothamBold
				SideLabel.TextXAlignment = Enum.TextXAlignment.Right
				SideLabel.ZIndex = 7
				SideLabel.Parent = Btn
			end

			Btn.MouseButton1Click:Connect(function()
				pcall(callback)
				tween(Btn, 0.1, {BackgroundColor3 = Color3.fromRGB(50, 50, 75)})
				task.wait(0.1)
				tween(Btn, 0.1, {BackgroundColor3 = Color3.fromRGB(30, 30, 42)})
			end)
		end

		-- Slider
		function TabAPI:AddSlider(text, min, max, default, callback)
			min = min or 0
			max = max or 100
			default = default or min

			local SliderFrame = Instance.new("Frame")
			SliderFrame.Size = UDim2.new(1, 0, 0, 50)
			SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
			SliderFrame.ZIndex = 6
			SliderFrame.Parent = Page

			local SliderCorner = Instance.new("UICorner")
			SliderCorner.CornerRadius = UDim.new(0, 6)
			SliderCorner.Parent = SliderFrame

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -20, 0, 22)
			Label.Position = UDim2.new(0, 10, 0, 4)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.TextColor3 = Color3.fromRGB(220, 220, 240)
			Label.TextSize = 12
			Label.Font = Enum.Font.Gotham
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.ZIndex = 7
			Label.Parent = SliderFrame

			local ValueLabel = Instance.new("TextLabel")
			ValueLabel.Size = UDim2.new(0, 50, 0, 22)
			ValueLabel.Position = UDim2.new(1, -60, 0, 4)
			ValueLabel.BackgroundTransparency = 1
			ValueLabel.Text = tostring(default)
			ValueLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
			ValueLabel.TextSize = 12
			ValueLabel.Font = Enum.Font.GothamBold
			ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
			ValueLabel.ZIndex = 7
			ValueLabel.Parent = SliderFrame

			local SliderBar = Instance.new("Frame")
			SliderBar.Size = UDim2.new(1, -20, 0, 6)
			SliderBar.Position = UDim2.new(0, 10, 0, 32)
			SliderBar.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
			SliderBar.BorderSizePixel = 0
			SliderBar.ZIndex = 7
			SliderBar.Parent = SliderFrame

			local BarCorner = Instance.new("UICorner")
			BarCorner.CornerRadius = UDim.new(0, 3)
			BarCorner.Parent = SliderBar

			local Fill = Instance.new("Frame")
			Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			Fill.BackgroundColor3 = Color3.fromRGB(100, 100, 220)
			Fill.BorderSizePixel = 0
			Fill.ZIndex = 8
			Fill.Parent = SliderBar

			local FillCorner = Instance.new("UICorner")
			FillCorner.CornerRadius = UDim.new(0, 3)
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

			return TabAPI
		end

		return TabAPI
	end

	return Window
end

return NovaUI
