-- ============================================================
--  ██████╗ ██╗   ██╗██████╗ ██████╗  ██████╗ ███╗   ██╗.exe
--  ██╔════╝ ██║   ██║██╔══██╗██╔══██╗██╔═══██╗████╗  ██║
--  ██║  ███╗██║   ██║██████╔╝██████╔╝██║   ██║██╔██╗ ██║
--  ██║   ██║██║   ██║██╔═══╝ ██╔══██╗██║   ██║██║╚██╗██║
--  ╚██████╔╝╚██████╔╝██║     ██║  ██║╚██████╔╝██║ ╚████║
--   ╚═════╝  ╚═════╝ ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
--  
--  SOUTH BRONX: THE TRENCHES - PREMIUM SCRIPT
--  Created by: GUPRON.EXE
--  Version: 3.0 | Delta Executor Optimized
--  Key: GUPRON.EXE
-- ============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- Settings
local Settings = {
    Aimlock = {
        Enabled = false,
        Key = Enum.KeyCode.Q,
        Prediction = 0.165,
        Smoothness = 0.08,
        Part = "Head",
        TeamCheck = true,
        ShowFOV = true,
        FOV = 150
    },
    ESP = {
        Enabled = false,
        Boxes = true,
        Names = true,
        Distance = true,
        Health = true,
        Tracers = false,
        TeamCheck = true,
        Color = Color3.fromRGB(0, 255, 150)
    },
    Misc = {
        NoRecoil = false,
        NoSpread = false,
        InstantReload = false,
        WalkSpeed = 16,
        JumpPower = 50,
        InfiniteJump = false,
        AutoShoot = false
    }
}

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GUPRON_EXE"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Loading Screen
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "Loading"
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.ZIndex = 100
LoadingFrame.Parent = ScreenGui

-- Loading Gradient
local LoadingGradient = Instance.new("UIGradient")
LoadingGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 20)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(5, 5, 10)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 5))
})
LoadingGradient.Rotation = 45
LoadingGradient.Parent = LoadingFrame

-- Loading Logo
local LoadingLogo = Instance.new("TextLabel")
LoadingLogo.Size = UDim2.new(0, 400, 0, 80)
LoadingLogo.Position = UDim2.new(0.5, -200, 0.4, 0)
LoadingLogo.BackgroundTransparency = 1
LoadingLogo.Text = "GUPRON.EXE"
LoadingLogo.TextColor3 = Color3.fromRGB(0, 255, 150)
LoadingLogo.TextSize = 56
LoadingLogo.Font = Enum.Font.GothamBlack
LoadingLogo.Parent = LoadingFrame

-- Loading Subtitle
local LoadingSub = Instance.new("TextLabel")
LoadingSub.Size = UDim2.new(0, 400, 0, 30)
LoadingSub.Position = UDim2.new(0.5, -200, 0.4, 70)
LoadingSub.BackgroundTransparency = 1
LoadingSub.Text = "SOUTH BRONX: THE TRENCHES"
LoadingSub.TextColor3 = Color3.fromRGB(150, 150, 150)
LoadingSub.TextSize = 14
LoadingSub.Font = Enum.Font.GothamBold
LoadingSub.Parent = LoadingFrame

-- Loading Bar Background
local LoadingBarBg = Instance.new("Frame")
LoadingBarBg.Size = UDim2.new(0, 300, 0, 6)
LoadingBarBg.Position = UDim2.new(0.5, -150, 0.4, 110)
LoadingBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
LoadingBarBg.BorderSizePixel = 0
LoadingBarBg.Parent = LoadingFrame

local LoadingBarBgCorner = Instance.new("UICorner")
LoadingBarBgCorner.CornerRadius = UDim.new(0, 3)
LoadingBarBgCorner.Parent = LoadingBarBg

-- Loading Bar Fill
local LoadingBarFill = Instance.new("Frame")
LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadingBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
LoadingBarFill.BorderSizePixel = 0
LoadingBarFill.Parent = LoadingBarBg

local LoadingBarCorner = Instance.new("UICorner")
LoadingBarCorner.CornerRadius = UDim.new(0, 3)
LoadingBarCorner.Parent = LoadingBarFill

