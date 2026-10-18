local figure = game.Players.LocalPlayer.Character

figure.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=28440069"
figure.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=161210451"
figure.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=165167557"
figure.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=165167632"
figure.Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=161235826"
figure.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=161100084"
figure.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=161100084"

local danceObject = Instance.new("Animation")
danceObject.AnimationId = "http://www.roblox.com/asset/?id=161099825"

game:GetService("Players").LocalPlayer.Chatted:connect(function(msg)
    if msg == "/dance" then
        if figure:FindFirstChildOfClass("Humanoid") then
            if figure:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator") then
                spawn(function()
                    local anim = figure:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator"):LoadAnimation(danceObject)
                    anim.Looped = true
                    anim.Priority = Enum.AnimationPriority.Action
                    anim:Play()
                    while figure:FindFirstChild("HumanoidRootPart") and figure:FindFirstChild("HumanoidRootPart").Velocity.Magnitude < 0.1 do wait() end
                    anim:Stop()
                    anim:Destroy()
                end)
            else
                spawn(function()
                    local anim = figure:FindFirstChildOfClass("Humanoid"):LoadAnimation(danceObject)
                    anim.Looped = true
                    anim.Priority = Enum.AnimationPriority.Action
                    anim:Play()
                    while figure:FindFirstChild("HumanoidRootPart") and figure:FindFirstChild("HumanoidRootPart").Velocity.Magnitude < 0.1 do wait() end
                    anim:Stop()
                    anim:Destroy()
                end)
            end
        end
    end
end)
