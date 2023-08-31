local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local NoClipping = false
local InfJump = false
local ESP = false
local Highlights = {}
local Player = game.Players.LocalPlayer
local Character = Player.Character

local Window = Rayfield:CreateWindow({
	Name = "Nebline",
	LoadingTitle = "get ready to fuck up the game!",
	LoadingSubtitle = "by ExplosiveBush",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil,
		FileName = "Big Hub"
	},
	Discord = {
		Enabled = true,
		Invite = "https://discord.gg/kMK33qPJBJ",
		RememberJoins = true
	},
	KeySystem = false,
})

local MainTab = Window:CreateTab("Main", 4483362458)
local Section1 = MainTab:CreateSection("Character Related")

local WalkSpeed = MainTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {1, 500},
	Increment = 1,
	Suffix = "",
	CurrentValue = 16,
	Flag = "Slider1",
	Callback = function(Value)
		Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
	end,
})

local JumpPower = MainTab:CreateSlider({
	Name = "JumpPower",
	Range = {1, 500},
	Increment = 1,
	Suffix = "",
	CurrentValue = 50,
	Flag = "Slider2",
	Callback = function(Value)
		Character:FindFirstChildOfClass("Humanoid").JumpPower = Value
	end,
})

local Toggle = MainTab:CreateToggle({
	Name = "NoClip",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		NoClipping = Value
	end,
})

local Toggle2 = MainTab:CreateToggle({
	Name = "Infinite Jump",
	CurrentValue = false,
	Flag = "Toggle2",
	Callback = function(Value)
		InfJump = Value
	end,
})

local Section2 = MainTab:CreateSection("FPS Related")

local Toggle3 = MainTab:CreateToggle({
	Name = "ESP",
	CurrentValue = false,
	Flag = "Toggle3",
	Callback = function(Value)
		ESP = Value

		if ESP == true then
			for i, v in pairs(game.Workspace:GetDescendants()) do
				if v:IsA("Humanoid") then
					if v.Parent:IsA("Model") then
						if game.Players:GetPlayerFromCharacter(v.Parent) then
							if game.Players:GetPlayerFromCharacter(v.Parent) ~= Player then
								local HighLight = Instance.new("Highlight", v.Parent)
								table.insert(Highlights, HighLight)

								local espgui = Instance.new("BillboardGui")
								local EspName = Instance.new("TextLabel")

								espgui.Name = "espgui"
								espgui.Parent = v.Parent.Head
								espgui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
								espgui.Active = true
								espgui.ExtentsOffset = Vector3.new(0, 1, 0)
								espgui.LightInfluence = 1.000
								espgui.Size = UDim2.new(0, 200, 0, 50)

								EspName.Name = "EspName"
								EspName.Parent = espgui
								EspName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								EspName.BackgroundTransparency = 1.000
								EspName.BorderColor3 = Color3.fromRGB(0, 0, 0)
								EspName.BorderSizePixel = 0
								EspName.Size = UDim2.new(0, 200, 0, 50)
								EspName.Font = Enum.Font.SourceSans
								EspName.Text = "nigga"
								EspName.TextColor3 = Color3.fromRGB(0, 170, 255)
								EspName.TextScaled = true
								EspName.TextSize = 14.000
								EspName.TextWrapped = true

								EspName.Text = v.Parent.Name

								table.insert(Highlights, espgui)
							end	
						end
					end
				end
			end
		else
			for i, v in pairs(Highlights) do
				if v:IsA("Highlight") then
					v:Destroy()
				end
			end

			table.clone(Highlights)
		end

	end,
})

game:GetService("RunService").RenderStepped:Connect(function()
	if NoClipping == true then
		for i, v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	else
		for i, v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and v.Name ~= "Head" then
				v.CanCollide = true
			end
		end
	end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
	if InfJump == true then
		Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)
