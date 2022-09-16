-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/JustValk/Aiming/main/Load.lua"))()("Module")
local AimingSettings = Aiming.Settings
local AimingChecks = Aiming.Checks
local AimingSelected = Aiming.Selected

 -- // Makes sure that it aint being seen thanks to stefanuk huge thanks to him!
Aiming.Settings.FOVSettings.Scale = 14.5
Aiming.Settings.FOVSettings.Sides = 25
Aiming.Settings.FOVSettings.Enabled = false
Aiming.Settings.TracerSettings.Enabled = false

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings = {
    Prediction = 0.11567724521,

    SilentAim = true,

    AimLock = AimLockSettings,
    BeizerLock = {
        Smoothness = 0.05,
        CurvePoints = {
            Vector2.new(0.83, 0),
            Vector2.new(0.17, 1)
        }
    }
}
getgenv().DaHoodSettings = DaHoodSettings

-- //
local function ApplyPredictionFormula(SelectedPart)
    return SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)
end

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target and see if we can use it
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and AimingChecks.IsAvailable() and DaHoodSettings.SilentAim) then

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target and see if we can use it
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and AimingChecks.IsAvailable() and Aiming.SilentAim) then
        -- // Vars
        local SelectedPart = AimingSelected.Part
        local Hit = ApplyPredictionFormula(SelectedPart)

        -- // Return modded val
        return (k == "Hit" and Hit or SelectedPart)
    end

    -- // Return
    return __index(t, k)
end)
