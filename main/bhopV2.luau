-- YES THIS SCRIPT IS DECOMPILED
-- NO I DIDNT STEAL IT FROM SOMEONE ELSES GAME THIS IS FROM ONE OF MY OLDER GAMES ON AN ACCOUNT I DONT HAVE ACSESS TO ANYMORE

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local update
local setDeltaTime
local updateLoop

local v1, Character, v2, v3, HumanoidRootPart, v4, v5, v6, t1
local n1 = 0.016666666666666666
local v7, v8
local v9 = nil
local lookVector = nil
local BodyPosition, BodyVelocity, BodyForce, v10, v11, v12, v13, v14
local v15 = nil
local v16, v17, v18, v19, v20, v21, v22, v23, v24, v25

function init(p1, p2, p3) -- line: 42
    -- upvalues: v1 (ref), Character (ref), v2 (ref), v3 (ref), HumanoidRootPart (ref), v4 (ref), v5 (ref), t1 (ref), v10 (ref), v11 (ref), v12 (ref), v13 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), v20 (ref), v21 (ref), v22 (ref), v23 (ref), v24 (ref), v25 (ref)
    v1 = p1
    Character = v1.Character
    HumanoidRootPart = Character.HumanoidRootPart
    v2 = p2
    v3 = p3
    v5 = 0
    v4 = false
    t1 = {
        forward = 0,
        side = 0
    }
    v10 = 12500
    v11 = 8
    v12 = 250
    v13 = 20
    v14 = 10
    v15 = 3
    v16 = 0.5
    v17 = 52.5
    v18 = 4E+05
    v19 = 3E+05
    v20 = 0.6
    v21 = v15 + v16
    v22 = 125
    v23 = 14000
    v24 = 1500
    v25 = 0.4
end

function initBodyMovers() -- line: 73
    -- upvalues: HumanoidRootPart (ref), BodyPosition (ref), BodyVelocity (ref), BodyForce (ref), v22 (ref), v23 (ref), v24 (ref), v25 (ref)
    BodyPosition = Instance.new("BodyPosition", HumanoidRootPart)
    BodyPosition.Name = "movementPosition"
    BodyPosition.D = v22
    BodyPosition.P = v23
    BodyPosition.maxForce = Vector3.new()
    BodyPosition.position = Vector3.new()
    BodyVelocity = Instance.new("BodyVelocity", HumanoidRootPart)
    BodyVelocity.Name = "movementVelocity"
    BodyVelocity.P = v24
    BodyVelocity.maxForce = Vector3.new()
    BodyVelocity.velocity = Vector3.new()
    BodyForce = Instance.new("BodyForce", HumanoidRootPart)
    BodyForce.Name = "gravityForce"
    BodyForce.force = Vector3.new(0, (1 - v25) * 196.2, 0) * getCharacterMass()
end

update = function(p4) -- line: 92
    -- upvalues: v3 (ref), HumanoidRootPart (ref), v4 (ref), v5 (ref), v6 (ref), n1 (ref), v7 (ref), v8 (ref), v9 (ref), lookVector (ref)
    n1 = p4
    updateMoveInputSum()
    v9 = getYaw()
    lookVector = v9.lookVector

    if lookVector == nil then
        return
    end

    local v27, v28, _, v29, v30 = findCollisionRay()

    v7 = v29
    v8 = v30
    v4 = v27 ~= nil
    v5 = HumanoidRootPart.Velocity - Vector3.new(0, HumanoidRootPart.Velocity.y, 0)
    v6 = not not (v4 and (v3.Space or v6))
    setCharacterRotation()

    if v6 then
        jump()
    elseif v4 then
        run(v28)
    else
        air()
    end
end

function updateMoveInputSum() -- line: 123
    -- upvalues: v3 (ref), t1 (ref)
    t1.forward = v3.W == true and 1 or 0
    t1.forward = v3.S == true and t1.forward - 1 or t1.forward
    t1.side = v3.A == true and 1 or 0
    t1.side = v3.D == true and t1.side - 1 or t1.side
end

