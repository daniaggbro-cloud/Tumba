-- Player.lua - Player hacks for TUMBA MEGA SYSTEM v5.0

local TumbaModules = game:GetService("ReplicatedStorage"):WaitForChild("TumbaModules")
local Core = require(TumbaModules.Core)
local ESP = require(TumbaModules.ESP)
local Mega = Core.Mega
local GetText = Core.GetText

function ToggleFly(state)
    if state then
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = character.HumanoidRootPart
            local BodyGyro = Instance.new("BodyGyro")
            local BodyVelocity = Instance.new("BodyVelocity")

            BodyGyro.Parent = humanoidRootPart
            BodyVelocity.Parent = humanoidRootPart
            BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)

            Mega.Objects.Connections.Fly = game:GetService("RunService").Heartbeat:Connect(function()
                if character and humanoidRootPart then
                    BodyGyro.CFrame = game.Workspace.CurrentCamera.CFrame
                    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
            end)
        end
    else
        if Mega.Objects.Connections.Fly then
            Mega.Objects.Connections.Fly:Disconnect()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function() game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyGyro"):Destroy() end)
                pcall(function() game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity"):Destroy() end)
            end
        end
    end
end

function ToggleSpeed(state)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        if state then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Mega.States.Player.SpeedValue + math.random(-3, 3)
            print(GetText("print_speed_on", Mega.States.Player.SpeedValue))
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            print(GetText("print_speed_off"))
        end
    end
end

function ToggleInfiniteJump(state)
    if state then
        Mega.Objects.Connections.InfiniteJump = game:GetService("UserInputService").JumpRequest:Connect(function()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    else
        if Mega.Objects.Connections.InfiniteJump then
            Mega.Objects.Connections.InfiniteJump:Disconnect()
        end
    end
end

function ToggleGodMode(state)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        if state then
            character.Humanoid.MaxHealth = math.huge
            character.Humanoid.Health = math.huge
        else
            character.Humanoid.MaxHealth = 100
            character.Humanoid.Health = 100
        end
    end
end

function ToggleNoclip(state)
    if state then
        Mega.Objects.Connections.NoClip = game:GetService("RunService").Stepped:Connect(function()
            if game.Players.LocalPlayer.Character then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if Mega.Objects.Connections.NoClip then
            Mega.Objects.Connections.NoClip:Disconnect()
        end
    end
end

function StartFollow(player)
    if player == game.Players.LocalPlayer then return end
    Mega.States.Player.FollowTarget = player
    ESP.showNotification(GetText("notify_follow_start", player.Name))
end

function StopFollow()
    Mega.States.Player.FollowTarget = nil
    game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    ESP.showNotification(GetText("notify_follow_stop"))
end

return {
    ToggleFly = ToggleFly,
    ToggleSpeed = ToggleSpeed,
    ToggleInfiniteJump = ToggleInfiniteJump,
    ToggleGodMode = ToggleGodMode,
    ToggleNoclip = ToggleNoclip,
    StartFollow = StartFollow,
    StopFollow = StopFollow
}