-- Loading Text
local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(0, 300, 0, 20)
LoadingText.Position = UDim2.new(0.5, -150, 0.4, 125)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "INITIALIZING..."
LoadingText.TextColor3 = Color3.fromRGB(100, 100, 100)
LoadingText.TextSize = 11
LoadingText.Font = Enum.Font.GothamBold
LoadingText.Parent = LoadingFrame

-- Key System Frame
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeySystem"
KeyFrame.Size = UDim2.new(0, 450, 0, 300)
KeyFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
KeyFrame.BorderSizePixel = 0
KeyFrame.Visible = false
KeyFrame.ZIndex = 99
KeyFrame.Parent = ScreenGui

local KeyGradient = Instance.new("UIGradient")
KeyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 10))
})
KeyGradient.Rotation = 90
KeyGradient.Parent = KeyFrame

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 20)
KeyCorner.Parent = KeyFrame

-- Glow
local KeyGlow = Instance.new("ImageLabel")
KeyGlow.Size = UDim2.new(1, 80, 1, 80)
KeyGlow.Position = UDim2.new(0, -40, 0, -40)
KeyGlow.BackgroundTransparency = 1
KeyGlow.Image = "rbxassetid://4996891970"
KeyGlow.ImageColor3 = Color3.fromRGB(0, 255, 150)
KeyGlow.ImageTransparency = 0.85
KeyGlow.ZIndex = 98
KeyGlow.Parent = KeyFrame

-- Key Title
local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 50)
KeyTitle.Position = UDim2.new(0, 0, 0, 30)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔐 KEY VERIFICATION"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 24
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.Parent = KeyFrame

-- Key Subtitle
local KeySub = Instance.new("TextLabel")
KeySub.Size = UDim2.new(1, 0, 0, 20)
KeySub.Position = UDim2.new(0, 0, 0, 75)
KeySub.BackgroundTransparency = 1
KeySub.Text = "Enter your access key to continue"
KeySub.TextColor3 = Color3.fromRGB(150, 150, 150)
KeySub.TextSize = 12
KeySub.Font = Enum.Font.Gotham
KeySub.Parent = KeyFrame

-- Key Input
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 350, 0, 45)
KeyInput.Position = UDim2.new(0.5, -175, 0, 120)
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
KeyInput.BorderSizePixel = 0
KeyInput.Text = ""
KeyInput.PlaceholderText = "ENTER KEY HERE..."
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
KeyInput.TextSize = 14
KeyInput.Font = Enum.Font.GothamBold
KeyInput.Parent = KeyFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 10)
KeyInputCorner.Parent = KeyInput

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(0, 200, 120)
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyInput

-- Submit Button
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0, 350, 0, 45)
SubmitBtn.Position = UDim2.new(0.5, -175, 0, 180)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 120)
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "SUBMIT KEY"
SubmitBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
SubmitBtn.TextSize = 16
SubmitBtn.Font = Enum.Font.GothamBlack
SubmitBtn.Parent = KeyFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 10)
SubmitCorner.Parent = SubmitBtn

-- Get Key Button
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0, 350, 0, 35)
GetKeyBtn.Position = UDim2.new(0.5, -175, 0, 235)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Text = "📋 COPY KEY: GUPRON.EXE"
GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
GetKeyBtn.TextSize = 12
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = KeyFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyBtn

-- Status
local KeyStatus = Instance.new("TextLabel")
KeyStatus.Size = UDim2.new(1, 0, 0, 20)
KeyStatus.Position = UDim2.new(0, 0, 0, 280)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
KeyStatus.TextSize = 11
KeyStatus.Font = Enum.Font.GothamBold
KeyStatus.Parent = KeyFrame

-- Main UI Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainUI"
MainFrame.Size = UDim2.new(0, 700, 0, 450)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

-- Main Gradient
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 28)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 12, 18)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 12))
})
MainGradient.Rotation = 135
MainGradient.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 20)
TopBarCorner.Parent = TopBar

-- Fix corners
local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 25)
TopBarFix.Position = UDim2.new(0, 0, 0.5, 0)
TopBarFix.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

