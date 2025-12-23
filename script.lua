--🔥 ANIME FIRE + RAINBOW AURA W/ MODERN MENU (XENO)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- =========================
-- 🧹 Clear Aura
-- =========================
local function clearAura(char)
    for _,v in pairs(char:GetDescendants()) do
        if v.Name:match("AnimeFireAura") then
            v:Destroy()
        end
    end
end

-- =========================
-- 🌈 Create Aura
-- =========================
local function createAura(char, fireColor)
    clearAura(char)
    local hrp = char:WaitForChild("HumanoidRootPart")

    -- Rainbow Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "AnimeFireAura_Highlight"
    highlight.Parent = char
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    local hue = 0
    RunService.RenderStepped:Connect(function(dt)
        if not highlight.Parent then return end
        hue = (hue + dt*0.8) % 1
        highlight.OutlineColor = Color3.fromHSV(hue,1,1)
    end)

    -- Part for particles
    local part = Instance.new("Part")
    part.Name = "AnimeFireAura_Part"
    part.Size = Vector3.new(1,1,1)
    part.Transparency = 1
    part.Anchored = true
    part.CanCollide = false
    part.CFrame = hrp.CFrame
    part.Parent = workspace

    RunService.RenderStepped:Connect(function()
        if part and part.Parent then
            part.CFrame = hrp.CFrame
        end
    end)

    -- Fire Particle
    local fire = Instance.new("ParticleEmitter")
    fire.Name = "AnimeFireAura_Fire"
    fire.Parent = part
    fire.Texture = "rbxassetid://243660364"
    fire.Rate = 120
    fire.Lifetime = NumberRange.new(0.8,1.5)
    fire.Speed = NumberRange.new(1,2)
    fire.SpreadAngle = Vector2.new(360,360)
    fire.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,3), NumberSequenceKeypoint.new(1,0)})
    fire.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0), NumberSequenceKeypoint.new(1,1)})
    fire.LightEmission = 1
    fire.LockedToPart = true
    fire.Color = ColorSequence.new(fireColor)

    -- Smoke Particle
    local smoke = Instance.new("ParticleEmitter")
    smoke.Name = "AnimeFireAura_Smoke"
    smoke.Parent = part
    smoke.Texture = "rbxassetid://771221224"
    smoke.Rate = 80
    smoke.Lifetime = NumberRange.new(1.5,2.5)
    smoke.Speed = NumberRange.new(0.5,1)
    smoke.SpreadAngle = Vector2.new(360,360)
    smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,2), NumberSequenceKeypoint.new(1,0)})
    smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.3), NumberSequenceKeypoint.new(1,1)})
    smoke.LightEmission = 0.5
    smoke.LockedToPart = true
    smoke.Color = ColorSequence.new(fireColor)
end

-- =========================
-- 🎨 Menu UI
-- =========================
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "AnimeFireAuraMenu"

local menuOpen = true

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,220,0,180)
mainFrame.Position = UDim2.new(0.5,-110,0.5,-90)
mainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- Open/Close Button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0,30,0,30)
toggleBtn.Position = UDim2.new(1,-35,0,5)
toggleBtn.AnchorPoint = Vector2.new(0,0)
toggleBtn.Text = "≡"
toggleBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Parent = mainFrame

toggleBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    for _,v in pairs(mainFrame:GetChildren()) do
        if v:IsA("TextButton") and v ~= toggleBtn then
            v.Visible = menuOpen
        end
    end
end)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "🔥 Fire Aura Menu"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = mainFrame

-- Aura Toggle
local auraBtn = Instance.new("TextButton")
auraBtn.Size = UDim2.new(1, -10,0,30)
auraBtn.Position = UDim2.new(0,5,0,40)
auraBtn.Text = "Toggle Aura"
auraBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
auraBtn.TextColor3 = Color3.new(1,1,1)
auraBtn.Parent = mainFrame

local auraOn = true
auraBtn.MouseButton1Click:Connect(function()
    auraOn = not auraOn
    if auraOn then
        createAura(player.Character, Color3.fromRGB(255,120,0))
    else
        clearAura(player.Character)
    end
end)

-- Color Buttons
local colors = {Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255),
                Color3.fromRGB(255,255,0), Color3.fromRGB(255,0,255), Color3.fromRGB(0,255,255),
                Color3.fromRGB(255,120,0)}

for i,color in ipairs(colors) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,30,0,30)
    btn.Position = UDim2.new(0,5+(i-1)*32,0,80)
    btn.BackgroundColor3 = color
    btn.Text = ""
    btn.Parent = mainFrame

    btn.MouseButton1Click:Connect(function()
        if player.Character and auraOn then
            createAura(player.Character, color)
        end
    end)
end

-- =========================
-- 🌟 Apply on spawn
-- =========================
if player.Character then
    createAura(player.Character, Color3.fromRGB(255,120,0))
end

player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    task.wait(0.2)
    if auraOn then
        createAura(char, Color3.fromRGB(255,120,0))
    end
end)
