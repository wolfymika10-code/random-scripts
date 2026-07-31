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

-- credits to EdgeIY for the invisible chunk of the script

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local players = game:GetService("Players")
local Player = players.LocalPlayer

local a=Instance.new"ScreenGui"
a.ZIndexBehavior=1
a.ResetOnSpawn=false
a.DisplayOrder=999999999
local b=Instance.new"Frame"
b.Name="Main"
b.Size=UDim2.new(0.236728,0,0.3913555,0)
b.BorderColor3=Color3.fromRGB(0,0,0)
b.Position=UDim2.new(0.7632719,0,0,0)
b.BorderSizePixel=0
b.BackgroundColor3=Color3.fromRGB(255,255,255)
b.Style=6
b.Parent=a
local c=Instance.new"TextLabel"
c.Name="ActionText"
c.Size=UDim2.new(1,0,0.25,0)
c.BorderColor3=Color3.fromRGB(0,0,0)
c.BackgroundTransparency=1
c.BorderSizePixel=0
c.BackgroundColor3=Color3.fromRGB(255,255,255)
c.FontSize=5
c.TextStrokeTransparency=0
c.TextSize=14
c.TextColor3=Color3.fromRGB(255,0,0)
c.Text="DESYNC INACTIVE"
c.TextWrapped=true
c.TextWrap=true
c.Font=4
c.TextScaled=true
c.Parent=b
local d=Instance.new"Frame"
d.Name="Div"
d.Size=UDim2.new(1,0,0,1)
d.BorderColor3=Color3.fromRGB(0,0,0)
d.BackgroundTransparency=0.9
d.Position=UDim2.new(0,0,0.26,0)
d.BorderSizePixel=0
d.BackgroundColor3=Color3.fromRGB(255,255,255)
d.Parent=b
local e=Instance.new"TextButton"
e.Name="ActivateButton"
e.Size=UDim2.new(1,0,0.75,0)
e.BorderColor3=Color3.fromRGB(0,0,0)
e.BackgroundTransparency=1
e.Position=UDim2.new(0,0,0.25,0)
e.BorderSizePixel=0
e.BackgroundColor3=Color3.fromRGB(255,255,255)
e.FontSize=5
e.TextStrokeTransparency=0
e.TextSize=14
e.RichText=true
e.TextColor3=Color3.fromRGB(0,255,0)
e.Text="+"
e.TextWrapped=true
e.TextWrap=true
e.Font=4
e.TextScaled=true
e.Parent=b
a.Parent=Player:WaitForChild"PlayerGui"

local screengui = a