-- Logo
local MainLogo = Instance.new("TextLabel")
MainLogo.Size = UDim2.new(0, 200, 0, 50)
MainLogo.Position = UDim2.new(0, 20, 0, 0)
MainLogo.BackgroundTransparency = 1
MainLogo.Text = "GUPRON.EXE"
MainLogo.TextColor3 = Color3.fromRGB(0, 255, 150)
MainLogo.TextSize = 24
MainLogo.Font = Enum.Font.GothamBlack
MainLogo.TextXAlignment = Enum.TextXAlignment.Left
MainLogo.Parent = TopBar

-- Version
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 100, 0, 50)
VersionLabel.Position = UDim2.new(0, 170, 0, 0)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "v3.0"
VersionLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
VersionLabel.TextSize = 12
VersionLabel.Font = Enum.Font.GothamBold
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
VersionLabel.Parent = TopBar

-- Window Controls
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "Minimize"
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -75, 0, 10)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeBtn.TextSize = 20
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TopBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(1, 0)
MinimizeCorner.Parent = MinimizeBtn

local MaximizeBtn = Instance.new("TextButton")
MaximizeBtn.Name = "Maximize"
MaximizeBtn.Size = UDim2.new(0, 30, 0, 30)
MaximizeBtn.Position = UDim2.new(1, -40, 0, 10)
MaximizeBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
MaximizeBtn.BorderSizePixel = 0
MaximizeBtn.Text = "□"
MaximizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MaximizeBtn.TextSize = 14
MaximizeBtn.Font = Enum.Font.GothamBold
MaximizeBtn.Parent = TopBar

local MaximizeCorner = Instance.new("UICorner")
MaximizeCorner.CornerRadius = UDim.new(1, 0)
MaximizeCorner.Parent = MaximizeBtn

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 180, 1, -50)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 0)
SidebarCorner.Parent = Sidebar

-- Sidebar Fix
local SidebarFix = Instance.new("Frame")
SidebarFix.Size = UDim2.new(0, 20, 1, 0)
SidebarFix.Position = UDim2.new(1, -20, 0, 0)
SidebarFix.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
SidebarFix.BorderSizePixel = 0
SidebarFix.Parent = Sidebar

-- Tab Buttons Container
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -10, 1, -20)
TabContainer.Position = UDim2.new(0, 10, 0, 10)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Sidebar

-- Tab Layout
local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 8)
TabLayout.Parent = TabContainer

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "Content"
ContentArea.Size = UDim2.new(1, -190, 1, -60)
ContentArea.Position = UDim2.new(0, 185, 0, 55)
ContentArea.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 15)
ContentCorner.Parent = ContentArea

-- Credits Bar
local CreditsBar = Instance.new("Frame")
CreditsBar.Size = UDim2.new(1, 0, 0, 25)
CreditsBar.Position = UDim2.new(0, 0, 1, -25)
CreditsBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
CreditsBar.BorderSizePixel = 0
CreditsBar.Parent = MainFrame

local CreditsText = Instance.new("TextLabel")
CreditsText.Size = UDim2.new(1, 0, 1, 0)
CreditsText.BackgroundTransparency = 1
CreditsText.Text = "⚡ MADE BY GUPRON.EXE | SOUTH BRONX PREMIUM ⚡"
CreditsText.TextColor3 = Color3.fromRGB(0, 255, 150)
CreditsText.TextSize = 10
CreditsText.Font = Enum.Font.GothamBold
CreditsText.Parent = CreditsBar

-- Variables
local ESPObjects = {}
local AimbotTarget = nil
local IsMinimized = false
local IsMaximized = false
local OriginalSize = UDim2.new(0, 700, 0, 450)
local OriginalPos = UDim2.new(0.5, -350, 0.5, -225)
local CurrentTab = nil

-- Utility Functions
local function CreateDrawing(type, properties)
    local drawing = Drawing.new(type)
    for prop, value in pairs(properties) do
        drawing[prop] = value
    end
    return drawing
end

local function Tween(obj, properties, duration, easing)
    local tween = TweenService:Create(obj, TweenInfo.new(duration or 0.3, easing or Enum.EasingStyle.Quart), properties)
    tween:Play()
    return tween
end

