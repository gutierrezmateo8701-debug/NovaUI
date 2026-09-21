--[[
    NovaUI Library - Creado desde cero
    Sintaxis limpia y moderna
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local NovaUI = {}
NovaUI.__index = visuals or {}

-- Función para animaciones rápidas
local function tween(object, info, goals)
	local t = TweenService:Create(object, TweenInfo.new(info, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goals)
	t:Play()
	return t
end

function NovaUI:Create(config)
	config = config or {}
	local titleText = config.Name or "NovaUI Hub"
	
	-- ScreenGui Principal
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "NovaUI_Main"
	ScreenGui.ResetOnSpawn = false
	
	-- Protección para ejecutores si está disponible
	if syn and syn.protect_gui then
		syn.protect_gui(ScreenGui)
		ScreenGui.Parent = CoreGui
	else
		pcall(function()
			ScreenGui.Parent = CoreGui
		end)
	end
	if not ScreenGui.Parent then
		ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	end

	-- Botón flotante cuando está minimizado (Gui chica / "UI" Izquierda)
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
	MiniButton.Parent = ScreenGui

	local MiniCorner = Instance.new("UICorner")
	MiniCorner.CornerRadius = UDim.new(0, 12)
	MiniCorner.Parent = MiniButton

	local MiniStroke = Instance.new("UIStroke")
	MiniStroke.Color = Color3.fromRGB(80, 80, 120)
	MiniStroke.Thickness = 2
	MiniStroke.Parent = MiniButton

	-- Ventana Principal
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 480, 0, 320)
	MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
	MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
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
	TopBar.BorderSizePixel = E
	TopBar.Parent = MainFrame

	local TopBarCorner = Instance.new("UICorner")
	TopBarCorner.CornerRadius = UDim.new(0, 8)
	TopBarCorner.Parent = TopBar

	-- Arreglar esquinas inferiores del TopBar para que sean rectas
	local FixFrame = Instance.new("Frame")
	FixFrame.Size = UDim2.new(1, 0, 0, 10)
	FixFrame.Position = UDim2.new(0, 0, 1, -10)
	FixFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	FixFrame.BorderSizePixel = 0
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
	CloseBtn.Parent = TopBar

	local CloseCorner = Instance.new("UICorner")
	CloseCorner.CornerRadius = UDim.new(0, 6)
	CloseCorner.Parent = CloseBtn

	-- Contenedor de Contenido
	local Container = Instance.new("ScrollingFrame")
	Container.Size = UDim2.new(1, -20, 1, -55)
	Container.Position = UDim2.new(0, 10, 0, 45)
	Container.BackgroundTransparency = 1
	Container.BorderSizePixel = 0
	Container.CanvasSize = UDim2.new(0, 0, 0, 0)
	Container.ScrollBarThickness = 4
	Container.Parent = MainFrame

	local UIList = Instance.new("UIListLayout")
	UIList.SortOrder = Enum.SortOrder.LayoutOrder
	UIList.Padding = UDim.new(0, 8)
	UIList.Parent = Container

	UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Container.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
	end)

	-- Sistema de arrastre (Dragging)
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

	-- Animación y Lógica de Minimizar / Restaurar
	local minimized = false
	local function toggleMinimize()
		minimized = not minimized
		if minimized then
			tween(MainFrame, 0.3, {Size = UDim2.new(0, 0, 0, 0), Transparency = 1})
			task.wait(0.15)
			MainFrame.Visible = false
			MiniButton.Visible = true
			tween(MiniButton, 0.3, {Size = UDim2.new(0, 50, 0, 50)})
		else
			MiniButton.Visible = false
			MainFrame.Visible = true
			tween(MainFrame, 0.3, {Size = UDim2.new(0, 480, 0, 320), Transparency = 0})
		end
	end

	MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
	MiniButton.MouseButton1Click:Connect(toggleMinimize)

	-- Lógica de Eliminar (Cerrar completamente)
	CloseBtn.MouseButton1Click:Connect(function()
		tween(MainFrame, 0.2, {Size = UDim2.new(0, 0, 0, 0)})
		task.wait(0.2)
		ScreenGui:Destroy()
	end)

	-- API de Componentes para la ventana
	local Window = {}

	function Window:AddButton(text, callback)
		local Btn = Instance.new("TextButton")
		Btn.Size = UDim2.new(1, 0, 0, 35)
		Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
		Btn.Text = "  " .. text
		Btn.TextColor3 = Color3.fromRGB(220, 220, 240)
		Btn.TextSize = 13
		Btn.Font = Enum.Font.Gotham
		Btn.TextXAlignment = Enum.TextXAlignment.Left
		Btn.Parent = Container

		local BtnCorner = Instance.new("UICorner")
		BtnCorner.CornerRadius = UDim.new(0, 6)
		BtnCorner.Parent = Btn

		Btn.MouseButton1Click:Connect(function()
			pcall(callback)
			-- Animación de clic
			tween(Btn, 0.1, {BackgroundColor3 = Color3.fromRGB(50, 50, 75)})
			task.wait(0.1)
			tween(Btn, 0.1, {BackgroundColor3 = Color3.fromRGB(30, 30, 42)})
		end)
	end

	return Window
end

return NovaUI
