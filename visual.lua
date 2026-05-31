return function(Window)
    local VisualTab = Window:CreateTab("Visual", 4483362458)
    
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    
    -- Создание HUD
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "XCLIENT_HUD"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    
    -- Защита GUI (CoreGui)
    local success = pcall(function()
        ScreenGui.Parent = CoreGui
    end)
    if not success then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    local Watermark = Instance.new("TextLabel")
    Watermark.Name = "WatermarkText"
    Watermark.Parent = ScreenGui
    Watermark.BackgroundTransparency = 1
    -- Позиция посередине сверху
    Watermark.AnchorPoint = Vector2.new(0.5, 0)
    Watermark.Position = UDim2.new(0.5, 0, 0, 15)
    Watermark.Size = UDim2.new(0, 200, 0, 30)
    Watermark.Font = Enum.Font.GothamBold
    Watermark.Text = "XCLIENT"
    Watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
    Watermark.TextSize = 24
    Watermark.TextXAlignment = Enum.TextXAlignment.Center -- Центрирование текста
    Watermark.TextStrokeTransparency = 0.5
    Watermark.Visible = true 
    
    VisualTab:CreateToggle({
        Name = "Отображать HUD (XCLIENT)",
        CurrentValue = true,
        Flag = "VisualHUDToggle",
        Callback = function(Value)
            Watermark.Visible = Value
        end
    })

    -- ==========================================
    -- CHINA HAT (Шляпа на себя)
    -- ==========================================
    local HatSettings = {
        Enabled = false,
        Color = Color3.fromRGB(60, 255, 150) -- Зеленоватый оттенок по умолчанию как на скрине
    }
    
    local ChinaHat = Instance.new("Part")
    ChinaHat.Name = "XCLIENT_ChinaHat"
    ChinaHat.Anchored = true
    ChinaHat.CanCollide = false
    ChinaHat.Material = Enum.Material.Neon
    ChinaHat.Transparency = 0.5 -- Сделано полупрозрачным для эффекта как в Minecraft
    ChinaHat.Size = Vector3.new(3.5, 0.7, 3.5) -- Более широкая и плоская форма
    ChinaHat.Color = HatSettings.Color
    
    local HatMesh = Instance.new("SpecialMesh", ChinaHat)
    HatMesh.MeshType = Enum.MeshType.FileMesh
    HatMesh.MeshId = "rbxassetid://1033714" -- ID правильного конуса
    HatMesh.Scale = Vector3.new(3.5, 0.7, 3.5) -- Растягиваем в стороны и сплющиваем
    
    VisualTab:CreateToggle({
        Name = "China Hat (На себя)",
        CurrentValue = false,
        Flag = "ChinaHatToggle",
        Callback = function(Value)
            HatSettings.Enabled = Value
            if not Value then
                ChinaHat.Parent = nil
            end
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
    -- [1] = Верх, [2] = Низ, [3] = Лево, [4] = Право

    VisualTab:CreateToggle({
        Name = "Кастомный прицел",
        CurrentValue = false,
        Flag = "CrosshairToggle",
        Callback = function(Value)
            CrosshairSettings.Enabled = Value
            for _, line in ipairs(Lines) do
                line.Visible = Value
            end
        end
    })
    
    VisualTab:CreateColorPicker({
        Name = "Цвет прицела",
        Color = Color3.fromRGB(0, 255, 0),
        Flag = "CrosshairColor",
        Callback = function(Value)
            CrosshairSettings.Color = Value
        end
    })

    VisualTab:CreateSlider({
        Name = "Размер прицела",
        Range = {2, 50},
        Increment = 1,
        CurrentValue = 10,
        Flag = "CrosshairSize",
        Callback = function(Value)
            CrosshairSettings.Size = Value
        end
    })

    VisualTab:CreateSlider({
        Name = "Зазор прицела (Gap)",
        Range = {0, 30},
        Increment = 1,
        CurrentValue = 5,
        Flag = "CrosshairGap",
        Callback = function(Value)
            CrosshairSettings.Gap = Value
        end
    })

    VisualTab:CreateSlider({
        Name = "Толщина прицела",
        Range = {1, 10},
        Increment = 1,
        CurrentValue = 2,
        Flag = "CrosshairThickness",
        Callback = function(Value)
            CrosshairSettings.Thickness = Value
        end
    })

    -- ==========================================
    -- РЕНДЕР ЦИКЛ (Обновление позиций каждый кадр)
    -- ==========================================
    RunService.RenderStepped:Connect(function()
        -- Обновление China Hat
        if HatSettings.Enabled then
            local Character = LocalPlayer.Character
            if Character and Character:FindFirstChild("Head") and Character:FindFirstChild("Humanoid") and Character.Humanoid.Health > 0 then
                ChinaHat.Parent = workspace
                -- Крепим ровно на макушку (0.8 стадов выше центра головы)
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
            
            -- Верхняя линия
            Lines[1].Size = UDim2.new(0, thick, 0, size)
            Lines[1].Position = UDim2.new(0, CenterX - thick / 2, 0, CenterY - gap - size)
            
            -- Нижняя линия
            Lines[2].Size = UDim2.new(0, thick, 0, size)
            Lines[2].Position = UDim2.new(0, CenterX - thick / 2, 0, CenterY + gap)
            
            -- Левая линия
            Lines[3].Size = UDim2.new(0, size, 0, thick)
            Lines[3].Position = UDim2.new(0, CenterX - gap - size, 0, CenterY - thick / 2)
            
            -- Правая линия
            Lines[4].Size = UDim2.new(0, size, 0, thick)
            Lines[4].Position = UDim2.new(0, CenterX + gap, 0, CenterY - thick / 2)
            
            for _, line in ipairs(Lines) do
                line.BackgroundColor3 = color
            end
        end
    end)
end
