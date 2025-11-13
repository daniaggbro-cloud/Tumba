-- Utils.lua - Utility functions for TUMBA MEGA SYSTEM v5.0

local TumbaModules = game:GetService("ReplicatedStorage"):WaitForChild("TumbaModules")
local Core = require(TumbaModules.Core)
local ESP = require(TumbaModules.ESP)
local Mega = Core.Mega
local GetText = Core.GetText

function ClearChat()
    task.spawn(function()
        for i = 1, 100 do
            pcall(function()
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(" ")
            end)
            task.wait(0.1)
        end
    end)
    ESP.showNotification(GetText("notify_chat_cleared"))
end

function TakeScreenshot()
    ESP.showNotification(GetText("notify_screenshot"))
end

function ServerInfo()
    local players = #game.Players:GetPlayers()
    local maxPlayers = game.Players.MaxPlayers
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

    print("🔍 " .. GetText("button_server_info"))
    print("🎮 Game: " .. gameName)
    print("👥 Players: " .. players .. "/" .. maxPlayers)
    print("🆔 Place ID: " .. game.PlaceId)
end

function ToggleFameSpam(state)
    Mega.States.Misc.FameSpam = state
    if state then
        local messages = {
            "GG EZ MY BOG TUMBA",
            "TUMBA CHEAT v5.0 - BEST IN THE WORLD",
            "I.S.-1 PROTECTS ME",
            "GET GOOD GET TUMBA",
            "N.User-1 APPROVED"
        }

        Mega.Objects.Connections.FameSpam = game:GetService("RunService").Heartbeat:Connect(function()
            local message = messages[math.random(1, #messages)]
            local success = pcall(function()
                if game:GetService("TextChatService") then
                    local channel = game:GetService("TextChatService").TextChannels:FindFirstChild("RBXGeneral")
                    if channel then
                        channel:SendAsync(message)
                        return true
                    end
                end
            end)

            if not success then
                pcall(function()
                    game.Players.LocalPlayer:Chat(message)
                end)
            end
            wait(2)
        end)
    else
        if Mega.Objects.Connections.FameSpam then
            Mega.Objects.Connections.FameSpam:Disconnect()
        end
    end
end

function ReloadScript()
    ESP.showNotification(GetText("notify_reload"))
    -- Reload logic
end

return {
    ClearChat = ClearChat,
    TakeScreenshot = TakeScreenshot,
    ServerInfo = ServerInfo,
    ToggleFameSpam = ToggleFameSpam,
    ReloadScript = ReloadScript
}