local function RippleEffect(button, x, y)
    local ripple = Instance.new("Frame")
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0, x, 0, y)
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.7
    ripple.BorderSizePixel = 0
    ripple.ZIndex = button.ZIndex + 1
    ripple.Parent = button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
    local maxSize = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
    
    Tween(ripple, {
        Size = UDim2.new(0, maxSize, 0, maxSize),
        Position = UDim2.new(0, x - maxSize/2, 0, y - maxSize/2),
        BackgroundTransparency = 1
    }, 0.5)
    
    task.delay(0.5, function()
        ripple:Destroy()
    end)
end

-- ESP Functions
local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local esp = {
        Box = CreateDrawing("Square", {
            Visible = false,
            Color = Settings.ESP.Color,
            Thickness = 1.5,
            Filled = false,
            Transparency = 1
        }),
        BoxOutline = CreateDrawing("Square", {
            Visible = false,
            Color = Color3.new(0, 0, 0),
            Thickness = 3,
            Filled = false,
            Transparency = 1
        }),
        Name = CreateDrawing("Text", {
            Visible = false,
            Color = Color3.new(1, 1, 1),
            Size = 13,
            Center = true,
            Outline = true,
            Font = Drawing.Fonts.UI,
            Transparency = 1
        }),
        Distance = CreateDrawing("Text", {
            Visible = false,
            Color = Color3.fromRGB(200, 200, 200),
            Size = 11,
            Center = true,
            Outline = true,
            Font = Drawing.Fonts.UI,
            Transparency = 1
        }),
        HealthBar = CreateDrawing("Square", {
            Visible = false,
            Color = Color3.fromRGB(0, 255, 100),
            Thickness = 1,
            Filled = true,
            Transparency = 1
        }),
        HealthBarBg = CreateDrawing("Square", {
            Visible = false,
            Color = Color3.fromRGB(40, 40, 40),
            Thickness = 1,
            Filled = true,
            Transparency = 1
        }),
        Tracer = CreateDrawing("Line", {
            Visible = false,
            Color = Settings.ESP.Color,
            Thickness = 1.5,
            Transparency = 1
        })
    }
    
    ESPObjects[player] = esp
end

local function UpdateESP()
    for player, esp in pairs(ESPObjects) do
        if not Settings.ESP.Enabled or not player.Parent then
            for _, drawing in pairs(esp) do
                drawing.Visible = false
            end
            continue
        end
        
        local character = player.Character
        if not character then
            for _, drawing in pairs(esp) do
                drawing.Visible = false
            end
            continue
        end
        
        local root = character:FindFirstChild("HumanoidRootPart")
        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChild("Humanoid")
        
        if not root or not head or not humanoid then
            for _, drawing in pairs(esp) do
                drawing.Visible = false
            end
            continue
        end
        
        if humanoid.Health <= 0 then
            for _, drawing in pairs(esp) do
                drawing.Visible = false
            end
            continue
        end
        
        if Settings.ESP.TeamCheck and player.Team == LocalPlayer.Team then
            for _, drawing in pairs(esp) do
                drawing.Visible = false
            end
            continue
        end
        
        local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
        if not onScreen then
            for _, drawing in pairs(esp) do
                drawing.Visible = false
            end
            continue
        end
        
        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
        local scale = math.clamp(1000 / distance, 5, 25)
        local boxWidth = scale * 3
        local boxHeight = scale * 4.5
        
        local topLeft = Vector2.new(pos.X - boxWidth/2, pos.Y - boxHeight/2)
        local bottomRight = Vector2.new(pos.X + boxWidth/2, pos.Y + boxHeight/2)
        
        -- Box ESP
        if Settings.ESP.Boxes then
            esp.BoxOutline.Size = Vector2.new(boxWidth, boxHeight)
            esp.BoxOutline.Position = topLeft
            esp.BoxOutline.Visible = true
            
            esp.Box.Size = Vector2.new(boxWidth, boxHeight)
            esp.Box.Position = topLeft
            esp.Box.Color = Settings.ESP.Color
            esp.Box.Visible = true
        else
            esp.Box.Visible = false
            esp.BoxOutline.Visible = false
        end
        
        -- Name ESP
        if Settings.ESP.Names then
            esp.Name.Position = Vector2.new(pos.X, topLeft.Y - 18)
            esp.Name.Text = player.Name
            esp.Name.Color = player.Team == LocalPlayer.Team and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
            esp.Name.Visible = true
        else
            esp.Name.Visible = false
        end
        
        -- Distance ESP
        if Settings.ESP.Distance then
            esp.Distance.Position = Vector2.new(pos.X, bottomRight.Y + 5)
            esp.Distance.Text = string.format("%.0fm", distance)
            esp.Distance.Visible = true
        else
            esp.Distance.Visible = false
        end
        
        -- Health Bar
        if Settings.ESP.Health then
            local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
            local barHeight = boxHeight * healthPercent
            
            esp.HealthBarBg.Size = Vector2.new(4, boxHeight)
            esp.HealthBarBg.Position = Vector2.new(topLeft.X - 10, topLeft.Y)
            esp.HealthBarBg.Visible = true
            
            esp.HealthBar.Size = Vector2.new(2, barHeight)
            esp.HealthBar.Position = Vector2.new(topLeft.X - 9, topLeft.Y + boxHeight - barHeight)
            esp.HealthBar.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
            esp.HealthBar.Visible = true
        else
            esp.HealthBar.Visible = false
            esp.HealthBarBg.Visible = false
        end
        
        -- Tracers
        if Settings.ESP.Tracers then
            esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
            esp.Tracer.To = Vector2.new(pos.X, bottomRight.Y)
            esp.Tracer.Color = Settings.ESP.Color
            esp.Tracer.Visible = true
        else
            esp.Tracer.Visible = false
        end
    end
