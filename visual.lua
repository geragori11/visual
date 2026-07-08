return function(Window)
    local VisualTab = Window:CreateTab("Visual", 4483362458)
    
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")
    local Lighting = game:GetService("Lighting")
    local UserInputService = game:GetService("UserInputService")
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

    -- ==========================================
    -- СТАРТОВЫЕ ЗНАЧЕНИЯ ДЛЯ ТЕКСТА ОКОН
    -- ==========================================
    local murdererName = "Searching..."
    local sheriffName = "Searching..."

    -- ==========================================
    -- НОВОЕ СЕРОЕ ПЕРЕТАСКИВАЕМОЕ ОКНО (WATERMARK)
    -- ==========================================
    local DragWindow = Instance.new("Frame")
    DragWindow.Name = "XCLIENTWaterMark"
    DragWindow.Parent = ScreenGui
    DragWindow.Position = UDim2.new(0.1, 0, 0.2, 0)
    DragWindow.Size = UDim2.new(0, 250, 0, 80) -- Высота 80 пикселей, чтобы всё поместилось
    DragWindow.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DragWindow.BorderSizePixel = 0
    DragWindow.Visible = true

    -- Скругление углов серого окна
    local WindowCorner = Instance.new("UICorner")
    WindowCorner.CornerRadius = UDim.new(0, 8)
    WindowCorner.Parent = DragWindow

    -- Обводка для красоты
    local WindowStroke = Instance.new("UIStroke")
    WindowStroke.Color = Color3.fromRGB(70, 70, 70)
    WindowStroke.Thickness = 1
    WindowStroke.Parent = DragWindow

    -- 1. ЗАГОЛОВОК ВНУТРИ ОКНА
    local WindowTitle = Instance.new("TextLabel")
    WindowTitle.Name = "Title"
    WindowTitle.Parent = DragWindow
    WindowTitle.Size = UDim2.new(1, 0, 0, 30)
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.Font = Enum.Font.GothamBold
    WindowTitle.Text = "XClient Info"
    WindowTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    WindowTitle.TextSize = 12

    -- 2. НАДПИСЬ МАРДЕРА
    local ExtraText = Instance.new("TextLabel")
    ExtraText.Name = "MurdererText"
    ExtraText.Parent = DragWindow 
    ExtraText.Position = UDim2.new(0, 12, 0, 30) -- Позиция под заголовком
    ExtraText.Size = UDim2.new(1, -24, 0, 25) 
    ExtraText.BackgroundTransparency = 1
    ExtraText.Font = Enum.Font.Gotham
    ExtraText.TextXAlignment = Enum.TextXAlignment.Left
    ExtraText.Text = "Murderer: " .. murdererName
    ExtraText.TextColor3 = Color3.fromRGB(255, 85, 85)
    ExtraText.TextSize = 12

    -- 3. НАДПИСЬ ШЕРИФА
    local ExtraText2 = Instance.new("TextLabel")
    ExtraText2.Name = "SheriffText"
    ExtraText2.Parent = DragWindow 
    ExtraText2.Position = UDim2.new(0, 12, 0, 52) -- Позиция под надписью мардера
    ExtraText2.Size = UDim2.new(1, -24, 0, 25) 
    ExtraText2.BackgroundTransparency = 1
    ExtraText2.Font = Enum.Font.Gotham
    ExtraText2.TextXAlignment = Enum.TextXAlignment.Left
    ExtraText2.Text = "Sheriff: " .. sheriffName
    ExtraText2.TextColor3 = Color3.fromRGB(85, 170, 255)
    ExtraText2.TextSize = 12


        -- 4. НАДПИСЬ Murder Mystery 2
    local ExtraText3 = Instance.new("TextLabel")
    ExtraText3.Name = "GameText"
    ExtraText3.Parent = DragWindow 
    ExtraText3.AnchorPoint = Vector2.new(0, 1) -- Точка привязки: левый нижний угол текста
    ExtraText3.Position = UDim2.new(0, 12, 1, -12) -- 12px от левого края, 12px от нижнего края
    ExtraText3.Size = UDim2.new(1, -24, 0, 25) 
    ExtraText3.BackgroundTransparency = 1
    ExtraText3.Font = Enum.Font.Gotham
    ExtraText3.TextXAlignment = Enum.TextXAlignment.Left
    ExtraText3.Text = "Murder Mystery 2 "
    ExtraText3.TextColor3 = Color3.fromRGB(85, 170, 255)
    ExtraText3.TextSize = 8

    -- Логика перетаскивания (Roblox-style)
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        DragWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    DragWindow.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = DragWindow.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    DragWindow.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    -- ==========================================
    
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
            DragWindow.Visible = Value 
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
                Camera.FieldOfView = 70
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

    local Bloom = Instance.new("BloomEffect", ShadersFolder)
    Bloom.Intensity = 1.2
    Bloom.Size = 24
    Bloom.Threshold = 0.8

    local ColorCorr = Instance.new("ColorCorrectionEffect", ShadersFolder)
    ColorCorr.Contrast = 0.15
    ColorCorr.Saturation = 0.25
    ColorCorr.Brightness = 0.02

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
    -- PEAK ASSISTANT (Помощник пиков)
    -- ==========================================
    local PeakSettings = {
        Enabled = false,
        ColorSafe = Color3.fromRGB(0, 255, 100),   -- Зеленый (Разрешено пикать)
        ColorUnsafe = Color3.fromRGB(255, 30, 30)  -- Красный (Запрещено / Опасно)
    }

    local PeakMarker = Instance.new("Part")
    PeakMarker.Name = "XCLIENT_PeakMarker"
    PeakMarker.Anchored = true
    PeakMarker.CanCollide = false
    PeakMarker.Shape = Enum.PartType.Cylinder
    PeakMarker.Size = Vector3.new(0.05, 5, 5)
    PeakMarker.Material = Enum.Material.Neon
    PeakMarker.Transparency = 0.5

    VisualTab:CreateToggle({
        Name = "Peak Assistant (Углы)",
        CurrentValue = false,
        Flag = "PeakAssistantToggle",
        Callback = function(Value)
            PeakSettings.Enabled = Value
            if not Value then PeakMarker.Parent = nil end
        end
    })

    -- Поиск Мардера по наличию ножа
    local function getMurderer()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hasKnife = p.Character:FindFirstChild("Knife") or (p:FindFirstChild("Backpack") and p.Backpack:FindFirstChild("Knife"))
                if hasKnife then
                    return p
                end
            end
        end
        return nil
    end

    -- Поиск Шерифа по наличию пистолета
    local function getSheriff()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hasGunItem = p.Character:FindFirstChild("Gun") or p.Character:FindFirstChild("Revolver") or 
                                   (p:FindFirstChild("Backpack") and (p.Backpack:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Revolver")))
                if hasGunItem then
                    return p
                end
            end
        end
        return nil
    end

    -- Проверка: есть ли у нас пистолет (Шериф / Герой)
    local function hasGun()
        local char = LocalPlayer.Character
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        
        local gunInChar = char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver"))
        local gunInBackpack = backpack and (backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver"))
        
        return not not (gunInChar or gunInBackpack)
    end

    -- Проверка нахождения за стеной/препятствием (на углу)
    local function isBehindWall(targetChar)
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return false end
        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return false end
        
        local origin = LocalPlayer.Character.HumanoidRootPart.Position
        local targetPos = targetChar.HumanoidRootPart.Position
        local direction = targetPos - origin
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, targetChar, ChinaHat, PeakMarker}
        
        local result = workspace:Raycast(origin, direction, raycastParams)
        return result ~= nil
    end

    -- Анализ траектории Мардера
    local function checkPeekCondition(targetChar)
        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return false end
        local targetHrp = targetChar.HumanoidRootPart
        local myHrp = LocalPlayer.Character.HumanoidRootPart
        
        local velocity = targetHrp.AssemblyLinearVelocity
        
        if velocity.Magnitude < 2 then
            return true
        end
        
        local toMeDirection = (myHrp.Position - targetHrp.Position).Unit
        local movementDirection = velocity.Unit
        local dotProduct = movementDirection:Dot(toMeDirection)
        
        if dotProduct > 0.85 then
            return true
        end
        
        return false
    end

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
        
        if FOVSettings.Enabled then
            Camera.FieldOfView = FOVSettings.Value
        end

        if PeakSettings.Enabled then
            local murderer = getMurderer()
            local myChar = LocalPlayer.Character
            local iHaveGun = hasGun()
            
            if murderer and myChar and myChar:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("Humanoid") and myChar.Humanoid.Health > 0 and iHaveGun then
                if isBehindWall(murderer.Character) then
                    PeakMarker.Parent = workspace
                    
                    local floorParams = RaycastParams.new()
                    floorParams.FilterType = Enum.RaycastFilterType.Exclude
                    floorParams.FilterDescendantsInstances = {myChar, murderer.Character, ChinaHat, PeakMarker}
                    
                    local floorRay = workspace:Raycast(myChar.HumanoidRootPart.Position, Vector3.new(0, -15, 0), floorParams)
                    if floorRay then
                        PeakMarker.CFrame = CFrame.new(floorRay.Position + Vector3.new(0, 0.05, 0)) * CFrame.Angles(0, 0, math.rad(90))
                    else
                        PeakMarker.CFrame = CFrame.new(myChar.HumanoidRootPart.Position - Vector3.new(0, 2.5, 0)) * CFrame.Angles(0, 0, math.rad(90))
                    end
                    
                    if checkPeekCondition(murderer.Character) then
                        PeakMarker.Color = PeakSettings.ColorSafe
                    else
                        PeakMarker.Color = PeakSettings.ColorUnsafe
                    end
                else
                    PeakMarker.Parent = nil
                end
            else
                PeakMarker.Parent = nil
            end
        end
        
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

        if HatSettings.Enabled then
            local Character = LocalPlayer.Character
            if Character and Character:FindFirstChild("Head") and Character:FindFirstChild("Humanoid") and Character.Humanoid.Health > 0 then
                ChinaHat.Parent = workspace
                ChinaHat.CFrame = Character.Head.CFrame * CFrame.new(0, 0.8, 0)
            else
                ChinaHat.Parent = nil
            end
        end
        
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

        -- ==========================================
        -- ОБНОВЛЕНИЕ НИРОВАННЫХ ДАННЫХ В ОКНЕ
        -- ==========================================
        local currentMurderer = getMurderer()
        if currentMurderer then
            ExtraText.Text = "Murderer: " .. currentMurderer.Name
        else
            ExtraText.Text = "Murderer: Searching..."
        end

        local currentSheriff = getSheriff()
        if currentSheriff then
            ExtraText2.Text = "Sheriff: " .. currentSheriff.Name
        else
            ExtraText2.Text = "Sheriff: Searching..."
        end
    end)
end