function findCollisionRay() -- line: 130
    -- upvalues: Character (ref), v2 (ref), v20 (ref), v21 (ref)
    local _CFrame = Character.HumanoidRootPart.CFrame
    local t6 = {
        Character,
        v2
    }
    local t7 = {
        Ray.new(Character.HumanoidRootPart.Position, (Vector3.new(0, -v21, 0))),
        Ray.new((_CFrame * CFrame.new(-0.8, 0, 0)).p, (Vector3.new(0, -v21, 0))),
        Ray.new((_CFrame * CFrame.new(0.8, 0, 0)).p, (Vector3.new(0, -v21, 0))),
        Ray.new((_CFrame * CFrame.new(0, 0, 0.8)).p, (Vector3.new(0, -v21, 0))),
        Ray.new((_CFrame * CFrame.new(0, 0, -0.8)).p, (Vector3.new(0, -v21, 0)))
    }
    local t8 = {}

    for i = 1, #t7 do
        local v40, v41, v42 = game.Workspace:FindPartOnRayWithIgnoreList(t7[i], t6)

        if v40 == nil then
            v41 = Vector3.new(0, -3E+06, 0)
        end

        if i == 1 then
            table.insert(t8, {
                v40,
                v41,
                v42
            })
        else
            local y = v41.y

            if y <= t8[#t8][2].y then
                table.insert(t8, {
                    v40,
                    v41,
                    v42
                })
            else
                for j = 1, #t8 do
                    if t8[j][2].y <= y then
                        table.insert(t8, j, {
                            v40,
                            v41,
                            v42
                        })
                    end
                end
            end
        end
    end

    local v43, v44 = getPartYRatio(t8[1][3])
    local n2 = 1

    while magnitude2D(v43, v44) > v20 and n2 < #t8 do
        local v45 = n2 + 1
        local v46, v47

        if t8[v45][1] then
            v46, v47 = getPartYRatio(t8[v45][3])
        else
            v47 = v44
            v46 = v43
        end

        v44 = v47
        n2 = v45
        v43 = v46
    end

    return t8[n2][1], t8[n2][2], t8[n2][3], v43, v44
end

function setCharacterRotation() -- line: 177
    -- upvalues: v2 (ref), HumanoidRootPart (ref)
    local v48 = HumanoidRootPart.Position + v2.CoordinateFrame.lookVector

    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(v48.x, HumanoidRootPart.Position.y, v48.z)))
    HumanoidRootPart.RotVelocity = Vector3.new()
end

function jump() -- line: 183
    -- upvalues: HumanoidRootPart (ref), v17 (ref)
    local HumanoidRootPart2 = HumanoidRootPart
    local x = HumanoidRootPart.Velocity.x
    local v49 = v17

    HumanoidRootPart2.Velocity = Vector3.new(x, v49, HumanoidRootPart.Velocity.z)
    game:GetService("SoundService").jump:Play()
    air()
end

function air() -- line: 189
    -- upvalues: HumanoidRootPart (ref), BodyPosition (ref), BodyVelocity (ref), v10 (ref), v11 (ref)
    BodyPosition.maxForce = Vector3.new()
    BodyVelocity.velocity = getMovementVelocity(HumanoidRootPart.Velocity, v10, v11)
    BodyVelocity.maxForce = getMovementVelocityAirForce()
end

function run(p5) -- line: 195
    -- upvalues: HumanoidRootPart (ref), n1 (ref), BodyPosition (ref), BodyVelocity (ref), v12 (ref), v13 (ref), v14 (ref), v15 (ref), v18 (ref), v24 (ref)
    local magnitude = HumanoidRootPart.Velocity.magnitude
    local Velocity = HumanoidRootPart.Velocity

    if magnitude ~= 0 then
        Velocity = Velocity * math.max(magnitude - magnitude * v14 * n1, 0) / magnitude
    end

    BodyPosition.position = p5 + Vector3.new(0, v15, 0)
    BodyPosition.maxForce = Vector3.new(0, v18, 0)
    BodyVelocity.velocity = getMovementVelocity(Velocity, v12, v13)

    local v53 = getMovementVelocityForce()

    BodyVelocity.maxForce = v53
    BodyVelocity.P = v24
end

