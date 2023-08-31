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
							local HighLight = Instance.new("Highlight", v.Parent)
							table.insert(Highlights, HighLight)
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
