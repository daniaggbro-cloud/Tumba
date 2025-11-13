-- Visuals.lua - Visual hacks for TUMBA MEGA SYSTEM v5.0

local TumbaModules = game:GetService("ReplicatedStorage"):WaitForChild("TumbaModules")
local Core = require(TumbaModules.Core)
local Mega = Core.Mega

function ToggleNoFog(state)
    Mega.States.Visuals.NoFog = state
    if state then
        game:GetService("Lighting").FogEnd = 100000
    else
        game:GetService("Lighting").FogEnd = 1000
    end
end

function ToggleFullBright(state)
    Mega.States.Visuals.FullBright = state
    if state then
        game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
        game:GetService("Lighting").Brightness = 2
    else
        game:GetService("Lighting").Ambient = Color3.new(0.5, 0.5, 0.5)
        game:GetService("Lighting").Brightness = 1
    end
end

function ToggleNightMode(state)
    Mega.States.Visuals.NightMode = state
    if state then
        game:GetService("Lighting").ClockTime = 0
    else
        game:GetService("Lighting").ClockTime = 14
    end
end

function ToggleRemoveShadows(state)
    Mega.States.Visuals.RemoveShadows = state
    if state then
        game:GetService("Lighting").GlobalShadows = false
    else
        game:GetService("Lighting").GlobalShadows = true
    end
end

return {
    ToggleNoFog = ToggleNoFog,
    ToggleFullBright = ToggleFullBright,
    ToggleNightMode = ToggleNightMode,
    ToggleRemoveShadows = ToggleRemoveShadows
}
