-- Main.lua - Main entry point for TUMBA MEGA SYSTEM v5.0

local TumbaModules = game:GetService("ReplicatedStorage"):WaitForChild("TumbaModules")

local Core = require(TumbaModules.Core)
local GUI = require(TumbaModules.GUI)
local ESP = require(TumbaModules.ESP)
local Aim = require(TumbaModules.Aim)

local Mega = Core.Mega
local GetText = Core.GetText
local VERSION = Core.VERSION
local DEVELOPER = Core.DEVELOPER
local SPECIAL_THANKS = Core.SPECIAL_THANKS

local function LanguageSelection()
    -- Language selection GUI (from original)
    local LanguagePrompt = Instance.new("ScreenGui")
    LanguagePrompt.Name = "LanguagePrompt"
    LanguagePrompt.Parent = game:GetService("CoreGui")
    LanguagePrompt.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(0, 300, 0, 420)
    Background.Position = UDim2.new(0.5, -150, 0.5, -210)
    Background.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Background.BorderSizePixel = 0
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Background
    Background.Parent = LanguagePrompt

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.Text = "TUMBA v5.0 - Select Language"
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.Parent = Background

    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.Size = UDim2.new(1, 0, 0, 350)
    ButtonContainer.Position = UDim2.new(0, 0, 0, 70)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = Background

    local ButtonLayout = Instance.new("UIListLayout")
    ButtonLayout.FillDirection = Enum.FillDirection.Vertical
    ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    ButtonLayout.Padding = UDim.new(0, 10)
    ButtonLayout.Parent = ButtonContainer

    local ButtonCornerTemplate = Instance.new("UICorner")
    ButtonCornerTemplate.CornerRadius = UDim.new(0, 6)

    local EnglishButton = Instance.new("TextButton")
    EnglishButton.Name = "English"
    EnglishButton.Size = UDim2.new(0, 250, 0, 40)
    EnglishButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    EnglishButton.TextColor3 = Color3.new(1, 1, 1)
    EnglishButton.Font = Enum.Font.GothamSemibold
    EnglishButton.Text = "English"
    EnglishButton.Parent = ButtonContainer
    ButtonCornerTemplate:Clone().Parent = EnglishButton

    local RussianButton = EnglishButton:Clone()
    RussianButton.Name = "Russian"
    RussianButton.Text = "Русский"
    RussianButton.Parent = ButtonContainer

    local SpanishButton = EnglishButton:Clone()
    SpanishButton.Name = "Spanish"
    SpanishButton.Text = "Español"
    SpanishButton.Parent = ButtonContainer

    local PortugueseButton = EnglishButton:Clone()
    PortugueseButton.Name = "Portuguese"
    PortugueseButton.Text = "Português"
    PortugueseButton.Parent = ButtonContainer

    local KoreanButton = EnglishButton:Clone()
    KoreanButton.Name = "Korean"
    KoreanButton.Text = "한국어"
    KoreanButton.Parent = ButtonContainer

    local JapaneseButton = EnglishButton:Clone()
    JapaneseButton.Name = "Japanese"
    JapaneseButton.Text = "日本語"
    JapaneseButton.Parent = ButtonContainer

    local function OnLanguageSelected(lang)
        Mega.Localization.CurrentLanguage = lang
        print("Language set to: " .. lang)
        LanguagePrompt:Destroy()
        GUI.InitializeMainGUI()
    end

    EnglishButton.MouseButton1Click:Connect(function() OnLanguageSelected("en") end)
    RussianButton.MouseButton1Click:Connect(function() OnLanguageSelected("ru") end)
    SpanishButton.MouseButton1Click:Connect(function() OnLanguageSelected("es") end)
    PortugueseButton.MouseButton1Click:Connect(function() OnLanguageSelected("pt") end)
    KoreanButton.MouseButton1Click:Connect(function() OnLanguageSelected("ko") end)
    JapaneseButton.MouseButton1Click:Connect(function() OnLanguageSelected("ja") end)
end

local function Start()
    LanguageSelection()
end

return {
    Start = Start
}
