-- // Dependencies
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    pcall(function()
        for i,v in pairs(game.Players:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                local hrp = v.Character.HumanoidRootPart
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)    
                hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)   
            end
        end
    end)
end)

local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/JustValk/Aiming/main/Load.lua"))()("Module")
local AimingSettings = Aiming.Settings
local AimingChecks = Aiming.Checks
local AimingSelected = Aiming.Selected

 -- // Makes sure that it aint being seen thanks to stefanuk huge thanks to him!
Aiming.Settings.FOVSettings.Scale = 12.55
Aiming.Settings.FOVSettings.Sides = 25
Aiming.Settings.FOVSettings.Enabled = false
Aiming.Settings.TracerSettings.Enabled = false

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings = {
    Prediction = 0.1229,

    SilentAim = true,

}
getgenv().DaHoodSettings = DaHoodSettings


local function ApplyPredictionFormula(SelectedPart)
    local Velocity = Aiming.Selected.Velocity
    return SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)
end

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target and see if we can use it
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and AimingChecks.IsAvailable() and DaHoodSettings.SilentAim) then
        -- // Vars
        local SelectedPart = AimingSelected.Part
        local Hit = ApplyPredictionFormula(SelectedPart)

        -- // Return modded val
        return (k == "Hit" and Hit or SelectedPart)
    end

    -- // Return
    return __index(t, k)
end)