end

-- Aimbot Functions
local FOV_Circle = CreateDrawing("Circle", {
    Visible = false,
    Thickness = 1.5,
    Color = Color3.fromRGB(0, 255, 150),
    NumSides = 64,
    Radius = Settings.Aimlock.FOV,
    Filled = false,
    Transparency = 0.7
})

local FOV_Circle_Outline = CreateDrawing("Circle", {
    Visible = false,
    Thickness = 1,
    Color = Color3.new(0, 0, 0),
    NumSides = 64,
    Radius = Settings.Aimlock.FOV + 1,
    Filled = false,
    Transparency = 0.5
})

local function GetClosestPlayer()
    local closest = nil
    local shortestDistance = Settings.Aimlock.FOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not player.Character then continue end
        if not player.Character:FindFirstChild(Settings.Aimlock.Part) then continue end
        
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        if Settings.Aimlock.TeamCheck and player.Team == LocalPlayer.Team then continue end
        
        local part = player.Character[Settings.Aimlock.Part]
        local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
        
        if not onScreen then continue end
        
        local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
        if distance < shortestDistance then
            shortestDistance = distance
            closest = player
        end
    end
    
    return closest
end

local function Aimbot()
    if Settings.Aimlock.ShowFOV then
        FOV_Circle.Position = Vector2.new(Mouse.X, Mouse.Y)
        FOV_Circle.Radius = Settings.Aimlock.FOV
        FOV_Circle.Visible = true
        
        FOV_Circle_Outline.Position = Vector2.new(Mouse.X, Mouse.Y)
        FOV_Circle_Outline.Radius = Settings.Aimlock.FOV + 1
        FOV_Circle_Outline.Visible = true
    else
        FOV_Circle.Visible = false
        FOV_Circle_Outline.Visible = false
    end
    
    if Settings.Aimlock.Enabled then
        if UserInputService:IsKeyDown(Settings.Aimlock.Key) or Settings.Misc.AutoShoot then
            local target = GetClosestPlayer()
            if target then
                local part = target.Character[Settings.Aimlock.Part]
                local predictedPos = part.Position + (part.Velocity * Settings.Aimlock.Prediction)
                local pos = Camera:WorldToViewportPoint(predictedPos)
                
                local targetPos = Vector2.new(pos.X, pos.Y)
                local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                local moveVec = (targetPos - mousePos) * Settings.Aimlock.Smoothness
                
                mousemoverel(moveVec.X, moveVec.Y)
                
                -- Auto Shoot
                if Settings.Misc.AutoShoot then
                    mouse1press()
                    task.wait(0.05)
                    mouse1release()
                end
            end
        end
    end
end

