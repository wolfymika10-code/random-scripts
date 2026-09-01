local ShirtStealerUI,MainFrame,Shirt,View,Id,Pants,Id1,View1,SelectionBox,DownloadButton

--booxbox stealer modded from shirtstealer

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local speed = 0.5 -- speed of the rainbow effect

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

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new(0, 1)
	UIGradient.Parent = Shirt

	Id = Instance.new("TextBox")
	Id.Name = "Id"
	Id.Size = UDim2.new(0.87, 0, 0.9, 0)
	Id.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Id.BackgroundTransparency = 1
	Id.Position = UDim2.new(0.1, 0, 0.0150086, 0)
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

    DownloadButton = Instance.new("TextButton")
    DownloadButton.Size = UDim2.new(1.2961402, 0, 0.4258508, 0)
    DownloadButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    DownloadButton.Position = UDim2.new(-0.0069106, 0, 0.5360688, 0)
    DownloadButton.BorderSizePixel = 0
    DownloadButton.BackgroundColor3 = Color3.fromRGB(38, 255, 0)
    DownloadButton.FontSize = Enum.FontSize.Size14
    DownloadButton.TextSize = 14
    DownloadButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    DownloadButton.Text = "download as .ogg"
    DownloadButton.TextWrapped = true
    DownloadButton.TextWrap = true
    DownloadButton.Font = Enum.Font.Unknown
    DownloadButton.TextScaled = true
    DownloadButton.Parent = MainFrame

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
	RunService.Heartbeat:Connect(function()
        local hue = (os.clock() * speed) % 1
        
        SelectionBox.Color3 = Color3.fromHSV(hue, 1, 1)
    end)
	SelectionBox.Parent = workspace
	
	
	ShirtStealerUI.Parent = game:GetService("CoreGui")
end

local StarterGui = game:GetService("StarterGui")

local function sendNotification(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration
    })
end

local canfolder = false
local mf: (string) -> (void) = nil -- global declaration
local folder: () -> (boolean) = nil -- global declaration
xpcall(function()
    mf = makefolder
    print(" makefolder retrived: " .. tostring(mf))
    folder = isfolder
    print(" isfolder retrived")
    canfolder = true
end, function(err)
    sendNotification("DownloadError", "missing makefolder and/or isfolder exploit func", 5)
    sendNotification(nil, "Audios will be unordered in your workspace folder.", 7.5)
    canfolder = false
end)

local canfile = false
local wf: () -> () = nil -- global declaration
xpcall(function()
    wf = writefile
    print(" writefile retrived ")
    canwrite = true
end, function(err)
    sendNotification("DownloadError", "missing writefile exploit func, you wont be able to download audio files.", 5)
    sendNotification(nil, "You can use assetdelivery externally to download audio files.", 7.5)
    canwrite = false
    return
end)

if folder("boomboxsteal") then
    print("boomboxsteal folder found")
else
    if canfolder then
        mf("boomboxsteal")
        print("boomboxsteal folder created")
    else
        sendNotification("DownloadError", "Cannot create boomboxsteal folder due to missing exploit functions.", 5)
    end
end

if folder("boomboxsteal/logs") then
    print("boomboxsteal/logs folder found")
else
    if canfolder then
        mf("boomboxsteal/logs")
        print("boomboxsteal/logs folder created")
    else
        sendNotification("DownloadError", "Cannot create boomboxsteal/logs folder due to missing exploit functions.", 5)
    end
end

