local ShirtStealerUI,MainFrame,Shirt,View,Id,Pants,Id1,View1,SelectionBox = nil,nil,nil,nil,nil,nil,nil,nil,nil -- global declarations

local function buildUI()
	-- This was generated with Instance Serializer.
	ShirtStealerUI = Instance.new("ScreenGui")
	ShirtStealerUI.Name = "ShirtStealerUI"
	ShirtStealerUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ShirtStealerUI.DisplayOrder = 999999999

	MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0.2, 0, 0.4, 0)
	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.Position = UDim2.new(-0.225, 0, 0.3, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainFrame.Style = Enum.FrameStyle.DropShadow
	MainFrame.Parent = ShirtStealerUI

	Shirt = Instance.new("Frame")
	Shirt.Name = "Shirt"
	Shirt.Size = UDim2.new(0.947, 0, 0.47, 0)
	Shirt.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Shirt.Position = UDim2.new(0.019365, 0, 0.0308276, 0)
	Shirt.BorderSizePixel = 0
	Shirt.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Shirt.Parent = MainFrame

	View = Instance.new("ImageLabel")
	View.Name = "View"
	View.Size = UDim2.new(0.2916359, 0, 0.9, 0)
	View.BorderColor3 = Color3.fromRGB(0, 0, 0)
	View.BackgroundTransparency = 1
	View.Position = UDim2.new(0.0218134, 0, 0.021333, 0)
	View.BorderSizePixel = 0
	View.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	View.Image = "rbxassetid://0"
	View.Parent = Shirt

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new(0, 1)
	UIGradient.Parent = Shirt

	Id = Instance.new("TextBox")
	Id.Name = "Id"
	Id.Size = UDim2.new(0.67, 0, 0.9, 0)
	Id.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Id.BackgroundTransparency = 1
	Id.Position = UDim2.new(0.3134494, 0, 0.0150086, 0)
	Id.BorderSizePixel = 0
	Id.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Id.FontSize = Enum.FontSize.Size14
	Id.TextWrapped = true
	Id.TextWrap = true
	Id.TextSize = 14
	Id.TextColor3 = Color3.fromRGB(255, 255, 255)
	Id.PlaceholderText = "ID goes here on selection"
	Id.Text = ""
	Id.TextEditable = true
	Id.ClearTextOnFocus = false
	Id.CursorPosition = -1
	Id.Font = Enum.Font.SourceSans
	Id.TextScaled = true
	Id.TextWrapped = true
	Id.Parent = Shirt

	Pants = Instance.new("Frame")
	Pants.Name = "Pants"
	Pants.Size = UDim2.new(0.952, 0, 0.47, 0)
	Pants.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Pants.Position = UDim2.new(0.019, 0, 0.51, 0)
	Pants.BorderSizePixel = 0
	Pants.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Pants.Parent = MainFrame

	Id1 = Instance.new("TextBox")
	Id1.Name = "Id"
	Id1.Size = UDim2.new(0.67, 0, 0.9, 0)
	Id1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Id1.BackgroundTransparency = 1
	Id1.Position = UDim2.new(0.3134494, 0, 0.0150086, 0)
	Id1.BorderSizePixel = 0
	Id1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Id1.FontSize = Enum.FontSize.Size14
	Id1.TextWrapped = true
	Id1.TextWrap = true
	Id1.TextSize = 14
	Id1.TextColor3 = Color3.fromRGB(255, 255, 255)
	Id1.PlaceholderText = "ID goes here on selection"
	Id1.Text = ""
	Id1.TextEditable = true
	Id1.ClearTextOnFocus = false
	Id1.CursorPosition = -1
	Id1.Font = Enum.Font.SourceSans
	Id1.TextScaled = true
	Id1.TextWrapped = true
	Id1.Parent = Pants

	View1 = Instance.new("ImageLabel")
	View1.Name = "View"
	View1.Size = UDim2.new(0.2916359, 0, 0.9, 0)
	View1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	View1.BackgroundTransparency = 1
	View1.Position = UDim2.new(0.0218134, 0, 0.021333, 0)
	View1.BorderSizePixel = 0
	View1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	View1.Image = "rbxassetid://0"
	View1.Parent = Pants

	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new(0, 1)
	UIGradient1.Parent = Pants

	local AlertText = Instance.new("TextLabel")
	AlertText.Name = "AlertText"
	AlertText.Size = UDim2.new(0, 274, 0, 23)
	AlertText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AlertText.BackgroundTransparency = 1
	AlertText.Position = UDim2.new(0.0473859, 0, -0.0703077, 0)
	AlertText.BorderSizePixel = 0
	AlertText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AlertText.FontSize = Enum.FontSize.Size14
	AlertText.TextSize = 14
	AlertText.TextColor3 = Color3.fromRGB(255, 0, 0)
	AlertText.TextYAlignment = Enum.TextYAlignment.Bottom
	AlertText.Text = "STEALMODE ENABLED: PRESS P TO DISABLE"
	AlertText.TextWrapped = true
	AlertText.TextWrap = true
	AlertText.Font = Enum.Font.RobotoCondensed
	AlertText.TextXAlignment = Enum.TextXAlignment.Left
	AlertText.TextScaled = true
	AlertText.Parent = MainFrame

	local UIStroke2 = Instance.new("UIStroke")
	UIStroke2.Color = Color3.fromRGB(81, 0, 0)
	UIStroke2.Parent = AlertText
	
	SelectionBox = Instance.new("SelectionBox")
	SelectionBox.Color3 = Color3.fromRGB(255, 255, 255)
	SelectionBox.Parent = workspace
	
	
	ShirtStealerUI.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

buildUI()

local uis = game:GetService("UserInputService")
local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local mouse = localplayer:GetMouse()
local tweenservice = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0)
local tweeninfoin = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.In, 0, false, 0)

local open = tweenservice:Create(
	MainFrame,
	tweeninfo,
	{Position = UDim2.new(0, 0, 0.3, 0)}
)

local close = tweenservice:Create(
	MainFrame,
	tweeninfoin,
	{Position = UDim2.new(-0.225, 0, 0.3, 0)}
)

local toggled = true
local lasthitshirt = nil
local lasthitpants = nil
local mouseconnection = nil

uis.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.P and not gameProcessedEvent then
		print("pressed p")
		toggled = not toggled
		if toggled then
			print("	toggled")
			open:Play()
			mouseconnection = mouse.Button1Down:Connect(function()
				local target = mouse.Target
				local character = target:FindFirstAncestorOfClass("Model")
				if character and character:FindFirstChild("Humanoid") then
					print("		found character")
					SelectionBox.Adornee = character
					lasthitshirt = nil
					lasthitpants = nil
					Shirt.Id.Text = tostring(lasthitshirt)
					View.Image = tostring(lasthitshirt)
					Pants.Id.Text = tostring(lasthitpants)
					View.Image = tostring(lasthitpants)
					if character:FindFirstChildOfClass("Shirt") then
						print("				found shirt")
						lasthitshirt = character:FindFirstChildOfClass("Shirt").ShirtTemplate
						Id.Text = lasthitshirt
						View.Image = lasthitshirt
					end
					if character:FindFirstChildOfClass("Pants") then
						print("				found pants")
						lasthitpants = character:FindFirstChildOfClass("Pants").PantsTemplate
						Id1.Text = lasthitpants
						View1.Image = lasthitpants
					end
				end
			end)
		else
			print("	untoggled")
			close:Play()
			if mouseconnection then
				print("		disconnecting mouse")
				mouseconnection:Disconnect()
			end
			SelectionBox.Adornee = nil
		end
	end
end)
