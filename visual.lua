return function(Window)
    local VisualTab = Window:CreateTab("Visual", 4483362458)
    
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")
    local Lighting = game:GetService("Lighting")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    
    -- ==========================================
    -- HUD (XCLIENT)
    -- ==========================================
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "XCLIENT_HUD"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    
    -- Защита GUI
    local success = pcall(function() ScreenGui.Parent = CoreGui end)
    if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    
    -- Главный фрейм подложки (авто-расширение под текст)
    local HudFrame = Instance.new("Frame")
    HudFrame.Name = "HudFrame"
    HudFrame.Parent = ScreenGui
    HudFrame.AnchorPoint = Vector2.new(0.5, 0)
    HudFrame.Position = UDim2.new(0.5, 0, 0, 15)
    HudFrame.Size = UDim2.new(0, 0, 0, 26)
    HudFrame.AutomaticSize = Enum.AutomaticSize.X
    HudFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    HudFrame.BackgroundTransparency = 0.2
    HudFrame.BorderSizePixel = 0
    
    local HudCorner = Instance.new("UICorner")
    HudCorner.CornerRadius = UDim.new(0, 6)
    HudCorner.Parent = HudFrame
    
    local HudPadding = Instance.new("UIPadding")
    HudPadding.PaddingLeft = UDim.new(0, 12)
    HudPadding.PaddingRight = UDim.new(0, 12)
    HudPadding.Parent = HudFrame
    
    -- Обводка HUD
    local HudStroke = Instance.new("UIStroke")
    HudStroke.Color = Color3.fromRGB(138, 43, 226)
    HudStroke.Thickness = 1.2
    HudStroke.Parent = HudFrame
    
    -- Текст
    local HudText = Instance.new("TextLabel")
    HudText.Name = "HudText"
    HudText.Parent = HudFrame
    HudText.BackgroundTransparency = 1
    HudText.Size = UDim2.new(0, 0, 1, 0)
    HudText.AutomaticSize = Enum.AutomaticSize.X
    HudText.Font = Enum.Font.GothamSemibold
    HudText.Text = ""
    HudText.TextColor3 = Color3.fromRGB(220, 220, 220)
    HudText.TextSize = 13
    HudText.RichText = true
    
    local HudSettings = {
        Enabled = true,
        RGB = true,
        RGBSpeed = 3
    }
    
    VisualTab:CreateToggle({
        Name = "Отображать HUD",
        CurrentValue = true,
        Flag = "VisualHUDToggle",
        Callback = function(Value)
            HudFrame.Visible = Value
            HudSettings.Enabled = Value
        end
    })
    
    VisualTab:CreateToggle({
        Name = "Переливающийся HUD (RGB)",
        CurrentValue = true,
        Flag = "VisualHUDRGB",
        Callback = function(Value)
            HudSettings.RGB = Value
            if not Value then
                HudStroke.Color = Color3.fromRGB(138, 43, 226)
            end
        end
    })

    -- ==========================================
    -- CHINA HAT (Шляпа на себя)
    -- ==========================================
    local HatSettings = {
        Enabled = false,
        Color = Color3.fromRGB(60, 255, 150)
    }
    
    local ChinaHat = Instance.new("Part")
    ChinaHat.Name = "XCLIENT_ChinaHat"
    ChinaHat.Anchored = true
    ChinaHat.CanCollide = false
    ChinaHat.Material = Enum.Material.Neon
    ChinaHat.Transparency = 0.5
    ChinaHat.Size = Vector3.new(1.16, 0.46, 1.16) 
    ChinaHat.Color = HatSettings.Color
    
    local HatMesh = Instance.new("SpecialMesh", ChinaHat)
    HatMesh.MeshType = Enum.MeshType.FileMesh
    HatMesh.MeshId = "rbxassetid://1033714"
    HatMesh.Scale = Vector3.new(1.16, 0.46, 1.16)
    
    VisualTab:CreateToggle({
        Name = "China Hat (На себя)",
        CurrentValue = false,
        Flag = "ChinaHatToggle",
        Callback = function(Value)
            HatSettings.Enabled = Value
            if not Value then ChinaHat.Parent = nil end
        end
    })
    
    VisualTab:CreateColorPicker({
        Name = "Цвет China Hat",
        Color = Color3.fromRGB(60, 255, 150),
        Flag = "ChinaHatColor",
        Callback = function(Value)
            HatSettings.Color = Value
            ChinaHat.Color = Value
        end
    })

    -- ==========================================
    -- КАСТОМНЫЙ ПРИЦЕЛ (Crosshair)
    -- ==========================================
    local CrosshairSettings = {
        Enabled = false,
        Color = Color3.fromRGB(0, 255, 0),
        Size = 10,
        Gap = 5,
        Thickness = 2
    }
    
    local CrosshairFolder = Instance.new("Folder", ScreenGui)
    CrosshairFolder.Name = "Crosshair"
    
    local Lines = {}
    for i = 1, 4 do
        local Line = Instance.new("Frame", CrosshairFolder)
        Line.BorderSizePixel = 0
        Line.Visible = false
        table.insert(Lines, Line)
    end

    VisualTab:CreateToggle({
        Name = "Кастомный прицел",
        CurrentValue = false,
        Flag = "CrosshairToggle",
        Callback = function(Value)
            CrosshairSettings.Enabled = Value
            for _, line in ipairs(Lines) do line.Visible = Value end
        end
    })
    
    VisualTab:CreateColorPicker({
        Name = "Цвет прицела",
        Color = Color3.fromRGB(0, 255, 0),
        Flag = "CrosshairColor",
        Callback = function(Value) CrosshairSettings.Color = Value end
    })

    VisualTab:CreateSlider({
        Name = "Размер прицела",
        Range = {2, 50},
        Increment = 1,
        CurrentValue = 10,
        Flag = "CrosshairSize",
        Callback = function(Value) CrosshairSettings.Size = Value end
    })

    VisualTab:CreateSlider({
        Name = "Зазор прицела (Gap)",
        Range = {0, 30},
        Increment = 1,
        CurrentValue = 5,
        Flag = "CrosshairGap",
        Callback = function(Value) CrosshairSettings.Gap = Value end
    })

    VisualTab:CreateSlider({
        Name = "Толщина прицела",
        Range = {1, 10},
        Increment = 1,
        CurrentValue = 2,
        Flag = "CrosshairThickness",
        Callback = function(Value) CrosshairSettings.Thickness = Value end
    })

    -- ==========================================
    -- НАСТРОЙКА FOV (Угол обзора)
    -- ==========================================
    local FOVSettings = {
        Enabled = false,
        Value = 70
    }

    VisualTab:CreateToggle({
        Name = "Изменять угол обзора (FOV)",
        CurrentValue = false,
        Flag = "FOVToggle",
        Callback = function(Value)
            FOVSettings.Enabled = Value
            if not Value then 
                Camera.FieldOfView = 70 -- Сброс на стандартный FOV Roblox
            end
        end
    })

    VisualTab:CreateSlider({
        Name = "Значение FOV",
        Range = {30, 120},
        Increment = 1,
        CurrentValue = 70,
        Flag = "FOVValue",
        Callback = function(Value)
            FOVSettings.Value = Value
        end
    })

    -- ==========================================
    -- ШЕЙДЕРЫ И КРАСИВАЯ ГРАФИКА
    -- ==========================================
    local ShadersFolder = Instance.new("Folder")
    ShadersFolder.Name = "XCLIENT_Shaders"

    -- Bloom (свечение неоновых деталей)
    local Bloom = Instance.new("BloomEffect", ShadersFolder)
    Bloom.Intensity = 1.2
    Bloom.Size = 24
    Bloom.Threshold = 0.8

    -- ColorCorrection (сочность, контраст и яркость)
    local ColorCorr = Instance.new("ColorCorrectionEffect", ShadersFolder)
    ColorCorr.Contrast = 0.15
    ColorCorr.Saturation = 0.25
    ColorCorr.Brightness = 0.02

    -- SunRays (солнечные лучи)
    local SunRays = Instance.new("SunRaysEffect", ShadersFolder)
    SunRays.Intensity = 0.25

    VisualTab:CreateToggle({
        Name = "Кинематографичные шейдеры",
        CurrentValue = false,
        Flag = "ShadersToggle",
        Callback = function(Value)
            if Value then
                ShadersFolder.Parent = Lighting
            else
                ShadersFolder.Parent = nil
            end
        end
    })

    -- ==========================================
    -- РЕНДЕР ЦИКЛ И ЛОГИКА
    -- ==========================================
    local hue = 0
    local frames = 0
    local fps = 0
    
    task.spawn(function()
        while task.wait(1) do
            fps = frames
            frames = 0
        end
    end)

    RunService.RenderStepped:Connect(function(deltaTime)
        frames = frames + 1
        
        -- Обновление FOV
        if FOVSettings.Enabled then
            Camera.FieldOfView = FOVSettings.Value
        end
        
        -- Обновление HUD
        if HudSettings.Enabled then
            local ping = 0
            pcall(function()
                ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            
            if HudSettings.RGB then
                hue = hue + (deltaTime * (HudSettings.RGBSpeed / 10))
                if hue > 1 then hue = 0 end
                
                local rgbColor = Color3.fromHSV(hue, 1, 1)
                HudStroke.Color = rgbColor
                
                local hexColor = string.format("#%02X%02X%02X", rgbColor.R * 255, rgbColor.G * 255, rgbColor.B * 255)
                HudText.Text = string.format('<b><font color="%s">xclient</font></b> <font color="#A0A0A0">|</font> geragori <font color="#A0A0A0">|</font> %d fps <font color="#A0A0A0">|</font> %d ms', hexColor, fps, ping)
            else
                HudText.Text = string.format('<b><font color="#8A2BE2">xclient</font></b> <font color="#A0A0A0">|</font> geragori <font color="#A0A0A0">|</font> %d fps <font color="#A0A0A0">|</font> %d ms', fps, ping)
            end
        end

        -- Обновление China Hat
        if HatSettings.Enabled then
            local Character = LocalPlayer.Character
            if Character and Character:FindFirstChild("Head") and Character:FindFirstChild("Humanoid") and Character.Humanoid.Health > 0 then
                ChinaHat.Parent = workspace
                ChinaHat.CFrame = Character.Head.CFrame * CFrame.new(0, 0.8, 0)
            else
                ChinaHat.Parent = nil
            end
        end
        
        -- Обновление прицела
        if CrosshairSettings.Enabled then
            local Viewport = Camera.ViewportSize
            local CenterX = Viewport.X / 2
            local CenterY = Viewport.Y / 2
            
            local size = CrosshairSettings.Size
            local gap = CrosshairSettings.Gap
            local thick = CrosshairSettings.Thickness
            local color = CrosshairSettings.Color
            
            Lines[1].Size = UDim2.new(0, thick, 0, size)
            Lines[1].Position = UDim2.new(0, CenterX - thick / 2, 0, CenterY - gap - size)
            
            Lines[2].Size = UDim2.new(0, thick, 0, size)
            Lines[2].Position = UDim2.new(0, CenterX - thick / 2, 0, CenterY + gap)
            
            Lines[3].Size = UDim2.new(0, size, 0, thick)
            Lines[3].Position = UDim2.new(0, CenterX - gap - size, 0, CenterY - thick / 2)
            
            Lines[4].Size = UDim2.new(0, size, 0, thick)
            Lines[4].Position = UDim2.new(0, CenterX + gap, 0, CenterY - thick / 2)
            
            for _, line in ipairs(Lines) do
                line.BackgroundColor3 = color
            end
        end
    end)
end
