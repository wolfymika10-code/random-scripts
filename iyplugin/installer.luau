local function notify(messsage, parent)
    local StarterGui = game:GetService("StarterGui")
    
    StarterGui:SetCore("SendNotification", {
      Title = message,
      Text = parent,
      Duration = 5,
    })
end

local ok = pcall(function()
      return writefile()
end)

if not ok then
    nofity("no writefile", "Your executor enviroment does not support the writefile function")
    return
end

local ok, content = pcall(function()
      return game:HttpGet("https://raw.githubusercontent.com/wolfymika10-code/random-scripts/refs/heads/main/iyplugin/t0kenhasdied.iy")
end)

if not ok then
    notify("no httpget or external error", content)
    return
end

local ok, reason = pcall(function()
      return writefile("t0kenhasdied.iy", content)
end)

if not ok then
    notify("failed to dump (weird...)", reason)
    return
else
    notify("Installed!", "installed sucessfully, run reloadplugin t0kenhasdied or addplugin t0kenhasdied")
end
