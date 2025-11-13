-- Loader.lua - Загрузчик модулей для TUMBA MEGA SYSTEM v5.0

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

-- Configuration
local GITHUB_USER = "daniaggbro-cloud"
local GITHUB_REPO = "realzy"
local GITHUB_BRANCH = "main"
local MODULE_FOLDER_NAME = "TumbaModules"

local MODULES = {
    "Core",
    "Localization",
    "ESP",
    "Aim",
    "Player",
    "Combat",
    "Visuals",
    "Utils",
    "GUI",
    "Main"
}

-- --- LOADER --- --

-- 1. Create the modules folder
local TumbaModules = ReplicatedStorage:FindFirstChild(MODULE_FOLDER_NAME)
if TumbaModules then
    TumbaModules:Destroy()
end
TumbaModules = Instance.new("Folder")
TumbaModules.Name = MODULE_FOLDER_NAME
TumbaModules.Parent = ReplicatedStorage

print("TUMBA LOADER: Created TumbaModules folder.")

-- 2. Fetch and create each module
for _, moduleName in ipairs(MODULES) do
    local url = string.format("https://raw.githubusercontent.com/%s/%s/%s/%s.lua", GITHUB_USER, GITHUB_REPO, GITHUB_BRANCH, moduleName)
    
    local success, content = pcall(function()
        return game:HttpGet(url)
    end)

    if success and content then
        local moduleScript = Instance.new("ModuleScript")
        moduleScript.Name = moduleName
        moduleScript.Source = content
        moduleScript.Parent = TumbaModules
        print("TUMBA LOADER: Successfully loaded module: " .. moduleName)
    else
        warn("TUMBA LOADER: FAILED to load module: " .. moduleName .. ". Error: " .. tostring(content))
        return -- Stop if any module fails
    end
end

print("TUMBA LOADER: All modules loaded. Starting Main...")

-- 3. Start the main script
pcall(function()
    local Main = require(TumbaModules.Main)
    Main.Start()
end)

print("TUMBA MEGA SYSTEM v5.0 should now be running.")

print("TUMBA MEGA SYSTEM Loader: All modules loaded successfully!")