function getMovementVelocity(p6, p7, p8) -- line: 212
    -- upvalues: t1 (ref), n1 (ref), v9 (ref), lookVector (ref)
    local unit = (lookVector * t1.forward + (v9 * CFrame.Angles(0, 1.5707963267948966, 0)).lookVector * t1.side).unit

    if t1.forward == 0 and t1.side == 0 then
        unit = Vector3.new(0, 0, 0)
    end

    local v56 = p6:Dot(unit)
    local v57 = p7 * n1

    if p8 < v56 + v57 then
        v57 = math.max(p8 - v56, 0)
    end

    return p6 + unit * v57
end

function getMovementVelocityForce() -- line: 230
    -- upvalues: v19 (ref)
    return (Vector3.new(v19, 0, v19))
end

function getMovementVelocityAirForce() -- line: 235
    -- upvalues: t1 (ref), v9 (ref), lookVector (ref), v19 (ref)
    local unit = (lookVector * t1.forward + (v9 * CFrame.Angles(0, 1.5707963267948966, 0)).lookVector * t1.side).unit

    if t1.forward == 0 and t1.side == 0 then
        unit = Vector3.new(0, 0, 0)
    end

    local v63 = math.abs(unit.x)
    local v64 = math.abs(unit.z)

    return (Vector3.new(v19 * v63, 0, v19 * v64))
end

function getPartYRatio(p9) -- line: 249
    -- upvalues: lookVector (ref)
    local v69 = Vector3.new(-p9.x, 0, -p9.z)

    if v69.magnitude == 0 then
        return 0, 0
    end

    local v70 = math.atan2(v69.magnitude, p9.y) / 1.5707963267948966
    local v71 = Vector3.new(lookVector.x, 0, lookVector.z) * v70

    return v71:Dot(v69), -v69:Cross(v71).y
end

function getYaw() -- line: 260
    -- upvalues: v2 (ref)
    return v2.CoordinateFrame * CFrame.Angles(-getPitch(), 0, 0)
end

function getPitch() -- line: 264
    -- upvalues: v2 (ref)
    return 1.5707963267948966 - math.acos((v2.CoordinateFrame.lookVector:Dot((Vector3.new(0, 1, 0)))))
end

function getCharacterMass() -- line: 268
    -- upvalues: Character (ref)
    return Character.HumanoidRootPart:GetMass() + Character.Head:GetMass()
end

function magnitude2D(p10, p11) -- line: 272
    return (math.sqrt(p10 * p10 + p11 * p11))
end

local t12 = {
    W = false,
    S = false,
    A = false,
    D = false,
    Space = false,
    LMB = false,
    RMB = false
}
local LocalPlayer = game:GetService("Players").LocalPlayer

script.Parent = LocalPlayer.PlayerGui

local CurrentCamera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")

function onInput(p12, _) -- line: 288
    -- upvalues: t12 (copy)
    local v74 = false

    if p12.UserInputState == Enum.UserInputState.Begin then
        v74 = true
    elseif p12.UserInputState ~= Enum.UserInputState.End then
        return
    end

    if p12.UserInputType == Enum.UserInputType.Keyboard then
        local Name = p12.KeyCode.Name

        if t12[Name] ~= nil then
            t12[Name] = v74
        end
    elseif p12.UserInputType == Enum.UserInputType.MouseButton1 then
        t12.LMB = v74
    elseif p12.UserInputType == Enum.UserInputType.MouseButton2 then
        t12.RMB = v74
    end
end

function main() -- line: 310
    -- upvalues: t12 (copy), LocalPlayer (copy), CurrentCamera (copy), UserInputService (copy)
    local v75 = LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or LocalPlayer.Character:WaitForChild("Humanoid")

    v75.JumpPower = 50
    v75.PlatformStand = true
    init(LocalPlayer, CurrentCamera, t12)
    initBodyMovers()
    UserInputService.InputBegan:connect(onInput)
    UserInputService.InputEnded:connect(onInput)
    game:GetService("RunService"):BindToRenderStep("updateLoop", 1, updateLoop)
    task.wait(3)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Run",
        Duration = 5
    })
end

local v76
local n3 = 0.016666666666666666

setDeltaTime = function() -- line: 337
    -- upvalues: v76 (ref), n3 (ref)
    local v77 = tick()

    n3 = if v76 ~= nil then v77 - v76 else 0.016666666666666666
    v76 = v77
end

local RunService = game:GetService("RunService")

updateLoop = function(deltaTime)
    update(deltaTime)
end

RunService:BindToRenderStep("updateLoop", 1, updateLoop)

main()
