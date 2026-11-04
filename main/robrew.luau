-- robrew

local player = game:GetService("Players").LocalPlayer
local textchatservice = game:GetService("TextChatService")
local rbxgeneral = textchatservice:GetTextChannels().RbxGeneral

local prefix = "!robrew "

local function speak(message)
    rbxgeneral:SendAsync(message)
end

-- when player says something
player.Chatted:Connect(function(message)
    if string.sub(message, 1, #prefix) == prefix then
        local command = string.sub(message, #prefix + 1)
        if command == "verify" then
            speak("Robrew is working!")
        elseif command == "execute" then
            local ss, err = pcall(function()
                ---@diagnostic disable-next-line
                loadstring(message:sub(#prefix + 1 + #command + 1))()
            end)
            if not ss then
                speak("Error occurred while executing code: " .. err)
            end
        else
            speak("Unknown command: " .. command)
        end
    end
end)