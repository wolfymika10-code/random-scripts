local gui = Instance.new("ScreenGui")
local viewport = Instance.new("ViewportFrame")
local camera = workspace.CurrentCamera
local players = game:GetService("Players")
local runservice = game:GetService("RunService")
local player = players.LocalPlayer

-- init gui
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.DisplayOrder = -99999
gui.IgnoreGuiInset = true
viewport.Active = false
viewport.Parent = gui
viewport.Size = UDim2.new(1, 0, 1, 0)
viewport.BackgroundTransparency = 1
viewport.Ambient = Color3.new(1, 1, 1)
viewport.LightColor = Color3.new(1, 1, 1)
viewport.LightDirection = Vector3.new(0, 1, 0)
viewport.CurrentCamera = camera

local hooked = {}

-- init player hook
local function onCharacterAdded(character)
	if character == player.Character then return end
	table.insert(hooked, character)
	local parts = {}
	for i, child in ipairs(character:GetChildren()) do
		if child:IsA("BasePart") then
			local target = game.Players:GetPlayerFromCharacter(character)
			local part = Instance.new("Part", viewport)
			part.Color = target.TeamColor.Color
			part.Size = child.Size
			part.CFrame = child.CFrame
			part.Anchored = true
			table.insert(parts, part)
			local update = runservice.RenderStepped:Connect(function()
				part.CFrame = child.CFrame
				-- breaks out of loop if not existing anymore
			end)
			character.Humanoid.Died:Connect(function()
				update:Disconnect()
				for i, part in ipairs(parts) do
					part:Destroy()
				end
			end)
			-- if player leaves disconnect
			target.CharacterRemoving:Connect(function()
				update:Disconnect()
				for i, part in ipairs(parts) do
					part:Destroy()
				end
			end)
			-- if player leaves disconnect
			game.Players.PlayerRemoving:Connect(function(plr)
				if plr == target then
					update:Disconnect()
					for i, part in ipairs(parts) do
						part:Destroy()
					end
				end
			end)
		end
	end
end
players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(onCharacterAdded)
end)

-- hook existing players
local plrs = players:GetPlayers()
for i, plr in ipairs(plrs) do
	plr.CharacterAdded:Connect(onCharacterAdded)
end
