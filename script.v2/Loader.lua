-- Loader.lua - Загрузчик модулей для TUMBA MEGA SYSTEM v5.0
-- Помести в ReplicatedStorage или другое место, где require работает

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Создаем папку для модулей, если не существует
local ModulesFolder = ReplicatedStorage:FindFirstChild("TumbaModules")
if not ModulesFolder then
    ModulesFolder = Instance.new("Folder")
    ModulesFolder.Name = "TumbaModules"
    ModulesFolder.Parent = ReplicatedStorage
end

-- Загружаем все модули
local Core = require(ModulesFolder.Core)
local Localization = require(ModulesFolder.Localization)
local GUI = require(ModulesFolder.GUI)
local ESP = require(ModulesFolder.ESP)
local Aim = require(ModulesFolder.Aim)
local Player = require(ModulesFolder.Player)
local Combat = require(ModulesFolder.Combat)
local Visuals = require(ModulesFolder.Visuals)
local Utils = require(ModulesFolder.Utils)
local Main = require(ModulesFolder.Main)

-- Запускаем основной скрипт
Main.Start()

print("TUMBA MEGA SYSTEM Loader: All modules loaded successfully!")