function createRig()
	local a=Instance.new"Model"
	a.Name="DesyncPosition"
	a.WorldPivot=CFrame.new(-0.09999990463256836,1,0.19999909400939941)
	local b=Instance.new"Part"
	b.Name="Head"
	b.CFrame=CFrame.new(-0.09999990463256836,5.5,0.19999909400939941)
	b.CanCollide=false
	b.TopSurface=0
	b.Color=Color3.fromRGB(127,127,127)
	b.Size=Vector3.new(2,1,1)
	b.PivotOffset=CFrame.new(0,-4.5,0)
	b.formFactor=0
	b.Parent=a
	local c=Instance.new"SpecialMesh"
	c.Scale=Vector3.new(1.25,1.25,1.25)
	c.Parent=b
	local d=Instance.new"Decal"
	d.Name="face"
	d.Texture="rbxasset://textures/face.png"
	d.ColorMap="rbxasset://textures/face.png"
	d.Parent=b
	local e=Instance.new"Part"
	e.Name="Torso"
	e.RightParamB=0
	e.CFrame=CFrame.new(-0.09999990463256836,4,0.19999909400939941)
	e.CanCollide=false
	e.RightParamA=0
	e.Color=Color3.fromRGB(127,127,127)
	e.RightSurface=2
	e.Size=Vector3.new(2,2,1)
	e.LeftSurface=2
	e.LeftParamB=0
	e.LeftParamA=0
	e.formFactor=0
	e.Parent=a
	local f=Instance.new"Motor6D"
	f.Name="Right Shoulder"
	f.C1=CFrame.new(-0.5,0.5,0,0,0,1,0,1,0,-1,-0,-0)
	f.C0=CFrame.new(1,0.5,0,0,0,1,0,1,0,-1,-0,-0)
	f.MaxVelocity=0.1
	f.Parent=e
	local g=Instance.new"Motor6D"
	g.Name="Left Shoulder"
	g.C1=CFrame.new(0.5,0.5,0,-0,-0,-1,0,1,0,1,0,0)
	g.C0=CFrame.new(-1,0.5,0,-0,-0,-1,0,1,0,1,0,0)
	g.MaxVelocity=0.1
	g.Parent=e
	local h=Instance.new"Motor6D"
	h.Name="Right Hip"
	h.C1=CFrame.new(0.5,1,0,0,0,1,0,1,0,-1,-0,-0)
	h.C0=CFrame.new(1,-1,0,0,0,1,0,1,0,-1,-0,-0)
	h.MaxVelocity=0.1
	h.Parent=e
	local i=Instance.new"Motor6D"
	i.Name="Left Hip"
	i.C1=CFrame.new(-0.5,1,0,-0,-0,-1,0,1,0,1,0,0)
	i.C0=CFrame.new(-1,-1,0,-0,-0,-1,0,1,0,1,0,0)
	i.MaxVelocity=0.1
	i.Parent=e
	local j=Instance.new"Motor6D"
	j.Name="Neck"
	j.C1=CFrame.new(0,-0.5,0,-1,-0,-0,0,0,1,0,1,0)
	j.C0=CFrame.new(0,1,0,-1,-0,-0,0,0,1,0,1,0)
	j.MaxVelocity=0.1
	j.Parent=e
	local k=Instance.new"Part"
	k.Name="Left Arm"
	k.CFrame=CFrame.new(-1.5999999046325684,4,0.19999909400939941)
	k.CanCollide=false
	k.Color=Color3.fromRGB(127,127,127)
	k.Size=Vector3.new(1,2,1)
	k.formFactor=0
	k.Parent=a
	local l=Instance.new"Part"
	l.Name="Right Arm"
	l.CFrame=CFrame.new(1.4000000953674316,4,0.19999909400939941)
	l.CanCollide=false
	l.Color=Color3.fromRGB(127,127,127)
	l.Size=Vector3.new(1,2,1)
	l.formFactor=0
	l.Parent=a
	local m=Instance.new"Part"
	m.Name="Left Leg"
	m.CFrame=CFrame.new(-0.5999999046325684,2,0.19999909400939941)
	m.BottomSurface=0
	m.CanCollide=false
	m.Color=Color3.fromRGB(127,127,127)
	m.Size=Vector3.new(1,2,1)
	m.formFactor=0
	m.Parent=a
	local n=Instance.new"Part"
	n.Name="Right Leg"
	n.CFrame=CFrame.new(0.40000009536743164,2,0.19999909400939941)
	n.BottomSurface=0
	n.CanCollide=false
	n.Color=Color3.fromRGB(127,127,127)
	n.Size=Vector3.new(1,2,1)
	n.formFactor=0
	n.Parent=a
	local o=Instance.new"Humanoid"
	o.Parent=a
	local q=Instance.new"Animator"
	q.Parent=o
	local r=Instance.new"HumanoidDescription"
	r.ProportionScale=0
	r.TorsoColor=Color3.fromRGB(128,128,128)
	r.RightLegColor=Color3.fromRGB(128,128,128)
	r.LeftLegColor=Color3.fromRGB(128,128,128)
	r.BodyTypeScale=0
	r.LeftArmColor=Color3.fromRGB(128,128,128)
	r.HeadColor=Color3.fromRGB(128,128,128)
	r.RightArmColor=Color3.fromRGB(128,128,128)
	r.Parent=o
	local s=Instance.new"BodyPartDescription"
	s.Color=Color3.fromRGB(128,128,128)
	s.Parent=r
	local t=Instance.new"BodyPartDescription"
	t.Color=Color3.fromRGB(128,128,128)
	t.BodyPart=2
	t.Parent=r
	local u=Instance.new"BodyPartDescription"
	u.Color=Color3.fromRGB(128,128,128)
	u.BodyPart=4
	u.Parent=r
	local v=Instance.new"BodyPartDescription"
	v.Color=Color3.fromRGB(128,128,128)
	v.BodyPart=3
	v.Parent=r
	local w=Instance.new"BodyPartDescription"
	w.Color=Color3.fromRGB(128,128,128)
	w.BodyPart=5
	w.Parent=r
	local x=Instance.new"BodyPartDescription"
	x.Color=Color3.fromRGB(128,128,128)
	x.BodyPart=1
	x.Parent=r
	local y=Instance.new"Part"
	y.Name="HumanoidRootPart"
	y.RightParamB=0
	y.CFrame=CFrame.new(-0.09999990463256836,4,0.19999909400939941)
	y.BottomSurface=0
	y.CanCollide=false
	y.Transparency=1
	y.TopSurface=0
	y.RightParamA=0
	y.Size=Vector3.new(2,2,1)
	y.LeftParamB=0
	y.Anchored=true
	y.LeftParamA=0
	y.formFactor=0
	y.Parent=a
	local z=Instance.new"Motor6D"
	z.Name="RootJoint"
	z.C1=CFrame.new(0,0,0,-1,-0,-0,0,0,1,0,1,0)
	z.C0=CFrame.new(0,0,0,-1,-0,-0,0,0,1,0,1,0)
	z.MaxVelocity=0.1
	z.Parent=y
	local A=Instance.new"BodyColors"
	A.LeftArmColor3=Color3.fromRGB(128,128,128)
	A.HeadColor3=Color3.fromRGB(128,128,128)
	A.TorsoColor3=Color3.fromRGB(128,128,128)
	A.LeftLegColor3=Color3.fromRGB(128,128,128)
	A.RightLegColor3=Color3.fromRGB(128,128,128)
	A.RightArmColor3=Color3.fromRGB(128,128,128)
	A.Parent=a
	f.Part1=l
	f.Part0=e
	g.Part1=k
	g.Part0=e
	h.Part1=n
	h.Part0=e
	i.Part1=m
	i.Part0=e
	j.Part1=b
	j.Part0=e
	o.Torso=y
	o.RightLeg=n
	o.LeftLeg=m
	z.Part1=e
	z.Part0=y
	a.PrimaryPart=b

	return a
