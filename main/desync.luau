--[[
MIT License

Copyright (c) 2026 EdgeIY

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]--

if game:GetService("UserInputService").TouchEnabled == false then
	script.Parent:Destroy()
	return
end

--// declarations \\

local maincommandbar = script.Parent:WaitForChild("MainCommandBar")
local outputbutton = maincommandbar:WaitForChild("Output")
local commandwriter = maincommandbar:WaitForChild("CommandWriter")
local suggestions = maincommandbar:WaitForChild("Suggestions")

local templatefolder = script:WaitForChild("Templates")
local suggestionsbuttontemplate = templatefolder:WaitForChild("SuggestionsButton")

local suggestiondetail = script.Parent:WaitForChild("SuggestionDetail")

local tweenservice = game:GetService("TweenService")
local runservice = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local replicatedstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local LocalPlayer = players.LocalPlayer

local execute = replicatedstorage:WaitForChild("Execute")
local commands = require(replicatedstorage:WaitForChild("Commands"))

local offsetX = suggestiondetail.AbsoluteSize.X - 100
local offsetY = -suggestiondetail.AbsoluteSize.Y - 10

--// helpers \\

local function formatArgumentSpecialCases(command)
	if string.find(command, "!me") then
		-- replaces !me with the local players username
		command = string.gsub(command, "!me", LocalPlayer.Name)
	end
	
	-- add more speical cases if needed
	
	return command
end

--// tweens \\

local opensuggestions = tweenservice:Create(
	suggestions,
	TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
	{Size = UDim2.new(0.838, 0, 6, 0), Position = UDim2.new(0.18, 0, 1.4, 0)}
)

local closesuggestions = tweenservice:Create(
	suggestions,
	TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
	{Size = UDim2.new(0.838, 0, 0, 0), Position = UDim2.new(0.18, 0, 1.4, 0)}
)

--// logic \\

local autocompleteconnection
local tabcompleteconnection
local matches

commandwriter.Focused:Connect(function()
	task.wait(0.05)
	if commandwriter.Text == "'" then
		while commandwriter.Text == "'" do
			commandwriter.Text = ""
			task.wait()
		end
	end
	
	opensuggestions:Play()
	
	commandwriter.TextColor3 = Color3.new(1,1,1)
	
	for _, child in pairs(suggestions:QueryDescendants("TextButton")) do
		child:Destroy()
	end

	if commandwriter.Text == "" then
		for commandName, commandInfo in pairs(commands) do
			local newbutton = suggestionsbuttontemplate:Clone()
			newbutton.Text = commandName
			newbutton.Parent = suggestions

			newbutton.MouseEnter:Connect(function()
				suggestiondetail.Visible = true
				suggestiondetail.CommandName.Text = commandName
				suggestiondetail.Description.Text = commandInfo.Description
				suggestiondetail.Arguments.Text = table.concat(commandInfo.Args, ", ")
			end)

			newbutton.MouseLeave:Connect(function()
				suggestiondetail.Visible = false
			end)

			newbutton.MouseButton1Click:Connect(function()
				commandwriter.Text = commandName
				commandwriter:CaptureFocus()
			end)
		end
	end
	
	autocompleteconnection = commandwriter:GetPropertyChangedSignal("Text"):Connect(function()
		if string.find(commandwriter.Text, " ") then
			if closesuggestions.PlaybackState ~= Enum.PlaybackState.Playing or closesuggestions.PlaybackState ~= Enum.PlaybackState.Completed then
				closesuggestions:Play()
			end
		else
			if opensuggestions.PlaybackState ~= Enum.PlaybackState.Playing then
				opensuggestions:Play()
			end
		end
		
		matches = {}

		for command, commandinfo in pairs(commands) do
			if string.sub(string.lower(command), 1, #commandwriter.Text) == string.lower(commandwriter.Text) then
				table.insert(matches, command)
			end
		end
		
		for _, child in pairs(suggestions:QueryDescendants("TextButton")) do
			child:Destroy()
		end
		
		for _, match in pairs(matches) do
			local newbutton = suggestionsbuttontemplate:Clone()
			newbutton.Text = match
			newbutton.Parent = suggestions
			
			newbutton.MouseEnter:Connect(function()
				suggestiondetail.Visible = true
				suggestiondetail.CommandName.Text = match
				suggestiondetail.Description.Text = commands[match].Description
				suggestiondetail.Arguments.Text = table.concat(commands[match].Args, ", ")
			end)
			
			newbutton.MouseLeave:Connect(function()
				suggestiondetail.Visible = false
			end)
			
			newbutton.MouseButton1Click:Connect(function()
				commandwriter.Text = match
				commandwriter:CaptureFocus()
			end)
		end
	end)
end)

commandwriter.FocusLost:Connect(function(enter)
	closesuggestions:Play()
	
	if autocompleteconnection then
		autocompleteconnection:Disconnect()
	end
	
	suggestiondetail.Visible = false
	
	if enter then
		local command = formatArgumentSpecialCases(commandwriter.Text)
		commandwriter.Text = "Awating response..."
		local success, response = execute:InvokeServer(command)
		
		if success then
			commandwriter.Text = ""
		else
			commandwriter.TextColor3 = Color3.new(1,0,0)
			commandwriter.Text = response
		end
	end
end)

runservice.RenderStepped:Connect(function()
	local mouse = uis:GetMouseLocation()

	suggestiondetail.Position = UDim2.fromOffset(
		mouse.X + offsetX,
		mouse.Y + offsetY
	)
end)

uis.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.Quote and not gameProcessedEvent then
		commandwriter:CaptureFocus()
	elseif input.KeyCode == Enum.KeyCode.Tab and commandwriter:IsFocused() then
		commandwriter.Text = ""
		
		if matches[1] then
			local match = matches[1]
			repeat
				commandwriter.Text = match .. " "
				task.wait()
			until commandwriter.Text == match .. " "
			
			-- change cursor position to end 
			commandwriter.CursorPosition = #commandwriter.Text + 1
		end
	end
end)