-- No Recoil
local function ApplyNoRecoil()
    if not Settings.Misc.NoRecoil then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            local config = tool:FindFirstChild("Configuration")
            if config then
                local recoil = config:FindFirstChild("Recoil")
                if recoil then
                    recoil.Value = 0
                end
            end
            
            local ammo = tool:FindFirstChild("Ammo")
            if ammo then
                local maxAmmo = tool:FindFirstChild("MaxAmmo")
                if maxAmmo then
                    ammo.Value = maxAmmo.Value
                end
            end
        end
    end
end

-- UI Creation Functions
local function CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = name .. "Tab"
    TabBtn.Size = UDim2.new(1, 0, 0, 40)
    TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TabBtn.BorderSizePixel = 0
    TabBtn.Text = "  " .. icon .. "  " .. name
    TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabBtn.TextSize = 13
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.Parent = TabContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabBtn
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = name .. "Content"
    TabContent.Size = UDim2.new(1, -20, 1, -20)
    TabContent.Position = UDim2.new(0, 10, 0, 10)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.ScrollBarThickness = 4
    TabContent.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
    TabContent.Visible = false
    TabContent.Parent = ContentArea
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0, 10)
    ContentLayout.Parent = TabContent
    
    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.PaddingTop = UDim.new(0, 5)
    ContentPadding.PaddingBottom = UDim.new(0, 5)
    ContentPadding.Parent = TabContent
    
    TabBtn.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.Content.Visible = false
            Tween(CurrentTab.Button, {BackgroundColor3 = Color3.fromRGB(25, 25, 35), TextColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)
        end
        
        TabContent.Visible = true
        CurrentTab = {Button = TabBtn, Content = TabContent}
        Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(0, 200, 120), TextColor3 = Color3.fromRGB(0, 0, 0)}, 0.2)
    end)
    
    return TabContent
end

local function CreateToggle(parent, text, callback, default)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 50, 0, 26)
    ToggleBtn.Position = UDim2.new(1, -60, 0.5, -13)
    ToggleBtn.BackgroundColor3 = default and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(60, 60, 70)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Text = ""
    ToggleBtn.Parent = ToggleFrame
    
    local ToggleBtnCorner = Instance.new("UICorner")
    ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
    ToggleBtnCorner.Parent = ToggleBtn
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 20, 0, 20)
    Circle.Position = default and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.BorderSizePixel = 0
    Circle.Parent = ToggleBtn
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle
    
    local enabled = default or false
    
    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Tween(ToggleBtn, {BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(60, 60, 70)}, 0.2)
        Tween(Circle, {Position = enabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)}, 0.2)
        if callback then
            callback(enabled)
        end
    end)
    
    return ToggleFrame
end

local function CreateSlider(parent, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 10)
    SliderCorner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0, 25)
    Label.Position = UDim2.new(0, 15, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.3, -15, 0, 25)
    ValueLabel.Position = UDim2.new(0.7, 0, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    ValueLabel.TextSize = 13
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = SliderFrame
    
    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, -30, 0, 8)
    SliderBg.Position = UDim2.new(0, 15, 0, 38)
    SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = SliderFrame
    
    local SliderBgCorner = Instance.new("UICorner")
    SliderBgCorner.CornerRadius = UDim.new(1, 0)
    SliderBgCorner.Parent = SliderBg
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBg
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill
    
    local DragBtn = Instance.new("TextButton")
    DragBtn.Size = UDim2.new(0, 16, 0, 16)
    DragBtn.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    DragBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragBtn.BorderSizePixel = 0
    DragBtn.Text = ""
    DragBtn.Parent = SliderBg
    
    local DragCorner = Instance.new("UICorner")
    DragCorner.CornerRadius = UDim.new(1, 0)
    DragCorner.Parent = DragBtn
    
    local dragging = false
    
    DragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * pos)
            
            SliderFill.Size = UDim2.new(pos, 0, 1, 0)
            DragBtn.Position = UDim2.new(pos, -8, 0.5, -8)
            ValueLabel.Text = tostring(value)
            
            if callback then
                callback(value)
            end
        end
    end)
    
    return SliderFrame
end

-- Create Tabs
local CombatTab = CreateTab("COMBAT", "⚔️")
local VisualTab = CreateTab("VISUAL", "👁️")
local MiscTab = CreateTab("MISC", "⚙️")
local PlayerTab = CreateTab("PLAYER", "🏃")

