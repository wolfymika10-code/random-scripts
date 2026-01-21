local player = game.Players.LocalPlayer
local networkOwnedParts = {}
local uis = game:GetService("UserInputService")
local mouse = player:GetMouse()
local defaultmouseicon = mouse.Icon
local c = player.Character

player.CharacterAdded:Connect(function(char)
	c = char
end)

local function loading(x)
	if x then
		mouse.Icon = "rbxassetid://147417474"
	else
		mouse.Icon = defaultmouseicon
	end
end

local function init(prt)
	local selectionbox = Instance.new("SelectionBox")
	selectionbox.Adornee = prt
	selectionbox.Parent = prt
	selectionbox.LineThickness = 0.1
	selectionbox.SurfaceColor3 = Color3.fromRGB(13, 105, 172)
	selectionbox.SurfaceTransparency = 0.5
	selectionbox.Transparency = 0
	selectionbox.Visible = true

	local bodyPosition = Instance.new("BodyPosition")
	bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000)
	bodyPosition.P = 2000
	bodyPosition.D = 100
	bodyPosition.Position = prt.Position
	bodyPosition.Parent = prt

	local dragging = false
	local selectedPart = nil
	local offset = Vector3.zero

	mouse.Button1Down:Connect(function()
		local target = mouse.Target
		if target and target == prt then
			dragging = true
			selectedPart = prt
			offset = selectedPart.Position - mouse.Hit.Position
		end
	end)

	mouse.Button1Up:Connect(function()
		dragging = false
		selectedPart = nil
	end)

	game:GetService("RunService").RenderStepped:Connect(function()
		if dragging and selectedPart then
			local newPos = mouse.Hit.Position + offset
			bodyPosition.Position = newPos
		end
	end)
end

uis.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.R then
		print("R pressed")
		loading(true)
		networkOwnedParts = {}
		for _, part in pairs(workspace:GetDescendants()) do
			if part:IsA("BasePart") and not part.Anchored and not part.Parent:FindFirstChild("Humanoid") and not part.Parent:IsA("Accessory") and not part:IsA("Camera") and not part:IsA("AudioListener") and not part:IsA("Wire") then
				table.insert(networkOwnedParts, part)
				if not part:FindFirstChildOfClass("BodyPosition") then init(part) end
			end
		end
		loading(false)
		print("Done")
	elseif input.KeyCode == Enum.KeyCode.T then
		local hitpos = mouse.Hit.Position
		for i, child in ipairs(networkOwnedParts) do
			child:FindFirstChildOfClass("BodyPosition").Position = hitpos
		end
	elseif input.KeyCode == Enum.KeyCode.Y then
		for i, child in ipairs(networkOwnedParts) do
			child.CanCollide = not child.CanCollide
		end
	elseif input.KeyCode == Enum.KeyCode.U then
		for i, child in ipairs(networkOwnedParts) do
			if child:FindFirstChildOfClass("BodyGyro") then
				child:FindFirstChildOfClass("BodyGyro"):Destroy()
			else
				local bodyGyro = Instance.new("BodyGyro")
				bodyGyro.MaxTorque = Vector3.new(10000, 10000, 10000)
				bodyGyro.P = 2000
				bodyGyro.Parent = child
			end
		end
	end
end)

print("Done connections")