end

function fixcam(speaker)
	workspace.CurrentCamera:remove()
	wait(.1)
	repeat wait() until speaker.Character ~= nil
	workspace.CurrentCamera.CameraSubject = speaker.Character:FindFirstChildWhichIsA('Humanoid')
	workspace.CurrentCamera.CameraType = "Custom"
	speaker.CameraMinZoomDistance = 0.5
	speaker.CameraMaxZoomDistance = 400
	speaker.CameraMode = "Classic"
	speaker.Character.Head.Anchored = false
end

local invisRunning = false
local tur
function invisible(args, speaker)
	if invisRunning then return end
	invisRunning = true
	-- Full credit to AmokahFox @V3rmillion
	local Player = speaker
	repeat wait(.1) until Player.Character
	local Character = Player.Character
	Character.Archivable = true
	local IsInvis = false
	local IsRunning = true
	local InvisibleCharacter = Character:Clone()
	InvisibleCharacter.Parent = Lighting
	local Void = workspace.FallenPartsDestroyHeight
	InvisibleCharacter.Name = ""
	local CF

	local invisFix = RunService.Stepped:Connect(function()
		pcall(function()
			local IsInteger
			if tostring(Void):find'-' then
				IsInteger = true
			else
				IsInteger = false
			end
			local Pos = Player.Character.Humanoid.RootPart.Position
			local Pos_String = tostring(Pos)
			local Pos_Seperate = Pos_String:split(', ')
			local X = tonumber(Pos_Seperate[1])
			local Y = tonumber(Pos_Seperate[2])
			local Z = tonumber(Pos_Seperate[3])
			if IsInteger == true then
				if Y <= Void then
					Respawn()
				end
			elseif IsInteger == false then
				if Y >= Void then
					Respawn()
				end
			end
		end)
	end)

	for i,v in pairs(InvisibleCharacter:GetDescendants())do
		if v:IsA("BasePart") then
			if v.Name == "HumanoidRootPart" then
				v.Transparency = 1
			else
				v.Transparency = .5
			end
		end
	end

	function Respawn()
		IsRunning = false
		if IsInvis == true then
			pcall(function()
				Player.Character = Character
				wait()
				Character.Parent = workspace
				Character:FindFirstChildWhichIsA'Humanoid':Destroy()
				IsInvis = false
				InvisibleCharacter.Parent = nil
				invisRunning = false
			end)
		elseif IsInvis == false then
			pcall(function()
				Player.Character = Character
				wait()
				Character.Parent = workspace
				Character:FindFirstChildWhichIsA'Humanoid':Destroy()
				TurnVisible()
			end)
		end
	end

	local invisDied
	invisDied = InvisibleCharacter:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
		Respawn()
		invisDied:Disconnect()
	end)

	if IsInvis == true then return end
	IsInvis = true
	CF = workspace.CurrentCamera.CFrame
	local CF_1 = Player.Character.Humanoid.RootPart.CFrame
	local rig = createRig()
	rig.Parent = workspace
	rig.HumanoidRootPart.CFrame = CF_1
	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	wait(.2)
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	InvisibleCharacter = InvisibleCharacter
	Character.Parent = Lighting
	InvisibleCharacter.Parent = workspace
	InvisibleCharacter.Humanoid.RootPart.CFrame = CF_1
	Player.Character = InvisibleCharacter
	fixcam(Player)
	Player.Character.Animate.Disabled = true
	Player.Character.Animate.Disabled = false

	function TurnVisible()
		if IsInvis == false then return end
		invisFix:Disconnect()
		invisDied:Disconnect()
		CF = workspace.CurrentCamera.CFrame
		Character = Character
		local CF_1 = Player.Character.Humanoid.RootPart.CFrame
		Character.Humanoid.RootPart.CFrame = CF_1
		InvisibleCharacter:Destroy()
		rig:Destroy()
		Player.Character = Character
		Character.Parent = workspace
		IsInvis = false
		Player.Character.Animate.Disabled = true
		Player.Character.Animate.Disabled = false
		invisDied = Character:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
			Respawn()
			invisDied:Disconnect()
		end)
		invisRunning = false
	end
