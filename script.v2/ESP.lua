-- ESP.lua - ESP functions for TUMBA MEGA SYSTEM v5.0

local TumbaModules = game:GetService("ReplicatedStorage"):WaitForChild("TumbaModules")
local Core = require(TumbaModules.Core)
local Mega = Core.Mega
local GetText = Core.GetText

function CreateESP(player)
    if player == game.Players.LocalPlayer then return end

    local esp = {
        box = Drawing.new("Square"),
        name = Drawing.new("Text"),
        distance = Drawing.new("Text"),
        health = Drawing.new("Text"),
        tracer = Drawing.new("Line")
    }

    esp.box.Visible = false
    esp.box.Thickness = 2
    esp.box.Filled = false
    esp.box.ZIndex = 1

    esp.name.Visible = false
    esp.name.Size = 14
    esp.name.Center = true
    esp.name.Outline = true
    esp.name.ZIndex = 1

    esp.distance.Visible = false
    esp.distance.Size = 12
    esp.distance.Center = true
    esp.distance.Outline = true
    esp.distance.ZIndex = 1

    esp.health.Visible = false
    esp.health.Size = 12
    esp.health.Center = true
    esp.health.Outline = true
    esp.health.ZIndex = 1

    esp.tracer.Visible = false
    esp.tracer.Thickness = 1
    esp.tracer.ZIndex = 1

    Mega.Objects.ESP[player] = esp
end

function RemoveESP(player)
    if Mega.Objects.ESP[player] then
        for _, drawing in pairs(Mega.Objects.ESP[player]) do
            drawing:Remove()
        end
        Mega.Objects.ESP[player] = nil
    end
end

function UpdateESPColors()
    for player, esp in pairs(Mega.Objects.ESP) do
        if player and player.Character and player.Team then
            local isTeam = Mega.States.ESP.ShowTeam and player.Team == game.Players.LocalPlayer.Team
            local isEnemy = player.Team ~= game.Players.LocalPlayer.Team

            if isTeam then
                esp.box.Color = Mega.States.ESP.TeamColor
                esp.name.Color = Mega.States.ESP.TeamColor
                esp.distance.Color = Mega.States.ESP.TeamColor
                esp.health.Color = Mega.States.ESP.TeamColor
                esp.tracer.Color = Mega.States.ESP.TeamColor
            elseif isEnemy then
                esp.box.Color = Mega.States.ESP.EnemyColor
                esp.name.Color = Mega.States.ESP.EnemyColor
                esp.distance.Color = Mega.States.ESP.EnemyColor
                esp.health.Color = Mega.States.ESP.EnemyColor
                esp.tracer.Color = Mega.States.ESP.EnemyColor
            else
                esp.box.Color = Mega.States.ESP.NeutralColor
                esp.name.Color = Mega.States.ESP.NeutralColor
                esp.distance.Color = Mega.States.ESP.NeutralColor
                esp.health.Color = Mega.States.ESP.NeutralColor
                esp.tracer.Color = Mega.States.ESP.NeutralColor
            end
        end
    end
end

function UpdateESP()
    local camera = game.Workspace.CurrentCamera
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)

    for player, esp in pairs(Mega.Objects.ESP) do
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            local head = player.Character:FindFirstChild("Head")
            local humanoid = player.Character:FindFirstChild("Humanoid")

            if head and humanoid then
                local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude

                if onScreen and distance <= Mega.States.ESP.MaxDistance then
                    local scale = 1000 / distance
                    local width = scale * 2
                    local height = scale * 3

                    if Mega.States.ESP.Boxes then
                        esp.box.Visible = Mega.States.ESP.Enabled
                        esp.box.Position = Vector2.new(screenPos.X - width / 2, screenPos.Y - height / 2)
                        esp.box.Size = Vector2.new(width, height)
                    else
                        esp.box.Visible = false
                    end

                    if Mega.States.ESP.Names then
                        esp.name.Visible = Mega.States.ESP.Enabled
                        esp.name.Position = Vector2.new(screenPos.X, screenPos.Y - height / 2 - 20)
                        esp.name.Text = player.Name
                    else
                        esp.name.Visible = false
                    end

                    if Mega.States.ESP.Distance then
                        esp.distance.Visible = Mega.States.ESP.Enabled
                        esp.distance.Position = Vector2.new(screenPos.X, screenPos.Y + height / 2 + 10)
                        esp.distance.Text = GetText("esp_studs", math.floor(distance))
                    else
                        esp.distance.Visible = false
                    end

                    if Mega.States.ESP.Health then
                        esp.health.Visible = Mega.States.ESP.Enabled
                        esp.health.Position = Vector2.new(screenPos.X, screenPos.Y + height / 2 + 30)
                        esp.health.Text = GetText("esp_hp", math.floor(humanoid.Health))
                    else
                        esp.health.Visible = false
                    end

                    if Mega.States.ESP.Tracers then
                        esp.tracer.Visible = Mega.States.ESP.Enabled
                        esp.tracer.From = Vector2.new(screenPos.X, screenPos.Y + height / 2)
                        esp.tracer.To = screenCenter
                    else
                        esp.tracer.Visible = false
                    end

                else
                    esp.box.Visible = false
                    esp.name.Visible = false
                    esp.distance.Visible = false
                    esp.health.Visible = false
                    esp.tracer.Visible = false
                end
            end
        else
            esp.box.Visible = false
            esp.name.Visible = false
            esp.distance.Visible = false
            esp.health.Visible = false
            esp.tracer.Visible = false
        end
    end
