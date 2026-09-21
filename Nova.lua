--[[
    NovaUI Library - Ofuscado
]]
local _U={script=function(...) return ... end}
(function(v1, v2, v3)
	local v4 = game:GetService(v1[1])
	local v5 = game:GetService(v1[2])
	local v6 = game:GetService(v1[3])
	local v7 = game:GetService(v1[4])
	local v8 = game:GetService(v1[5])
	local v9 = v8.LocalPlayer
	local v10 = {}
	local function v11(v12, v13, v14)
		local v15 = v4:Create(v12, TweenInfo.new(v13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v14)
		v15:Play()
		return v15
	end
	function v10:CreateWindow(v16)
		v16 = v16 or {}
		local v17 = v16.Name or "NovaUI Hub"
		local v18 = v16.Subtitle or ""
		local v19 = v16.KeySystem or false
		local v20 = v16.Key or "1234"
		if v9.PlayerGui:FindFirstChild("NovaUI_Main") then
			v9.PlayerGui.NovaUI_Main:Destroy()
		end
		if v5:FindFirstChild("NovaUI_Main") then
			v5.NovaUI_Main:Destroy()
		end
		local v21 = Instance.new("ScreenGui")
		v21.Name = "NovaUI_Main"
		v21.ResetOnSpawn = false
		v21.DisplayOrder = 999
		pcall(function()
			if syn and syn.protect_gui then
				syn.protect_gui(v21)
				v21.Parent = v5
			else
				v21.Parent = v5
			end
		end)
		if not v21.Parent then
			v21.Parent = v9:WaitForChild("PlayerGui")
		end
		local v22 = Instance.new("TextButton")
		v22.Name = "MiniButton"
		v22.Size = UDim2.new(0, 45, 0, 45)
		v22.Position = UDim2.new(0, 15, 0, 15)
		v22.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
		v22.Text = "UI"
		v22.TextColor3 = Color3.fromRGB(255, 255, 255)
		v22.TextSize = 14
		v22.Font = Enum.Font.GothamBold
		v22.Visible = false
		v22.ZIndex = 100
		v22.Parent = v21
		local v23 = Instance.new("UICorner")
		v23.CornerRadius = UDim.new(0, 10)
		v23.Parent = v22
		local v24 = Instance.new("UIStroke")
		v24.Color = Color3.fromRGB(255, 255, 255)
		v24.Thickness = 2.5
		v24.Parent = v22
		task.spawn(function()
			while v21.Parent do
				for i = 0, 1, 0.005 do
					if not v21.Parent then break end
					v24.Color = Color3.fromHSV(i, 1, 1)
					task.wait(0.03)
				end
			end
		end)
		local v25 = Instance.new("Frame")
		v25.Name = "MainFrame"
		v25.Size = UDim2.new(0, 480, 0, 280)
		v25.Position = UDim2.new(0.5, -240, 0.5, -140)
		v25.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
		v25.BorderSizePixel = 0
		v25.ClipsDescendants = true
		v25.ZIndex = 10
		v25.Parent = v21
		local v26 = Instance.new("UICorner")
		v26.CornerRadius = UDim.new(0, 8)
		v26.Parent = v25
		local v27 = Instance.new("UIStroke")
		v27.Color = Color3.fromRGB(50, 50, 70)
		v27.Thickness = 1.5
		v27.Parent = v25
		local v28 = Instance.new("Frame")
		v28.Name = "TopBar"
		v28.Size = UDim2.new(1, 0, 0, 38)
		v28.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
		v28.BorderSizePixel = 0
		v28.ZIndex = 11
		v28.Parent = v25
		local v29 = Instance.new("UICorner")
		v29.CornerRadius = UDim.new(0, 8)
		v29.Parent = v28
		local v30 = Instance.new("Frame")
		v30.Size = UDim2.new(1, 0, 0, 8)
		v30.Position = UDim2.new(0, 0, 1, -8)
		v30.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
		v30.BorderSizePixel = 0
		v30.ZIndex = 11
		v30.Parent = v28
		local v31 = Instance.new("TextLabel")
		v31.Size = UDim2.new(0, 250, 0, 16)
		v31.Position = UDim2.new(0, 45, 0, 3)
		v31.BackgroundTransparency = 1
		v31.Text = v17
		v31.TextColor3 = Color3.fromRGB(240, 240, 255)
		v31.TextSize = 12
		v31.Font = Enum.Font.GothamBold
		v31.TextXAlignment = Enum.TextXAlignment.Left
		v31.ZIndex = 12
		v31.Parent = v28
		local v32 = Instance.new("TextLabel")
		v32.Size = UDim2.new(0, 250, 0, 14)
		v32.Position = UDim2.new(0, 45, 0, 19)
		v32.BackgroundTransparency = 1
		v32.Text = v18
		v32.TextColor3 = Color3.fromRGB(150, 150, 180)
		v32.TextSize = 9
		v32.Font = Enum.Font.Gotham
		v32.TextXAlignment = Enum.TextXAlignment.Left
		v32.ZIndex = 12
		v32.Parent = v28
		local v33 = Instance.new("TextButton")
		v33.Size = UDim2.new(0, 30, 0, 24)
		v33.Position = UDim2.new(0, 8, 0.5, -12)
		v33.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
		v33.Text = "UI"
		v33.TextColor3 = Color3.fromRGB(200, 200, 220)
		v33.TextSize = 11
		v33.Font = Enum.Font.GothamBold
		v33.ZIndex = 12
		v33.Parent = v28
		local v34 = Instance.new("UICorner")
		v34.CornerRadius = UDim.new(0, 5)
		v34.Parent = v33
		local v35 = Instance.new("TextButton")
		v35.Size = UDim2.new(0, 22, 0, 22)
		v35.Position = UDim2.new(1, -28, 0.5, -11)
		v35.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
		v35.Text = "X"
		v35.TextColor3 = Color3.fromRGB(255, 255, 255)
		v35.TextSize = 11
		v35.Font = Enum.Font.GothamBold
		v35.ZIndex = 12
		v35.Parent = v28
		local v36 = Instance.new("UICorner")
		v36.CornerRadius = UDim.new(0, 5)
		v36.Parent = v35
		local v37 = Instance.new("ScrollingFrame")
		v37.Size = UDim2.new(0, 115, 1, -48)
		v37.Position = UDim2.new(0, 8, 0, 42)
		v37.BackgroundTransparency = 1
		v37.BorderSizePixel = 0
		v37.CanvasSize = UDim2.new(0, 0, 0, 0)
		v37.ScrollBarThickness = 2
		v37.ZIndex = 11
		v37.Parent = v25
		local v38 = Instance.new("UIListLayout")
		v38.SortOrder = Enum.SortOrder.LayoutOrder
		v38.Padding = UDim.new(0, 5)
		v38.Parent = v37
		v38:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			v37.CanvasSize = UDim2.new(0, 0, 0, v38.AbsoluteContentSize.Y + 10)
		end)
		local v39 = Instance.new("Folder")
		v39.Name = "PagesFolder"
		v39.Parent = v25
		local v40, v41, v42, v43
		v28.InputBegan:Connect(function(v44)
			if v44.UserInputType == Enum.UserInputType.MouseButton1 or v44.UserInputType == Enum.UserInputType.Touch then
				v40 = true
				v42 = v44.Position
				v43 = v25.Position
				v44.Changed:Connect(function()
					if v44.UserInputState == Enum.UserInputState.End then v40 = false end
				end)
			end
		end)
		v7.InputChanged:Connect(function(v45)
			if v45.UserInputType == Enum.UserInputType.MouseButton1 or v45.UserInputType == Enum.UserInputType.Touch then
				v41 = v45
			end
		end)
		v6.RenderStepped:Connect(function()
			if v40 and v41 then
				local v46 = v41.Position - v42
				v25.Position = UDim2.new(v43.X.Scale, v43.X.Offset + v46.X, v43.Y.Scale, v43.Y.Offset + v46.Y)
			end
		end)
		local v47 = false
		local function v48()
			v47 = not v47
			if v47 then
				v11(v25, 0.3, {Size = UDim2.new(0, 0, 0, 0)})
				task.wait(0.15)
				v25.Visible = false
				v22.Visible = true
			else
				v22.Visible = false
				v25.Visible = true
				v11(v25, 0.3, {Size = UDim2.new(0, 480, 0, 280)})
			end
		end
		v33.MouseButton1Click:Connect(v48)
		v22.MouseButton1Click:Connect(v48)
		v35.MouseButton1Click:Connect(function() v21:Destroy() end)
		if v19 then
			v25.Visible = false
			local v49 = Instance.new("Frame")
			v49.Size = UDim2.new(0, 320, 0, 180)
			v49.Position = UDim2.new(0.5, -160, 0.5, -90)
			v49.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
			v49.ZIndex = 50
			v49.Parent = v21
			local v50 = Instance.new("UICorner")
			v50.CornerRadius = UDim.new(0, 8)
			v50.Parent = v49
			local v51 = Instance.new("UIStroke")
			v51.Color = Color3.fromRGB(80, 80, 120)
			v51.Thickness = 1.5
			v51.Parent = v49
			local v52 = Instance.new("TextLabel")
			v52.Size = UDim2.new(1, 0, 0, 30)
			v52.Position = UDim2.new(0, 0, 0, 8)
			v52.BackgroundTransparency = 1
			v52.Text = v17 .. " - Key"
			v52.TextColor3 = Color3.fromRGB(255, 255, 255)
			v52.TextSize = 14
			v52.Font = Enum.Font.GothamBold
			v52.ZIndex = 51
			v52.Parent = v49
			local v53 = Instance.new("TextBox")
			v53.Size = UDim2.new(1, -30, 0, 30)
			v53.Position = UDim2.new(0, 15, 0, 60)
			v53.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
			v53.Text = ""
			v53.PlaceholderText = "Escribe tu llave..."
			v53.TextColor3 = Color3.fromRGB(255, 255, 255)
			v53.PlaceholderColor3 = Color3.fromRGB(120, 120, 150)
			v53.TextSize = 12
			v53.Font = Enum.Font.Gotham
			v53.ZIndex = 51
			v53.Parent = v49
			local v54 = Instance.new("UICorner")
			v54.CornerRadius = UDim.new(0, 5)
			v54.Parent = v53
			local v55 = Instance.new("TextButton")
			v55.Size = UDim2.new(1, -30, 0, 30)
			v55.Position = UDim2.new(0, 15, 0, 110)
			v55.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
			v55.Text = "Verificar"
			v55.TextColor3 = Color3.fromRGB(255, 255, 255)
			v55.TextSize = 12
			v55.Font = Enum.Font.GothamBold
			v55.ZIndex = 51
			v55.Parent = v49
			local v56 = Instance.new("UICorner")
			v56.CornerRadius = UDim.new(0, 5)
			v56.Parent = v55
			v55.MouseButton1Click:Connect(function()
				if v53.Text == v20 then
					v49:Destroy()
					v25.Visible = true
				else
					v53.Text = ""
					v53.PlaceholderText = "¡Incorrecta!"
				end
			end)
		end
		local v57 = {}
		local v58 = true
		local function v59(v60, v61)
			local v62 = Instance.new("TextButton")
			v62.Size = UDim2.new(1, 0, 0, 28)
			v62.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
			v62.Text = "  " .. v60
			v62.TextColor3 = Color3.fromRGB(160, 160, 180)
			v62.TextSize = 11
			v62.Font = Enum.Font.GothamMedium
			v62.TextXAlignment = Enum.TextXAlignment.Left
			v62.ZIndex = 11
			v62.Parent = v37
			local v63 = Instance.new("UICorner")
			v63.CornerRadius = UDim.new(0, 5)
			v63.Parent = v62
			local v64 = Instance.new("ScrollingFrame")
			v64.Size = UDim2.new(1, -135, 1, -48)
			v64.Position = UDim2.new(0, 128, 0, 42)
			v64.BackgroundTransparency = 1
			v64.BorderSizePixel = 0
			v64.CanvasSize = UDim2.new(0, 0, 0, 0)
			v64.ScrollBarThickness = 3
			v64.Visible = false
			v64.ZIndex = 11
			v64.Parent = v39
			local v65 = Instance.new("UIListLayout")
			v65.SortOrder = Enum.SortOrder.LayoutOrder
			v65.Padding = UDim.new(0, 6)
			v65.Parent = v64
			v65:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				v64.CanvasSize = UDim2.new(0, 0, 0, v65.AbsoluteContentSize.Y + 10)
			end)
			if (v61 and v58) or (v58 and not v19) then
				v58 = false
				v64.Visible = true
				v62.BackgroundColor3 = Color3.fromRGB(50, 50, 75)
				v62.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
			v62.MouseButton1Click:Connect(function()
				for _, v66 in pairs(v39:GetChildren()) do
					if v66:IsA("ScrollingFrame") then v66.Visible = false end
				end
				for _, v67 in pairs(v37:GetChildren()) do
					if v67:IsA("TextButton") then
						v67.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
						v67.TextColor3 = Color3.fromRGB(160, 160, 180)
					end
				end
				v64.Visible = true
				v62.BackgroundColor3 = Color3.fromRGB(50, 50, 75)
				v62.TextColor3 = Color3.fromRGB(255, 255, 255)
			end)
			local v68 = {}
			function v68:AddButton(v69, v70, v71)
				local v72 = Instance.new("TextButton")
				v72.Size = UDim2.new(1, 0, 0, 30)
				v72.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
				v72.Text = "  " .. v69
				v72.TextColor3 = Color3.fromRGB(220, 220, 240)
				v72.TextSize = 12
				v72.Font = Enum.Font.Gotham
				v72.TextXAlignment = Enum.TextXAlignment.Left
				v72.ZIndex = 11
				v72.Parent = v64
				local v73 = Instance.new("UICorner")
				v73.CornerRadius = UDim.new(0, 5)
				v73.Parent = v72
				local v74
				if v70 then
					v74 = Instance.new("TextLabel")
					v74.Size = UDim2.new(0, 100, 1, 0)
					v74.Position = UDim2.new(1, -105, 0, 0)
					v74.BackgroundTransparency = 1
					v74.Text = v70
					v74.TextColor3 = Color3.fromRGB(130, 130, 160)
					v74.TextSize = 10
					v74.Font = Enum.Font.GothamBold
					v74.TextXAlignment = Enum.TextXAlignment.Right
					v74.ZIndex = 12
					v74.Parent = v72
				end
				v72.MouseButton1Click:Connect(function()
					pcall(v71)
					v11(v72, 0.1, {BackgroundColor3 = Color3.fromRGB(50, 50, 75)})
					task.wait(0.1)
					v11(v72, 0.1, {BackgroundColor3 = Color3.fromRGB(30, 30, 42)})
				end)
				return v72, v74
			end
			function v68:AddLabel(v75)
				local v76 = Instance.new("TextLabel")
				v76.Size = UDim2.new(1, 0, 0, 20)
				v76.BackgroundTransparency = 1
				v76.Text = "  " .. v75
				v76.TextColor3 = Color3.fromRGB(150, 150, 180)
				v76.TextSize = 11
				v76.Font = Enum.Font.GothamBold
				v76.TextXAlignment = Enum.TextXAlignment.Left
				v76.ZIndex = 11
				v76.Parent = v64
			end
			return v68
		end
		local v77 = v59("Ajustes", true)
		v77:AddLabel("--- Información del Jugador ---")
		local _, v78 = v77:AddButton("Usuario: " .. v9.Name, v9.DisplayName, function() end)
		local _, v79 = v77:AddButton("Ping actual", "Calculando...", function() end)
		local _, v80 = v77:AddButton("FPS actuales", "Calculando...", function() end)
		task.spawn(function()
			local v81 = 0
			v6.RenderStepped:Connect(function(v82)
				if tick() - v81 >= 0.5 then
					v81 = tick()
					pcall(function()
						local v83 = math.floor(v9:GetNetworkPing() * 1000)
						local v84 = math.floor(1 / v82)
						if v79 then v79.Text = v83 .. " ms" end
						if v80 then v80.Text = tostring(v84) end
					end)
				end
			end)
		end)
		v77:AddLabel("--- Personalización de Temas ---")
		v77:AddButton("Tema Oscuro (Estándar)", "Aplicar", function()
			v25.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
			v28.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
		end)
		v77:AddButton("Tema Azul Nocturno", "Aplicar", function()
			v25.BackgroundColor3 = Color3.fromRGB(15, 22, 36)
			v28.BackgroundColor3 = Color3.fromRGB(20, 30, 48)
		end)
		v77:AddButton("Tema Gris Minimalista", "Aplicar", function()
			v25.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
			v28.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
		end)
		function v57:AddTab(v85)
			return v59(v85, false)
		end
		return v57
	end
	return v10
end)({"TweenService", "CoreGui", "RunService", "UserInputService", "Players"}, {}, {})
