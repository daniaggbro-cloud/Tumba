-- Aim.lua - Aim Assist functions for TUMBA MEGA SYSTEM v5.0

local TumbaModules = game:GetService("ReplicatedStorage"):WaitForChild("TumbaModules")
local Core = require(TumbaModules.Core)
local Mega = Core.Mega
local GetText = Core.GetText

local AimFOVCircle = nil
local AimLoopConnection = nil
local CurrentAimTarget = nil

function CreateAimFOV()
    if AimFOVCircle then
        AimFOVCircle:Remove()
    end

    AimFOVCircle = Drawing.new("Circle")
    AimFOVCircle.Visible = Mega.States.AimAssist.Enabled and Mega.States.AimAssist.ShowFOV
    AimFOVCircle.Color = Mega.States.AimAssist.FOVColor
    AimFOVCircle.Thickness = 2
    AimFOVCircle.NumSides = 100
    AimFOVCircle.Radius = Mega.States.AimAssist.FOV
    AimFOVCircle.Filled = false
end

function GetClosestPlayer()
    local closestPlayer = nil
    local closestDistance = Mega.States.AimAssist.FOV

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local character = player.Character
            local targetPart = character:FindFirstChild(Mega.States.AimAssist.TargetPart) or character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

            if targetPart and humanoidRootPart then
                local distanceToPlayer = (humanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

                if distanceToPlayer <= Mega.States.AimAssist.Range then
                    local isEnemy = true
                    if player.Team and game.Players.LocalPlayer.Team then
                        isEnemy = player.Team ~= game.Players.LocalPlayer.Team
                    end

                    if isEnemy then
                        local screenPoint, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(targetPart.Position)

                        if onScreen then
                            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                            local distance = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude

                            if distance < closestDistance then
                                closestDistance = distance
                                closestPlayer = player
                            end
                        end
                    end
                end
            end
        end
    end

    return closestPlayer
end

function AimAtPlayer(player)
    if not player or not player.Character then return end

    local character = player.Character
    local targetPart = character:FindFirstChild(Mega.States.AimAssist.TargetPart) or character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    if not targetPart then return end

    local camera = game.Workspace.CurrentCamera

    local targetPosition = targetPart.Position
    local direction = (targetPosition - camera.CFrame.Position).Unit

    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPosition)
    local smoothCFrame = currentCFrame:Lerp(targetCFrame, Mega.States.AimAssist.Smoothness)

    camera.CFrame = smoothCFrame
end

function StartAimLoop()
    if AimLoopConnection then
        AimLoopConnection:Disconnect()
    end

    AimLoopConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if Mega.States.AimAssist.Active and Mega.States.AimAssist.Enabled then
            CurrentAimTarget = GetClosestPlayer()
            if CurrentAimTarget then
                AimAtPlayer(CurrentAimTarget)
            else
                CurrentAimTarget = nil
            end
        end
    end)
end

function StopAimLoop()
    if AimLoopConnection then
        AimLoopConnection:Disconnect()
        AimLoopConnection = nil
    end
    CurrentAimTarget = nil
end

return {
    CreateAimFOV = CreateAimFOV,
    GetClosestPlayer = GetClosestPlayer,
    AimAtPlayer = AimAtPlayer,
    StartAimLoop = StartAimLoop,
    StopAimLoop = StopAimLoop,
    AimFOVCircle = AimFOVCircle
}