-- Combat Features
CreateToggle(CombatTab, "🔫 AIMLOCK", function(enabled)
    Settings.Aimlock.Enabled = enabled
end, false)

CreateToggle(CombatTab, "🎯 AUTO SHOOT", function(enabled)
    Settings.Misc.AutoShoot = enabled
end, false)

CreateSlider(CombatTab, "SMOOTHNESS", 1, 100, 8, function(value)
    Settings.Aimlock.Smoothness = value / 100
end)

CreateSlider(CombatTab, "FOV SIZE", 50, 400, 150, function(value)
    Settings.Aimlock.FOV = value
    FOV_Circle.Radius = value
    FOV_Circle_Outline.Radius = value + 1
end)

CreateToggle(CombatTab, "👥 TEAM CHECK", function(enabled)
    Settings.Aimlock.TeamCheck = enabled
end, true)

CreateToggle(CombatTab, "⭕ SHOW FOV", function(enabled)
    Settings.Aimlock.ShowFOV = enabled
end, true)

-- Visual Features
CreateToggle(VisualTab, "📦 ESP BOXES", function(enabled)
    Settings.ESP.Enabled = enabled
    Settings.ESP.Boxes = enabled
end, false)

CreateToggle(VisualTab, "👤 ESP NAMES", function(enabled)
    Settings.ESP.Names = enabled
end, false)

CreateToggle(VisualTab, "📏 ESP DISTANCE", function(enabled)
    Settings.ESP.Distance = enabled
end, false)

CreateToggle(VisualTab, "❤️ ESP HEALTH", function(enabled)
    Settings.ESP.Health = enabled
end, false)

CreateToggle(VisualTab, "➡️ ESP TRACERS", function(enabled)
    Settings.ESP.Tracers = enabled
end, false)

-- Misc Features
CreateToggle(MiscTab, "🔇 NO RECOIL", function(enabled)
    Settings.Misc.NoRecoil = enabled
end, false)

CreateToggle(MiscTab, "🎯 NO SPREAD", function(enabled)
    Settings.Misc.NoSpread = enabled
end, false)

CreateToggle(MiscTab, "⚡ INSTANT RELOAD", function(enabled)
    Settings.Misc.InstantReload = enabled
end, false)

-- Player Features
CreateSlider(PlayerTab, "WALK SPEED", 16, 200, 16, function(value)
    Settings.Misc.WalkSpeed = value
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = value
    end
end)

CreateSlider(PlayerTab, "JUMP POWER", 50, 300, 50, function(value)
    Settings.Misc.JumpPower = value
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = value
    end
end)

CreateToggle(PlayerTab, "🦘 INFINITE JUMP", function(enabled)
    Settings.Misc.InfiniteJump = enabled
end, false)

-- Draggable Function
local function MakeDraggable(frame, handle)
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Make Main Frame Draggable
MakeDraggable(MainFrame, TopBar)

-- Minimize/Maximize
MinimizeBtn.MouseButton1Click:Connect(function()
    if IsMaximized then return end
    
    if IsMinimized then
        Tween(MainFrame, {Size = OriginalSize, Position = OriginalPos}, 0.3)
        ContentArea.Visible = true
        Sidebar.Visible = true
        CreditsBar.Visible = true
    else
        OriginalSize = MainFrame.Size
        OriginalPos = MainFrame.Position
        Tween(MainFrame, {Size = UDim2.new(0, 700, 0, 50), Position = UDim2.new(MainFrame.Position.X.Scale, MainFrame.Position.X.Offset, 1, -60)}, 0.3)
        task.delay(0.3, function()
            ContentArea.Visible = false
            Sidebar.Visible = false
            CreditsBar.Visible = false
        end)
    end
    
    IsMinimized = not IsMinimized
end)

MaximizeBtn.MouseButton1Click:Connect(function()
    if IsMinimized then return end
    
    if IsMaximized then
        Tween(MainFrame, {Size = OriginalSize, Position = OriginalPos}, 0.3)
    else
        OriginalSize = MainFrame.Size
        OriginalPos = MainFrame.Position
        Tween(MainFrame, {Size = UDim2.new(0, 1000, 0, 600), Position = UDim2.new(0.5, -500, 0.5, -300)}, 0.3)
    end
    
    IsMaximized = not IsMaximized
end)

