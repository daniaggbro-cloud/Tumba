-- Core.lua - Базовые импорты, константы и инициализация Mega
-- TUMBA MEGA CHEAT SYSTEM v5.0

if not game:IsLoaded() then
    game.Loaded:Wait()
end

--=== МЕГА-ИМПОРТ СИСТЕМ ===--
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")

--=== МЕГА-КОНСТАНТЫ ===--
local VERSION = "5.0.0"
local BUILD_DATE = "2024.01.15"
local DEVELOPER = "I.S.-1"
local SPECIAL_THANKS = "N.User-1"

--=== МЕГА-ПЕРЕМЕННЫЕ ===--
local Mega = {
    Settings = {
        Menu = {
            Width = 900,
            Height = 500,
            BackgroundColor = Color3.fromRGB(10, 10, 25),
            TitleBarColor = Color3.fromRGB(0, 100, 200),
            AccentColor = Color3.fromRGB(0, 180, 255),
            TextColor = Color3.fromRGB(255, 255, 255),
            Transparency = 0.05,
            CornerRadius = 15,
            AnimationSpeed = 0.3
        },
        System = {
            AntiAFK = true,
            AutoSaveConfig = true,
            PerformanceMode = false,
            DebugMode = false,
            Logging = true
        }
    },
    States = {
        ESP = {
            Enabled = false,
            Boxes = true,
            Names = true,
            Distance = true,
            Health = true,
            Tracers = true,
            ShowTeam = false,
            MaxDistance = 1000,
            TeamColor = Color3.fromRGB(0, 255, 0),
            EnemyColor = Color3.fromRGB(255, 0, 0),
            NeutralColor = Color3.fromRGB(255, 255, 0)
        },
        KitESP = {
            Enabled = false,
            BoxColor = Color3.fromRGB(255, 165, 0),
            TextColor = Color3.fromRGB(255, 255, 255),
            MaxDistance = 500,
            Filters = {
                Iron = true,
                Bee = true,
                NatureEssence = true,
                Thorns = true,
                Mushrooms = true,
                CritStar = true,
                VitalityStar = true
            }
        },
        AimAssist = {
            Enabled = false,
            Active = false,
            Key = Enum.KeyCode.R,
            FOV = 120,
            Smoothness = 0.4,
            Range = 100,
            Prediction = true,
            SilentAim = false,
            TargetPart = "Head",
            ShowFOV = true,
            FOVColor = Color3.fromRGB(0, 180, 255)
        },
        Visuals = {
            NoFog = false,
            FullBright = false,
            Chams = false,
            NightMode = false,
            RemoveShadows = false
        },
        Player = {
            Fly = false,
            Speed = false,
            SpeedValue = 100,
            Noclip = false,
            GodMode = false,
            InfiniteJump = false,
            NoClip = false,
            FollowTarget = nil
        },
        Combat = {
            TriggerBot = false,
            AutoShoot = false,
            RapidFire = false,
            NoRecoil = false,
            NoSpread = false
        },
        Misc = {
            FameSpam = false,
            AutoFarm = false,
            CollectItems = false,
            AntiStun = false,
            AntiGrab = false
        },
        Keybinds = {
            Menu = "RightShift",
            AimAssist = "R"
        }
    },
    Database = {
        Configs = {},
        Stats = {
            Kills = 0,
            Deaths = 0,
            Headshots = 0,
            PlayTime = 0,
            ConfigSaves = 0
        }
    },
    Objects = {
        ESP = {},
        KitESPObjects = {},
        Connections = {},
        GUI = nil,
        PlayerListItems = {}
    },
    -- === НОВАЯ СИСТЕМА ЛОКАЛИЗАЦИИ ===
    Localization = {
        CurrentLanguage = "en", -- Устанавливается при выборе
        Strings = {} -- Загружается из Localization.lua
    }
}

-- === НОВЫЙ "ПЕРЕВОДЧИК" ===
---@param key string
---@vararg any
---@return string
local function GetText(key, ...)
    local lang = Mega.Localization.CurrentLanguage
    local str = Mega.Localization.Strings[key]

    if str and str[lang] then
        local text = str[lang]
        local args = {...}
        if #args > 0 then
            -- Используем pcall для безопасности, если форматирование не удастся
            local success, result = pcall(string.format, text, ...)
            if success then
                return result
            else
                return text -- Возвращаем исходный текст, если форматирование не удалось
            end
        else
            return text
        end
    else
        return key -- Возвращаем ключ, если перевод не найден
    end
end

return {
    Mega = Mega,
    GetText = GetText,
    VERSION = VERSION,
    BUILD_DATE = BUILD_DATE,
    DEVELOPER = DEVELOPER,
    SPECIAL_THANKS = SPECIAL_THANKS
}