end

-- Kit ESP functions
local Icons = {
    ["iron"] = "rbxassetid://6850537969",
    ["bee"] = "rbxassetid://7343272839",
    ["natures_essence_1"] = "rbxassetid://11003449842",
    ["thorns"] = "rbxassetid://9134549615",
    ["mushrooms"] = "rbxassetid://9134534696",
    ["wild_flower"] = "rbxassetid://9134545166",
    ["crit_star"] = "rbxassetid://9866757805",
    ["vitality_star"] = "rbxassetid://9866757969"
}
local espobjs = Mega.Objects.KitESPObjects
local espfold = Instance.new("Folder")
espfold.Name = "KitESPFolder"
local hidden = true

local function showNotification(message)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 300, 0, 50)
    notification.Position = UDim2.new(0.5, -150, 0, 50)
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notification.TextColor3 = Color3.new(1, 1, 1)
    notification.Font = Enum.Font.SourceSansBold
    notification.TextSize = 20
    notification.Text = message
    notification.AnchorPoint = Vector2.new(0.5, 0)
    notification.Parent = Mega.Objects.GUI

    game.Debris:AddItem(notification, 3)
end

local function espadd(v, icon)
    local billboard = Instance.new("BillboardGui")
    billboard.Parent = espfold
    billboard.Name = "iron"
    billboard.StudsOffsetWorldSpace = Vector3.new(0, 3, 1.5)
    billboard.Size = UDim2.new(0, 32, 0, 32)
    billboard.AlwaysOnTop = true
    billboard.Adornee = v
    local image = Instance.new("ImageLabel")
    image.BackgroundTransparency = 0.5
    image.BorderSizePixel = 0
    image.Image = Icons[icon] or ""
    image.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    image.Size = UDim2.new(0, 32, 0, 32)
    image.AnchorPoint = Vector2.new(0.5, 0.5)
    image.Parent = billboard
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 4)
    uicorner.Parent = image
    espobjs[v] = billboard
end

local kitConnections = {}

local function resetKit()
    for _, v in pairs(kitConnections) do
        pcall(function() v:Disconnect() end)
    end
    table.clear(kitConnections)
    espfold:ClearAllChildren()
    table.clear(espobjs)
end

local function addKit(tag, icon, custom)
    if not custom then
        local con1 = game:GetService("CollectionService"):GetInstanceAddedSignal(tag):Connect(function(v)
            if Mega.States.KitESP.Enabled then
                espadd(v.PrimaryPart, icon)
            end
        end)
        local con2 = game:GetService("CollectionService"):GetInstanceRemovedSignal(tag):Connect(function(v)
            if espobjs[v.PrimaryPart] then
                espobjs[v.PrimaryPart]:Destroy()
                espobjs[v.PrimaryPart] = nil
            end
        end)
        table.insert(kitConnections, con1)
        table.insert(kitConnections, con2)
        for _, v in pairs(game:GetService("CollectionService"):GetTagged(tag)) do
            if Mega.States.KitESP.Enabled then
                espadd(v.PrimaryPart, icon)
            end
        end
    else
        local function check(v)
            if v.Name == tag and v.ClassName == "Model" and Mega.States.KitESP.Enabled then
                espadd(v.PrimaryPart, icon)
            end
        end
        local conAdded = game.Workspace.ChildAdded:Connect(check)
        local conRemoved = game.Workspace.ChildRemoved:Connect(function(v)
            pcall(function()
                if espobjs[v.PrimaryPart] then
                    espobjs[v.PrimaryPart]:Destroy()
                    espobjs[v.PrimaryPart] = nil
                end
            end)
        end)
        table.insert(kitConnections, conAdded)
        table.insert(kitConnections, conRemoved)
        for _, v in pairs(game.Workspace:GetChildren()) do
            check(v)
        end
    end
end

function recreateKitESP()
    resetKit()

    if not Mega.States.KitESP.Enabled then return end

    local filters = Mega.States.KitESP.Filters

    if filters.Iron then
        addKit("hidden-metal", "iron")
    end
    if filters.Bee then
        addKit("bee", "bee")
    end
    if filters.NatureEssence then
        addKit("treeOrb", "natures_essence_1")
    end
    if filters.Thorns then
        addKit("Thorns", "thorns", true)
    end
    if filters.Mushrooms then
        addKit("Mushrooms", "mushrooms", true)
    end
    if filters.CritStar then
        addKit("CritStar", "crit_star", true)
    end
    if filters.VitalityStar then
        addKit("VitalityStar", "vitality_star", true)
    end

    if espfold.Parent then
        hidden = false
    end
end

return {
    CreateESP = CreateESP,
    RemoveESP = RemoveESP,
    UpdateESPColors = UpdateESPColors,
    UpdateESP = UpdateESP,
    recreateKitESP = recreateKitESP,
    showNotification = showNotification,
    espfold = espfold
}