end

function visible()
	TurnVisible()
end

--//next\\

local uis = game:GetService("UserInputService")

uis.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.F and not gameProcessedEvent then
		if invisRunning then
			visible(nil, Player)
			screengui.Main.ActionText.Text = "DESYNC INACTIVE"
			screengui.Main.ActionText.TextColor3 = Color3.new(1,0,0)
			screengui.Main.ActivateButton.Text = "+"
			screengui.Main.ActivateButton.TextColor3 = Color3.new(0,1,0)
		else
			invisible(nil, Player)
			screengui.Main.ActionText.Text = "DESYNC ACTIVE"
			screengui.Main.ActionText.TextColor3 = Color3.new(0,1,0)
			screengui.Main.ActivateButton.Text = "-"
			screengui.Main.ActivateButton.TextColor3 = Color3.new(1,0,0)
		end
	end
end)

screengui.Main.ActivateButton.Activated:Connect(function()
	if invisRunning then
		visible(nil, Player)
		screengui.Main.ActionText.Text = "DESYNC INACTIVE"
		screengui.Main.ActionText.TextColor3 = Color3.new(1,0,0)
		screengui.Main.ActivateButton.Text = "+"
		screengui.Main.ActivateButton.TextColor3 = Color3.new(0,1,0)
	else
		invisible(nil, Player)
		screengui.Main.ActionText.Text = "DESYNC ACTIVE"
		screengui.Main.ActionText.TextColor3 = Color3.new(0,1,0)
		screengui.Main.ActivateButton.Text = "-"
		screengui.Main.ActivateButton.TextColor3 = Color3.new(1,0,0)
	end
end)