if canwrite and folder("boomboxsteal") then
    wf("boomboxsteal/README.txt", `  █████       █████    █████                          █████               \n ░░███      ███░░░███ ░░███                          ░░███                \n ███████   ███   ░░███ ░███ █████  ██████  ████████   ░███████    ██████  \n░░░███░   ░███    ░███ ░███░░███  ███░░███░░███░░███  ░███░░███  ░░░░░███ \n  ░███    ░███    ░███ ░██████░  ░███████  ░███ ░███  ░███ ░███   ███████ \n  ░███ ███░░███   ███  ░███░░███ ░███░░░   ░███ ░███  ░███ ░███  ███░░███ \n  ░░█████  ░░░█████░   ████ █████░░██████  ████ █████ ████ █████░░████████\n   ░░░░░     ░░░░░░   ░░░░ ░░░░░  ░░░░░░  ░░░░ ░░░░░ ░░░░ ░░░░░  ░░░░░░░░ \n                                                                          \n                                                                          \n                                                                          \n             █████  ███               █████                               \n            ░░███  ░░░               ░░███                                \n  █████   ███████  ████   ██████   ███████                                \n ███░░   ███░░███ ░░███  ███░░███ ███░░███                                \n░░█████ ░███ ░███  ░███ ░███████ ░███ ░███                                \n ░░░░███░███ ░███  ░███ ░███░░░  ░███ ░███                                \n ██████ ░░████████ █████░░██████ ░░████████                               \n░░░░░░   ░░░░░░░░ ░░░░░  ░░░░░░   ░░░░░░░░                                \n\n\n\n\nThis folder contains audio files downloaded from boomboxes in-game. You can use these files in your own games, but please respect the original creators of the audio and do not claim them as your own. Check out the logs folder to find all the audios and their information (in json!)`)
else

end

buildUI()

DownloadButton.MouseButton1Click:Connect(function()
    if canwrite then
        local audioid = Id.Text
        audioid = audioid:gsub("rbxassetid://", "")
        if audioid ~= "" then
            local url = "https://assetdelivery.roblox.com/v1/asset?id=" .. audioid
            local response = game:HttpGet(url)
            -- Attempt to decode response for JSON errors
            local success, decoded = pcall(function()
                return HttpService:JSONDecode(response)
            end)

            if success and decoded and decoded.errors then
                sendNotification("Download Error", "Failed to download audio file. This can be because the audio is group owned. Check the console for more details.", 7.5)
                warn("Failed to download audio file. Response: " .. tostring(response))
                return
            end
            -- this audio is safe to download, write it to file
            if canfolder then
                wf("boomboxsteal/" .. tostring(audioid) .. ".ogg", response)
                sendNotification("Download Complete", "Audio file downloaded as boomboxsteal/" .. tostring(audioid) .. ".ogg", 5)
                -- initate log
                pcall(function()
                    local log = {}
                    log.time = os.date("%Y-%m-%d %H:%M:%S")
                    local productInfo = MarketplaceService:GetProductInfo(audioid, Enum.InfoType.Asset)
                    log.productInfo = productInfo
                    wf("boomboxsteal/logs/" .. tostring(audioid) .. ".json", HttpService:JSONEncode(log))
                end)
            else
                wf(tostring(audioid) .. ".ogg", response)
                sendNotification("Download Complete", "Audio file downloaded as " .. tostring(audioid) .. ".ogg in workspace folder", 5)
            end
        else
            sendNotification("Download Error", "No audio ID provided.", 5)
        end
    else
        sendNotification("Download Error", "Cannot download files due to missing exploit functions.", 5)
    end
end)

local uis = game:GetService("UserInputService")
local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local mouse = localplayer:GetMouse()
local tweenservice = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0)
local tweeninfoin = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut, 0, false, 0)

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

local toggled = false
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
					if character:FindFirstChild("BoomBox") then
						print("		    found boombox")
                        if character.BoomBox:FindFirstChild("Handle") and character.BoomBox.Handle:FindFirstChildOfClass("Sound") then
                            print("		        found sound")
                            lasthitshirt = character.BoomBox.Handle:FindFirstChildOfClass("Sound").SoundId
                            Shirt.Id.Text = tostring(lasthitshirt)
                            return
                        end
                    elseif character:FindFirstChild("BoomboxSoundPart") and character:FindFirstChild("BoomboxSoundPart"):FindFirstChildOfClass("Sound") then
                        print("		    found boombox sound part")
                        lasthitshirt = character:FindFirstChild("BoomboxSoundPart"):FindFirstChildOfClass("Sound").SoundId
                        Shirt.Id.Text = tostring(lasthitshirt)
                        return
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