-- Key System
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("GUPRON.EXE")
    KeyStatus.Text = "✅ KEY COPIED TO CLIPBOARD!"
    KeyStatus.TextColor3 = Color3.fromRGB(0, 255, 150)
end)

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "GUPRON.EXE" then
        verified = true
        Tween(KeyFrame, {Position = UDim2.new(0.5, -225, 1.5, 0)}, 0.5)
        task.wait(0.5)
        KeyFrame.Visible = false
        MainFrame.Visible = true
        MainFrame.Position = UDim2.new(0.5, -350, 1.5, 0)
        Tween(MainFrame, {Position = UDim2.new(0.5, -350, 0.5, -225)}, 0.5)
        
        -- Select first tab
        if CombatTab then
            CombatTab.Visible = true
            CurrentTab = {Button = TabContainer:FindFirstChild("COMBATTab"), Content = CombatTab}
        end
    else
        KeyStatus.Text = "❌ INVALID KEY! USE: GUPRON.EXE"
        KeyStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
        Tween(KeyInput, {BackgroundColor3 = Color3.fromRGB(60, 30, 30)}, 0.1)
        task.wait(0.2)
        Tween(KeyInput, {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}, 0.1)
    end
end)

-- Loading Animation
task.spawn(function()
    local steps = {"INITIALIZING...", "LOADING MODULES...", "CONNECTING...", "VERIFYING..."}
    
    for i, step in ipairs(steps) do
        LoadingText.Text = step
        Tween(LoadingBarFill, {Size = UDim2.new(i / #steps, 0, 1, 0)}, 0.5)
        task.wait(0.6)
    end
    
    task.wait(0.3)
    Tween(LoadingFrame, {BackgroundTransparency = 1}, 0.5)
    Tween(LoadingLogo, {TextTransparency = 1}, 0.5)
    Tween(LoadingSub, {TextTransparency = 1}, 0.5)
    Tween(LoadingBarBg, {BackgroundTransparency = 1}, 0.5)
    Tween(LoadingBarFill, {BackgroundTransparency = 1}, 0.5)
    Tween(LoadingText, {TextTransparency = 1}, 0.5)
    
    task.wait(0.5)
    LoadingFrame.Visible = false
    KeyFrame.Visible = true
    KeyFrame.Position = UDim2.new(0.5, -225, 1.5, 0)
    Tween(KeyFrame, {Position = UDim2.new(0.5, -225, 0.5, -150)}, 0.5)
end)

-- Initialize ESP for existing players
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end

Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        for _, drawing in pairs(ESPObjects[player]) do
            drawing:Remove()
        end
        ESPObjects[player] = nil
    end
end)

-- Main Loop
RunService.RenderStepped:Connect(function()
    UpdateESP()
    Aimbot()
    ApplyNoRecoil()
    
    -- Apply walk speed
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = Settings.Misc.WalkSpeed
        char.Humanoid.JumpPower = Settings.Misc.JumpPower
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if Settings.Misc.InfiniteJump then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Notification
StarterGui:SetCore("SendNotification", {
    Title = "GUPRON.EXE",
    Text = "Script Loaded Successfully! Enter Key: GUPRON.EXE",
    Duration = 5,
    Icon = "rbxassetid://2541869229"
})

print([[


  ██████╗ ██╗   ██╗██████╗ ██████╗  ██████╗ ███╗   ██╗.exe
  ██╔════╝ ██║   ██║██╔══██╗██╔══██╗██╔═══██╗████╗  ██║
  ██║  ███╗██║   ██║██████╔╝██████╔╝██║   ██║██╔██╗ ██║
  ██║   ██║██║   ██║██╔═══╝ ██╔══██╗██║   ██║██║╚██╗██║
  ╚██████╔╝╚██████╔╝██║     ██║  ██║╚██████╔╝██║ ╚████║
   ╚═════╝  ╚═════╝ ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                        
  SOUTH BRONX: THE TRENCHES - PREMIUM EDITION
  Created by: GUPRON.EXE
  Status: LOADED SUCCESSFULLY


]])